#!/bin/bash
if [ $(echo $HOSTNAME | grep srv2host | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the appserver script will not run"
exit
fi
if [ $(ps -ef | grep java | grep was7_Cell | grep -v grep | wc -l) -gt 0 ]; then
ps -ef | grep java | grep was7_Cell | grep -v grep | awk '{print $2}'| xargs kill -9
fi
echo "Restore Config files from /var/websphere/src/install/backups/"
/opt/websphere/appserver7/profiles/Appsrv/bin/./restoreConfig.sh /var/websphere/src/install/backups/$(hostname -s).srv2alias.originalConfig.zip