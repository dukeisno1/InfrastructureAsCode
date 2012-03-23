#!/usr/bin/ksh
if [ $(echo $HOSTNAME | grep dmgrhost | wc -l) -eq 0 ]; then
echo $HOSTNAME " is not the Dmanager server script will not run"
exit
else

echo "starting  Dmanager"
Dmgr=/opt/websphere/appserver7/profiles/Dmgr
$Dmgr/bin/./startManager.sh
sleep 60
echo "starting NodeAgent appsrv01_node"

Node_Agent=/opt/websphere/appserver7/profiles/Appsrv

$Node_Agent/bin/./startNode.sh

echo "done "
sleep 60

echo "start  all servers on  Nodeagent appsrv01_node"
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/start_stop_services/py/start_01_node.py
echo "done"

echo "checking the server status"
sleep 60
$Node_Agent/bin/./serverStatus.sh -all


fi
echo $0 " script has completed successfully"

