#!/bin/bash
if [ $(echo $HOSTNAME | grep dmgrhost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the dmgr server script will not run"
exit
fi
echo "Creating unmanaged node ie webserver"
echo
echo
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/workspace/py/ihsalias.py
exit_code1=$?
if [ "$exit_code1" -ne "0" ]; then
echo "ihsalias.py failed "
echo "Check http://dmgrhost:9060/ibm/console/unsecureLogon.jsp to see if the node and or webserver was added, manual removal may be required before rerunning or manually adding"
echo
exit
fi
echo $0 " script has completed successfully"
echo
echo "Please logon to http://dmgrhost:9060/ibm/console/unsecureLogon.jsp and verify"