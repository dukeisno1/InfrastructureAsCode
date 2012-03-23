#!/bin/bash
if [ $(echo $HOSTNAME | grep ihshost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME "is not the IHS server script will not run"
exit
fi
clear
echo "Script is running now"
echo "Stopping services "
/opt/websphere/ibmihs7/bin/./apachectl stop
/opt/websphere/ibmihs7/bin/./adminctl stop
if [ $(ps -ef | grep http | grep wsadm | grep -v grep | wc -l) -gt 0 ]; then
ps -ef | grep http | grep wsadm | grep -v grep | awk '{print $2}'| xargs kill -9
fi
echo "Uninstalling plugins "
/opt/websphere/ibmihs7/Plugins/uninstall/./uninstall -silent
echo "Uninstalling ihs "
/opt/websphere/ibmihs7/uninstall/./uninstall -silent
rm -rf /opt/websphere/ibmihs7
ps -ef | grep http | grep -v grep
echo $0 " script has completed successfully"