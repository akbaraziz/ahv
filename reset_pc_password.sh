#!/bin/bash

set -ex

sudo /usr/local/nutanix/cluster/bin/cluster_sync restart

# Reset Prism Central Password
ncli user reset-password user-name="admin" password="Nutanix/1234"