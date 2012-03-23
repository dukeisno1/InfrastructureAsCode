#!/usr/bin/ksh
if [ $(echo $HOSTNAME | grep dmgrhost | wc -l) -eq 0 ]; then
echo $HOSTNAME " is not the Dmanager server script will not run"
exit
fi

echo "Stopping Nodeagent appsrv01_node servers on srv1alias"

/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/start_stop_services/py/stop_01_node.py
echo "done"
sleep 100
echo "Stopping NodeAgent appsrv01_node on srv1alias"

Node_Agent=/opt/websphere/appserver7/profiles/Appsrv

$Node_Agent/bin/./stopNode.sh

echo "done"

echo "Stopping Dmanager on srv1alias"
Dmgr=/opt/websphere/appserver7/profiles/Dmgr
$Dmgr/bin/./stopManager.sh

if [ $(ps -ef | grep java | grep was7_Cell | grep -v grep | wc -l) -gt 0 ]; then
ps -ef | grep java | grep was7_Cell | grep -v grep | awk '{print $2}'| xargs kill -9
else
echo "done nothing running"
ps -ef | grep java | grep was7_Cell | grep -v grep

fi
echo $0 " script has completed successfully"
