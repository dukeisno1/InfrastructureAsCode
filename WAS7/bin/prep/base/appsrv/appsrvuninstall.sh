#!/bin/bash
if [ $(echo $HOSTNAME | grep srv2host | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the appserver script will not run"
exit
fi
clear
echo " stopping services on " $HOSTNAME 
/opt/websphere/appserver7/profiles/Appsrv/bin/./stopNode.sh
if [ $(ps -ef | grep java | grep was7_Cell | grep -v grep | wc -l) -gt 0 ]; then
ps -ef | grep java | grep was7_Cell | grep -v grep | awk '{print $2}'| xargs kill -9
fi
echo " uninstalling appserver on " $HOSTNAME 
/opt/websphere/appserver7/uninstall/./uninstall -silent -OPT removeProfilesOnUninstall="true"
echo " deleting directories "
rm -rf /opt/websphere/appserver7
echo
echo "Deleting dumps"
/var/websphere/dumps/$(hostname -s)
echo
echo " unlinking dumps "
cd /opt/websphere
unlink dumps
echo " verify any java process for wsadm "
ps -ef | grep java | grep -v grep | grep wsadm
