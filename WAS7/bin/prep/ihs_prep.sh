#!/bin/bash
clear
echo "Enter the web host name"
read ihshost
echo
echo "Enter the web host alias "
read ihsalias
echo
ls /var/websphere/src/updates
echo "Type last 2 digits for fixpack you wish to apply"
read fplevel
echo
echo "Type the dmgr host name"
read dmgrhost
clear
echo "For the web host you typed " $ihshost
echo "For the web alias you typed " $ihsalias
echo "For the patch level you typed " $fplevel
echo "For the dmgr host name you typed " $dmgrhost
echo
echo "Type y if this is correct, any other response will exit program"
read answer
echo
if [[ "$answer" != "y" ]]
then
clear
echo "Program is exiting "
exit
fi
clear
echo "Running extra step confirmation"
if [ $(ls /var/websphere/src/updates/700$fplevel | wc -l) -eq 0 ]; then
clear
echo $fplevel " does not exist"
exit
fi
if [ $(nslookup $ihsalias | grep $ihshost | wc -l) -eq 0 ]; then
clear
echo "For web host you typed " $ihshost
echo "For web alias you typed " $ihsalias
echo
echo "Something isnt right confirm the host against alias"
exit
fi
if [ $(echo $ihsalias | grep web | wc -l) -eq 0 ]; then
clear
echo "For web alias you typed " $ihsalias
echo
echo "This may not be web alias"
exit
fi
clear
base=/var/websphere/src/install/bin/prep/base
install=/var/websphere/src/install/bin/install
uninstall=/var/websphere/src/install/bin/uninstall
workspace=/var/websphere/src/install/bin/workspace
startstop=/var/websphere/src/install/bin/start_stop_services
echo
echo "Doing pre-run clean up "
rm -f $uninstall/ihsuninstall_$ihsalias.sh
rm -f $install/ihsinstall_$ihsalias.sh
rm -f /var/websphere/src/install/ihs_plugin_install/responsefile/ihsresponsefile_$ihsalias.txt
rm -f /var/websphere/src/install/"$ihsalias"_was7script_list.txt
echo
echo "Creating new uninstall script"
cp $base/ihs/ihsuninstall.sh $uninstall/ihsuninstall_$ihsalias.sh
sed -i 's/ihshost/'$ihshost'/g' $uninstall/ihsuninstall_$ihsalias.sh
echo
echo "Creating new install script "
cp $base/ihs/ihsinstall.sh $install/ihsinstall_$ihsalias.sh
sed -i 's/ihshost/'$ihshost'/g' $install/ihsinstall_$ihsalias.sh
sed -i 's/ihsalias/'$ihsalias'/g' $install/ihsinstall_$ihsalias.sh
sed -i 's/fplevel/'$fplevel'/g' $install/ihsinstall_$ihsalias.sh
echo
echo "Creating new responsefile "
cp $base/ihs/ihsresponsefile_base.txt /var/websphere/src/install/ihs_plugin_install/responsefile/ihsresponsefile_$ihsalias.txt
sed -i 's/ihsalias/'$ihsalias'/g' /var/websphere/src/install/ihs_plugin_install/responsefile/ihsresponsefile_$ihsalias.txt
echo
echo "Copying and editing post install scripts for $ihsalias"
cp $base/ihs/web.py $workspace/py/$ihsalias.py
sed -i 's/ihsalias/'$ihsalias'/g' $workspace/py/$ihsalias.py
cp $base/ihs/web.sh $workspace/$ihsalias.sh
sed -i 's/ihsalias/'$ihsalias'/g' $workspace/$ihsalias.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' $workspace/$ihsalias.sh
echo
echo "Copying and editing the start and stop services scripts"
cp $base/ihs/stopihs.sh $startstop/stopall_$ihsalias.sh
cp $base/ihs/startihs.sh $startstop/startall_$ihsalias.sh
sed -i 's/ihshost/'$ihshost'/g' $startstop/stopall_$ihsalias.sh
sed -i 's/ihshost/'$ihshost'/g' $startstop/startall_$ihsalias.sh
echo
echo "Creating script list for later reference if needed"
echo " The following are a list of scripts created from $0

#########################
# Uninstall script list #
#########################

  Run from the $ihsalias server
    $uninstall/./ihsuninstall_$ihsalias.sh

#######################
# Install script list #
#######################

  Run from the $ihsalias server
    $install/./ihsinstall_$ihsalias.sh


#####################
# Workspace scripts #
#####################

  Run from the $dmgrhost server
    $workspace/./$ihsalias.sh
   
###################################
# Start and stop services scripts #
###################################

  Run from the $ihsalias server
    $startstop/./stopall_$ihsalias.sh
    $startstop/./startall_$ihsalias.sh" > /var/websphere/src/install/"$ihsalias"_was7script_list.txt
echo
echo "Script list can be found here on the /var/websphere shared nas mount

/var/websphere/src/install/"$ihsalias"_was7script_list.txt"