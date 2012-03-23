#!/bin/bash
if [ $(echo $HOSTNAME | grep ihshost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME "is not the IHS server script will not run"
exit
fi
clear
echo "Stopping services "
/opt/websphere/ibmihs7/bin/./adminctl stop
/opt/websphere/ibmihs7/bin/./apachectl stop
sleep 15
if [ $(ps -ef | grep http | grep /opt/websphere | grep -v grep | wc -l) -gt 0 ]; then
ps -ef | grep http | grep /opt/websphere | grep -v grep | awk '{print $2}'| xargs kill -9
exit
fi
echo "Confirm process have stopped"
ps -ef | grep http | grep /opt/websphere | grep -v grep
echo $0 " script has completed"