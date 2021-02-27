import os, sys, json, time, datetime
import logging, argparse
import requests
logging.basicConfig(
        filename='application_failures.log',
        format='%(asctime)s %(levelname)-8s %(message)s',
        level=logging.INFO,
        datefmt='%Y-%m-%d %H:%M:%S'
    )

headers = {'content-type': 'application/json', 'Accept': 'application/json'}

def help_parser():

    parser = argparse.ArgumentParser(
        description='Standard Arguments for talking to vCenter or ESXi')
    parser.add_argument('--pc',
                        required=True,
                        action='store',
                        help='vSphere service to connect to')
    parser.add_argument('--port',
                        type=int,
                        default=9440,
                        action='store',
                        help='Port to connect on')
    parser.add_argument('--user',
                        required=True,
                        action='store',
                        help='User name to use when connecting to pc')
    parser.add_argument('--password',
                        required=True,
                        action='store',
                        help='Password to use when connecting to pc')
    return parser

### --------------------------------------------------------------------------------- ###
def get_all_apps(base_url, auth):
    method = 'POST'
    url = base_url + "/apps/list"
    resp = None
    apps_list = []
    payload = {
    	"length":250,
    	"offset":0,
    	"filter":"_state==error"
    }
    try:
        resp = requests.request(
            method,
            url,
            data=json.dumps(payload),
            headers=headers,
            auth=(auth["username"], auth["password"]),
            verify=False
        )
    except requests.exceptions.ConnectionError as e:
        logging.error("Failed to connect to PC: {}".format(e))
        sys.exit(1)
    finally:
        if resp.ok:
            json_resp = resp.json()
            if json_resp['metadata']['total_matches'] > 0:
                return json_resp["entities"]
            else:
                logging.error("There are no failed apps.")
                sys.exit(1)
        else:
            logging.error("Request failed")
            logging.error("Headers: {}".format(headers))
            logging.error('Status code: {}'.format(resp.status_code))
            logging.error('Response: {}'.format(json.dumps(json.loads(resp.content), indent=4)))
            sys.exit(1)

### --------------------------------------------------------------------------------- ###
def get_application(base_url, auth, app_uuid):
    method = 'GET'
    url = base_url + "/apps/{}".format(app_uuid)
    resp = None
    try:
        resp = requests.request(
            method,
            url,
            headers=headers,
            auth=(auth["username"], auth["password"]),
            verify=False
        )
    except requests.exceptions.ConnectionError as e:
        logging.error("Failed to connect to PC: {}".format(e))
        sys.exit(1)
    finally:
        if resp.ok:
            return resp.json()
        else:
            logging.error("Request failed")
            logging.error("Headers: {}".format(headers))
            logging.error('Status code: {}'.format(resp.status_code))
            logging.error('Response: {}'.format(json.dumps(json.loads(resp.content), indent=4)))
            sys.exit(1)

### --------------------------------------------------------------------------------- ###
if __name__ == "__main__":
    parser = help_parser().parse_args()
    pc_ip = parser.pc
    pc_port = parser.port
    base_url = "https://{}:{}/api/nutanix/v3".format(pc_ip,str(pc_port))
    auth = { "username": parser.user, "password": parser.password}

    apps_list = get_all_apps(base_url, auth)
    for app in apps_list:
        if datetime.datetime.fromtimestamp(app["status"]["last_update_time"] / 1e6) > (datetime.datetime.now() - datetime.timedelta(minutes = 15)):
            print(app["metadata"]["name"])
                
