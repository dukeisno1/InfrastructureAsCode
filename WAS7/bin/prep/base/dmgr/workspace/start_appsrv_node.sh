if [ $(echo $HOSTNAME | grep srv2host | wc -l) -eq 0 ]; then
echo $HOSTNAME " is not the second app server script will not run"
exit
else

echo "Starting NodeAgent appsrv02node on srv2alias"

Node_Agent=/opt/websphere/appserver7/profiles/Appsrv

$Node_Agent/bin/./startNode.sh
echo
echo "done"
sleep 60
echo
echo "Starting Nodeagent appsrv02_node servers on srv2alias"

/opt/websphere/appserver7/profiles/Appsrv/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/start_stop_services/py/start_02_node.py
echo "done"
sleep 100
$Node_Agent/bin/./serverStatus.sh -all
fi
echo $0 " script has completed successfully"
