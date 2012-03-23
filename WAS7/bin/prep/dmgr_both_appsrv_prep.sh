#!/bin/bash
clear
echo "Enter the dmgr host name "
read dmgrhost
echo
echo "Enter the dmgr alias "
read dmgralias
echo
echo "Enter the Appserver alias for " $dmgrhost
read srv1alias
echo
echo "Enter second Appserver host name"
read srv2host
echo
echo "Enter second Appserver alias for " $srv2host
read srv2alias
echo
ls /var/websphere/src/updates
echo "Type last 2 digits for fixpack you wish to apply"
read fplevel
clear
echo "For the dmgr host you typed " $dmgrhost
echo "For the dmgr alias you typed " $dmgralias
echo "For the first Appserver alias you typed " $srv1alias
echo "For the second Appserver host you typed " $srv2host
echo "For the second Appserver alias you typed " $srv2alias
echo "For the patch level you typed " $fplevel
echo
echo "Type y if this is correct, any other response will exit program"
read answer
if [[ "$answer" != "y" ]]
then
clear
echo "Program is exiting  "
exit
fi
clear
echo "Running extra step install confirmation "
if [ $(ls /var/websphere/src/updates/700$fplevel | wc -l) -eq 0 ]; then
clear
echo $fplevel " does not exist"
exit
fi
if [ $(nslookup $dmgralias | grep $dmgrhost | wc -l) -eq 0 ]; then
clear
echo "For dmgr host you typed " $dmgrhost
echo "For dmgr alias you typed " $dmgralias
echo
echo "Something isnt right confirm the dmgr host against dmgr alias"
exit
fi
if [ $(nslookup $srv1alias | grep $dmgrhost | wc -l) -eq 0 ]; then
clear
echo "For dmgr host you typed" $dmgrhost
echo "For the first appserver alias you typed" $srv1alias
echo
echo "Something isnt right confirm the dmgr host against first appserver alias"
exit
fi
if [ $(nslookup $srv2alias | grep $dmgrhost | wc -l) -gt 0 ]; then
clear
echo "For dmgr host you typed" $dmgrhost
echo "For second appserver alias you typed" $srv2alias
echo
echo "Something isnt right confirm. Remember that the second appserver alias should be on a differnt host"
exit
fi

if [ $(nslookup $srv2alias | grep $srv2host | wc -l) -eq 0 ]; then
clear
echo "For second appserver host you typed " $srv2host
echo "For second appserver alias you typed " $srv2alias
echo
echo "Something isnt right confirm the second appsserver host against its alias"
exit
fi
if [ $(echo $dmgralias | grep dm | wc -l) -eq 0 ]; then
clear
echo "For dmgr host you typed " $dmgralias
echo
echo "This may not be dmgr alias"
exit
fi

clear
base=/var/websphere/src/install/bin/prep/base
install=/var/websphere/src/install/bin/install
uninstall=/var/websphere/src/install/bin/uninstall
workspace=/var/websphere/src/install/bin/workspace
startstop=/var/websphere/src/install/bin/start_stop_services

echo "Doing pre-run clean up "
rm -f $uninstall/dmgruninstall_$dmgralias.sh
rm -f $install/dmgrinstall_$dmgralias.sh
rm -r /var/websphere/src/install/was7install/responsefile/dmgrresponsefile_$dmgralias.txt
rm -f $workspace/*$dmgralias.sh
rm -f $uninstall/appsrvuninstall_$srv2alias.sh
rm -f $install/appsrvinstall_$srv2alias.sh
rm -r /var/websphere/src/install/was7install/responsefile/appsrvresponsefile_$srv2alias.txt
rm -f $workspace/*$srv2alias.sh
rm -f /var/websphere/src/install/"$dmgralias"_"$srv2alias"was7_script_list.txt

echo "Creating new uninstall script"
echo
cp $base/dmgr/dmgruninstall.sh $uninstall/dmgruninstall_$dmgralias.sh
cp $base/appsrv/appsrvuninstall.sh $uninstall/appsrvuninstall_$srv2alias.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' $uninstall/dmgruninstall_$dmgralias.sh
sed -i 's/srv2host/'$srv2host'/g' $uninstall/appsrvuninstall_$srv2alias.sh


echo "Creating new install script "
echo
cp $base/dmgr/dmgrinstall.sh $install/dmgrinstall_$dmgralias.sh
cp $base/appsrv/appsrvinstall.sh $install/appsrvinstall_$srv2alias.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' $install/dmgrinstall_$dmgralias.sh
sed -i 's/dmgralias/'$dmgralias'/g' $install/dmgrinstall_$dmgralias.sh
sed -i 's/fplevel/'$fplevel'/g' $install/dmgrinstall_$dmgralias.sh
sed -i 's/srv1alias/'$srv1alias'/g' $install/dmgrinstall_$dmgralias.sh
sed -i 's/srv2host/'$srv2host'/g' $install/appsrvinstall_$srv2alias.sh
sed -i 's/fplevel/'$fplevel'/g' $install/appsrvinstall_$srv2alias.sh
sed -i 's/srv2alias/'$srv2alias'/g' $install/appsrvinstall_$srv2alias.sh


echo "Creating new responsefile "
echo
cp $base/dmgr/dmgrresponsefile_base.txt /var/websphere/src/install/was7install/responsefile/dmgrresponsefile_$dmgralias.txt
cp $base/appsrv/appsrvresponsefile_base.txt /var/websphere/src/install/was7install/responsefile/appsrvresponsefile_$srv2alias.txt
sed -i 's/dmgralias/'$dmgralias'/g' /var/websphere/src/install/was7install/responsefile/dmgrresponsefile_$dmgralias.txt
sed -i 's/dmgrhost/'$dmgrhost'/g' /var/websphere/src/install/was7install/responsefile/appsrvresponsefile_$srv2alias.txt
sed -i 's/srv2alias/'$srv2alias'/g' /var/websphere/src/install/was7install/responsefile/appsrvresponsefile_$srv2alias.txt


echo "Creating new workspace script"
echo
cp $base/dmgr/workspace/workspace.sh $workspace/workspace_$dmgralias.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' $workspace/workspace_$dmgralias.sh
sed -i 's/dmgralias/'$dmgralias'/g' $workspace/workspace_$dmgralias.sh


echo "Creating new backup.sh script"
cp $base/dmgr/backupdmgr.sh $install/bk_restore/backupdmgr_$srv1alias.sh
cp $base/appsrv/backupapp.sh $install/bk_restore/backupapp_$srv2alias.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' $install/bk_restore/backupdmgr_$srv1alias.sh
sed -i 's/dmgralias/'$dmgralias'/g' $install/bk_restore/backupdmgr_$srv1alias.sh
sed -i 's/srv1alias/'$srv1alias'/g' $install/bk_restore/backupdmgr_$srv1alias.sh
sed -i 's/srv2host/'$srv2host'/g' $install/bk_restore/backupapp_$srv2alias.sh
sed -i 's/srv2alias/'$srv2alias'/g' $install/bk_restore/backupapp_$srv2alias.sh

echo "Creating new restore script "
echo
cp $base/dmgr/restoredmgr.sh $install/bk_restore/restoredmgr_$srv1alias.sh
cp $base/appsrv/restoreapp.sh $install/bk_restore/restoreapp_$srv2alias.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' $install/bk_restore/restoredmgr_$srv1alias.sh
sed -i 's/dmgralias/'$dmgralias'/g' $install/bk_restore/restoredmgr_$srv1alias.sh
sed -i 's/srv1alias/'$srv1alias'/g' $install/bk_restore/restoredmgr_$srv1alias.sh
sed -i 's/srv2host/'$srv2host'/g' $install/bk_restore/restoreapp_$srv2alias.sh
sed -i 's/srv2alias/'$srv2alias'/g' $install/bk_restore/restoreapp_$srv2alias.sh
echo

echo "Copying and editing the start and stop services scripts for " $dmgralias
cp $base/dmgr/workspace/stop_dmgr_node.sh $startstop/stopall_$dmgralias.sh
cp $base/dmgr/workspace/start_dmgr_node.sh $startstop/startall_$dmgralias.sh
cp $base/dmgr/workspace/start_appsrv_node.sh $startstop/startall_$srv2alias.sh
cp $base/dmgr/workspace/stop_appsrv_node.sh $startstop/stopall_$srv2alias.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' $startstop/stopall_$dmgralias.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' $startstop/startall_$dmgralias.sh
sed -i 's/srv1alias/'$srv1alias'/g' $startstop/stopall_$dmgralias.sh
sed -i 's/srv1alias/'$srv1alias'/g' $startstop/startall_$dmgralias.sh
sed -i 's/srv2host/'$srv2host'/g' $startstop/stopall_$srv2alias.sh
sed -i 's/srv2host/'$srv2host'/g' $startstop/startall_$srv2alias.sh
sed -i 's/srv2alias/'$srv2alias'/g' $startstop/stopall_$srv2alias.sh
sed -i 's/srv2alias/'$srv2alias'/g' $startstop/startall_$srv2alias.sh
echo
echo "Creating script list for later reference if needed"
echo " The following are a list of scripts created from $0

#########################
# Uninstall script list #
#########################

  Run from the $dmgralias server
    $uninstall/./dmgruninstall_$dmgralias.sh

  Run from the $srv2alias server
    $uninstall/./appsrvuninstall_$srv2alias.sh

#######################
# Install script list #
#######################

  Run from the $dmgralias server
    $install/./dmgrinstall_$dmgralias.sh

  Run from the $srv2alias server
    $install/./appsrvinstall_$srv2alias.sh

#####################
# Workspace scripts #
#####################

  Run from the $dmgralias server
    $workspace/./workspace_$dmgralias.sh
   
#########################################################
# Backup scripts to be used only during install process #
#########################################################

  Run from the $dmgralias server
    $install/bk_restore/./backupdmgr_$srv1alias.sh

  Run from the $srv2alias server
    $install/bk_restore/./backupapp_$srv2alias.sh

##########################################################
# Restore scripts to be used only during install process #
#########################################################

  Run from $dmgralias server
    $install/bk_restore/./restoredmgr_$srv1alias.sh

  Run from the $srv2alias server
    $install/bk_restore/./restoreapp_$srv2alias.sh

###################################
# Start and stop services scripts #
###################################

  Run from the $dmgralias server
    $startstop/./stopall_$dmgralias.sh
    $startstop/./startall_$dmgralias.sh

  Run from the $srv2alias server
    $startstop/./startall_$srv2alias.sh
    $startstop/./stopall_$srv2alias.sh" > /var/websphere/src/install/"$dmgralias"_"$srv2alias"_was7script_list.txt
echo
echo "script list can be found here on the /var/websphere shared nas mount

/var/websphere/src/install/"$dmgralias"_"$srv2alias"_was7script_list.txt"

