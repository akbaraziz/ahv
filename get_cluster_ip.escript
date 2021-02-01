# Author:      Akim Sissaoui
# Action:      Create
# Name:        10_Get_Cluster_IP
# Type:        Set Variable
# Script Type: eScript
# Variable:    cluster_ip (string)  IP address of the cluster where the VM
#                                   reside. Used for API calls to Prism Element
# Description: Retrieves the IP of the target cluster where the VMs
#              are deployed
# Script:
payload = {
  "kind": "cluster",
  "api_version": "3.1.0"
}
api_url = 'https://localhost:9440/api/nutanix/v3/clusters/@@{platform.status.cluster_reference.uuid}@@'
headers = {'Content-Type': 'application/json',  'Accept':'application/json'}
r = urlreq(api_url, verb='GET', auth="BASIC", user='@@{pc_cred.username}@@', passwd='@@{pc_cred.secret}@@', params=json.dumps(payload), headers=headers, verify=False)
if r.ok:
    resp = json.loads(r.content)
else:
    print "Post request failed", r.content
    exit(1)
# Pass variable to calm
print('cluster_ip = %s' % resp['spec']['resources']['network']['external_ip'])