#!/bin/bash
clear
echo "Removing old runfirst.txt file"
rm -rf /var/websphere/runfirst.txt
echo " This is the start time " >> /var/websphere/runfirst.txt
date >> /var/websphere/runfirst.txt
if [ $(ls /var/websphere/src | wc -l) -gt 0 ]; then
clear
echo "You might have already run this script."
echo
echo "Here is what's under the /var/websphere/src folder"
ls /var/websphere/src
echo
echo "Make sure $HOSTNAME is the intended dmgr server then perhaps do a mv /var/websphere/src src.$(date +%F)"
echo
echo "Before doing a backup Please consider that the space you currently have for /var/websphere is"
echo
df -h | grep /var/websphere
exit
fi
echo "Enter environment for WAS 7 install example: tst, qa or prd"
echo "this will create the folder needed for backups"
read environ
if [ $(ls -d /var/websphere/*backups | wc -l) -gt 0 ]; then
clear
echo "You might have already run this script." 
echo
echo "Here is what's under the /var/websphere/*backups dir"
ls -d /var/websphere/*backups
echo
echo "Make sure $HOSTNAME is the intended dmgr server then perhaps do a backup of the above folder"
echo
echo " Before doing a backup Please consider that the space you currently have for /var/websphere is"
echo
df -h | grep /var/websphere
exit
fi
####################
# making base dirs #
####################
echo "making base dirs"
mkdir /var/websphere/was7$environ'_backups'
mkdir /var/websphere/was7$environ'_backups'/config_bk
mkdir /var/websphere/was7$environ'_backups'/properties_bk
mkdir /var/websphere/dumps
mkdir /var/websphere/src
mkdir /var/websphere/src/install
mkdir /var/websphere/src/install/backups
mkdir /var/websphere/src/updates
mkdir /var/websphere/src/install/bin
mkdir /var/websphere/src/install/was7install
mkdir /var/websphere/src/install/ihs_plugin_install
mkdir /var/websphere/src/install/updateinstall
#mkdir /var/websphere/src/install/bin/start_stop_services
###########################
# creating temp variables #
##########################
echo "creating temp variables"
was7stage=/var/websphere/was7stage
was7install=/var/websphere/src/install/was7install
ihs_plugin_install=/var/websphere/src/install/ihs_plugin_install
updateinstall=/var/websphere/src/install/updateinstall
#####################################
# untar and unzipping install files #
####################################
echo "untar and unzipping install files"
tar -zxvf $was7stage/C1G35ML.tar.gz -C $was7install/
tar -zxvf $was7stage/C1G36ML.tar.gz -C $ihs_plugin_install/
unzip $was7stage/7.0.0.21-WS-UPDI-LinuxAMD64.zip -d $updateinstall/
############################
# making responsefile dirs #
###########################
echo "making responsefile dirs"
mkdir $was7install/responsefile
mkdir $ihs_plugin_install/responsefile
mkdir $updateinstall/responsefile
###############################
# copying base response files #
##############################
#echo " copying base response file "
#cp $was7stage/responsefiles/appsrvresponsefile_base.txt $was7install/responsefile/
#cp $was7stage/responsefiles/dmgrresponsefile_base.txt $was7install/responsefile/
#cp $was7stage/responsefiles/ihsresponsefile_base.txt $ihs_plugin_install/responsefile/
#cp $was7stage/responsefiles/updateinstall_all* $updateinstall/responsefile/
#########################################
# copying bin dir updates dir  to install root path #
#######################################
echo "copying bin dir to install root path"
cp -r $was7stage/bin/* /var/websphere/src/install/bin/
cp -r $was7stage/updates/* /var/websphere/src/updates/
echo " This is the end time " >> /var/websphere/runfirst.txt
date >> /var/websphere/runfirst.txt
echo $0 " script has completed successfully"
