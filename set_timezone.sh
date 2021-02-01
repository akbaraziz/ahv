# Set Time Zone
ncli cluster set-timezone "timezone=America/New York"
ncli cluster set-timezone timezone=America/Chicago

# Set NTP Servers
ncli cluster add-to-ntp-servers servers=0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.ntp.org,4.pool.ntp.org

# Get List of NTP Servers
ncli cluster get-ntp-servers

# Verify NTP Synchronization
allssh ntpq -p

# After changing Time Zone, restart Services
cluster stop
allssh genesis stop all
allssh genesis start
cluster start