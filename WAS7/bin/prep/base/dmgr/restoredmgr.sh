#!/bin/bash
if [ $(echo $HOSTNAME | grep dmgrhost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the dmgrserver script will not run"
exit
fi
if [ $(ps -ef | grep java | grep was7_Cell | grep -v grep | wc -l) -gt 0 ]; then
ps -ef | grep java | grep was7_Cell | grep -v grep | awk '{print $2}'| xargs kill -9
fi
echo "Restoring original Config files to /var/websphere/src/install/backups/"
/opt/websphere/appserver7/profiles/Dmgr/bin/./restoreConfig.sh /var/websphere/src/install/backups/$(hostname -s).dmgralias.originalConfig.zip
/opt/websphere/appserver7/profiles/Appsrv/bin/./restoreConfig.sh /var/websphere/src/install/backups/$(hostname -s).srv1alias.originalConfig.zip