#!/bin/bash
if [ $(echo $HOSTNAME | grep srv2host | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the appserver script will not run"
exit
fi
clear
rm -f /opt/websphere/srv2aliasinstall.txt
echo "creating symbolic links on" $HOSTNAME
echo
echo " This is the start time " >> /opt/websphere/srv2aliasinstall.txt 
date >> /opt/websphere/srv2aliasinstall.txt
mkdir /var/websphere/dumps/$(hostname -s)
mkdir /var/websphere/dumps/$(hostname -s)/DVO2
mkdir /var/websphere/dumps/$(hostname -s)/DAISY2
mkdir /var/websphere/dumps/$(hostname -s)/IVAN2
mkdir /var/websphere/dumps/$(hostname -s)/INSIGHT2
cd /opt/websphere
ln -s /var/websphere/dumps/$(hostname -s) dumps
echo
echo "Installing appserver base on" $HOSTNAME
/var/websphere/src/install/was7install/WAS/./install -options /var/websphere/src/install/was7install/responsefile/appsrvresponsefile_srv2alias.txt -silent
echo
echo "Stopping node to prep for fixpackupgrade on" $HOSTNAME
/opt/websphere/appserver7/profiles/Appsrv/bin/./stopNode.sh
/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh >> /opt/websphere/srv2aliasinstall.txt
echo "Verifying base install"
if [ $(/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh | grep Version | grep 7.0.0 | wc -l) -eq 0 ]; then
clear
echo "Base appsrv install failed for " $HOSTNAME
exit
else
echo 
/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh | grep Version
fi
/var/websphere/src/UpdateInstaller/./update.sh -silent -options /var/websphere/src/updates/700fplevel/was7/responsefiles/fpinstall.app.txt
echo "Verifying fixpack install"
if [ $(/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh | grep Version | grep 7.0.0.fplevel | wc -l) -eq 0 ]; then
clear
echo "Fixpack failed for " $HOSTNAME
exit
else
echo
/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh | grep Version
fi
/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh >> /opt/websphere/srv2aliasinstall.txt >> /opt/websphere/srv2aliasinstall.txt
echo "starting node"
/opt/websphere/appserver7/profiles/Appsrv/bin/./startNode.sh
echo
echo " This is the end time " >> /opt/websphere/srv2aliasinstall.txt
date >> /opt/websphere/srv2aliasinstall.txt
ps -ef | grep nodeagent | grep -v grep