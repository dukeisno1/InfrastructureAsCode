#!/bin/bash
clear
echo " This script is designed to create a cluster a base virtual_host, heapsize, port and java dump variables for a new application

The prerequisites for running this script is the following

1. The application name for example DVO, IVAN
2. The port number to be used by application. This must be one that is not currently being used by another app
3. The deployment manager host name
4. The JVM size required usually 512-1024 or more but recommended not more than 2048 unless needed"
echo
echo
echo
echo "Type y if your ready to continue, any other response will exit program"
read answer
echo
if [[ "$answer" != "y" ]]
then
clear
echo "Program is exiting "
exit
fi

echo
echo "Enter application name in all caps for example DVO"
read newapp
echo
echo "Enter port to be used by application remember you MUST choose a port not uses by another app this information should be known ahead of time"
read newport
echo
echo "Enter heapsize for application"
read newheap
echo
echo "Enter the dmgr host name"
read dmgrhost


mkdir /var/websphere/src/install/bin/addapp/$newapp
mkdir /var/websphere/src/install/bin/addapp/$newapp/py

cp /var/websphere/src/install/bin/addapp/base/* /var/websphere/src/install/bin/addapp/$newapp/py/
cp /var/websphere/src/install/bin/addapp/base/newapp.sh /var/websphere/src/install/bin/addapp/$newapp/add_$newapp.sh

find /var/websphere/src/install/bin/addapp/$newapp/py/ -type f -name "*" -exec sed -i 's/newapp/'$newapp'/g' {} \;
sed -i 's/newapp/'$newapp'/g' /var/websphere/src/install/bin/addapp/$newapp/add_$newapp.sh
sed -i 's/newport/'$newport'/g' /var/websphere/src/install/bin/addapp/$newapp/add_$newapp.sh
sed -i 's/newheap/'$newheap'/g' /var/websphere/src/install/bin/addapp/$newapp/add_$newapp.sh
sed -i 's/dmgrhost/'$dmgrhost'/g' /var/websphere/src/install/bin/addapp/$newapp/add_$newapp.sh
clear
echo
echo
echo "prep script has completed to impliment run the following

/var/websphere/src/install/bin/addapp/$newapp/add_$newapp.sh"