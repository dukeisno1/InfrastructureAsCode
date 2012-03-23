#!/bin/bash
if [ $(echo $HOSTNAME | grep dmgrhost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the dmgrserver script will not run"
exit
fi
clear
rm -f /opt/websphere/dmgraliasinstall.txt
echo "This is the start time " >> /opt/websphere/dmgraliasinstall.txt
date >> /opt/websphere/dmgraliasinstall.txt
echo "Creating symbolic links on " $HOSTNAME
mkdir /var/websphere/dumps/$(hostname -s)
mkdir /var/websphere/dumps/$(hostname -s)/DVO1
mkdir /var/websphere/dumps/$(hostname -s)/DAISY1
mkdir /var/websphere/dumps/$(hostname -s)/IVAN1
mkdir /var/websphere/dumps/$(hostname -s)/INSIGHT1
cd /opt/websphere
ln -s /var/websphere/dumps/$(hostname -s) dumps
echo
echo "Installing base dmgr on " $HOSTNAME
/var/websphere/src/install/was7install/WAS/./install -options /var/websphere/src/install/was7install/responsefile/dmgrresponsefile_dmgralias.txt -silent
echo
echo "Verifying base dmgr install for " $HOSTNAME
if [ $(/opt/websphere/appserver7/profiles/Dmgr/bin/versionInfo.sh | grep Version | grep 7.0.0 | wc -l) -eq 0 ]; then
clear
echo "Base dmgr install failed for " $HOSTNAME
exit
else
echo 
/opt/websphere/appserver7/profiles/Dmgr/bin/versionInfo.sh | grep Version
fi
echo
echo "Starting the dmgr in order to install appserver for srv1alias "
/opt/websphere/appserver7/profiles/Dmgr/bin/./startManager.sh
echo
echo "Now installing appserver for srv1alias"
/opt/websphere/appserver7/bin/./manageprofiles.sh -create -profileName Appsrv -templatePath /opt/websphere/appserver7/profileTemplates/managed -nodeName appsrv01_node -startingPort 15100 -hostName srv1alias -dmgrHost dmgralias -dmgrPort 8879 >> /opt/websphere/dmgraliasinstall.txt
/opt/websphere/appserver7/profiles/Dmgr/bin/versionInfo.sh >> /opt/websphere/dmgraliasinstall.txt
/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh >> /opt/websphere/dmgraliasinstall.txt
echo
echo "Verifying appserver version"
if [ $(/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh | grep Version | grep 7.0.0 | wc -l) -eq 0 ]; then
clear
echo "Base appsrv install failed for " $HOSTNAME
exit
else
echo 
/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh | grep Version
fi
echo
echo "Stopping dmgr and node to prep for fixpack update"
/opt/websphere/appserver7/profiles/Dmgr/bin/./stopManager.sh
/opt/websphere/appserver7/profiles/Appsrv/bin/./stopNode.sh
sleep 10
/var/websphere/src/UpdateInstaller/./update.sh -silent -options /var/websphere/src/updates/700fplevel/was7/responsefiles/fpinstall.app.txt
/opt/websphere/appserver7/profiles/Dmgr/bin/versionInfo.sh >> /opt/websphere/dmgraliasinstall.txt
/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh >> /opt/websphere/dmgraliasinstall.txt
echo
echo "Verifying dmgr fixpack version"
if [ $(/opt/websphere/appserver7/profiles/Dmgr/bin/versionInfo.sh | grep Version | grep 7.0.0.fplevel | wc -l) -eq 0 ]; then
clear
echo "dmgr fixpack failed for " $HOSTNAME
exit
else
echo
/opt/websphere/appserver7/profiles/Dmgr/bin/versionInfo.sh | grep Version
fi
echo
echo "Verifying appserver fixpack"
if [ $(/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh | grep Version | grep 7.0.0.fplevel | wc -l) -eq 0 ]; then
clear
echo "appserver fixpack failed for " $HOSTNAME
exit
else
echo
/opt/websphere/appserver7/profiles/Appsrv/bin/versionInfo.sh | grep Version
fi
echo
echo "Starting dmgr and node"
/opt/websphere/appserver7/profiles/Dmgr/bin/./startManager.sh
/opt/websphere/appserver7/profiles/Appsrv/bin/./startNode.sh
echo
echo " This is the end time " >> /opt/websphere/dmgraliasinstall.txt
date >> /opt/websphere/dmgraliasinstall.txt
ps -ef | grep dmgr | grep -v grep
ps -ef | grep nodeagent | grep -v grep