if [ $(echo $HOSTNAME | grep srv2host | wc -l) -eq 0 ]; then
echo $HOSTNAME " is not the second server script will not run"
exit
fi

echo "Stopping Nodeagent appsrv02_node servers on srv2alias"

/opt/websphere/appserver7/profiles/Appsrv/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/start_stop_services/py/stop_02_node.py
echo "done"
sleep 100
echo "stop  NodeAgent appsrv02node"

Node_Agent=/opt/websphere/appserver7/profiles/Appsrv

$Node_Agent/bin/./stopNode.sh

ps -ef | grep java | grep was7_Cell | grep -v grep | awk '{print $2}'


if [ $(ps -ef | grep java | grep was7_Cell | grep -v grep | wc -l) -gt 0 ]; then
ps -ef | grep java | grep was7_Cell | grep -v grep | awk '{print $2}'| xargs kill -9
else
echo "done nothing running"
ps -ef | grep java | grep was7_Cell | grep -v grep

fi
echo $0 " script has completed successfully"

