#!/bin/bash
if [ $(echo $HOSTNAME | grep dmgrhost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the dmgrserver script will not run"
exit
fi
clear
echo "Stopping services on  " $HOSTNAME 
/opt/websphere/appserver7/profiles/Dmgr/bin/./stopManager.sh
/opt/websphere/appserver7/profiles/Appsrv/bin/./stopNode.sh
if [ $(ps -ef | grep java | grep was7_Cell | grep -v grep | wc -l) -gt 0 ]; then
ps -ef | grep java | grep was7_Cell | grep -v grep | awk '{print $2}'| xargs kill -9
fi
echo "Uninstalling dmgr and appserver on " $HOSTNAME 
/opt/websphere/appserver7/uninstall/./uninstall -silent -OPT removeProfilesOnUninstall="true"
rm -rf /opt/websphere/appserver7
echo "Deleting dumps"
rm -rf /var/websphere/dumps/$(hostname -s)
echo
echo "unlinking dumps "
cd /opt/websphere
unlink dumps
ps -ef | grep java | grep -v grep