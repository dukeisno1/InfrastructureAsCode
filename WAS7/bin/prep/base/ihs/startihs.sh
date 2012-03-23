#!/bin/bash
if [ $(echo $HOSTNAME | grep ihshost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME "is not the IHS server script will not run"
exit
fi
clear
echo "Starting services "
/opt/websphere/ibmihs7/bin/./adminctl start
/opt/websphere/ibmihs7/bin/./apachectl start
sleep 5
ps -ef | grep http | grep /opt/websphere | grep -v grep
echo $0 " script has completed"