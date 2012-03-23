#!/bin/bash
if [ $(echo $HOSTNAME | grep dmgrhost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the dmgrserver script will not run"
exit
fi

/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/addapp/newapp/py/cluster.py

echo "Copying virtualhosts.xml templates for editing"
cp /opt/websphere/appserver7/profiles/Dmgr/config/templates/default/virtualhosts.xml /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom/newapp_VH_virtualhosts.xml

echo "Making changes to xml files"

find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name newapp* -exec sed -i 's/default_host/newapp_VH/g' {} \;
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name newapp* -exec sed -i '$ i\<aliases xmi:id="HostAlias_1" hostname="*" port="newport"/>' {} \;

echo "Applying the changes"
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/addapp/newapp/py/virtual_host.py


echo "Creating original properties files"
echo
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/addapp/newapp/py/Genprop.py


echo "Backing up properties file to ../properties_active for editing"
echo
cp /var/websphere/src/install/bin/workspace/properties_orig/* /var/websphere/src/install/bin/workspace/properties_active/
echo
echo "Editing properties file in ../properties_active"
echo
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "newapp*" -exec sed -i 's/WC_defaulthost=..../WC_defaulthost=newport/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "newapp*" -exec sed -i 's/HeapSize=0/HeapSize=newheap/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "newapp*" -exec sed -i '/AttributeInfo=environment(name,value)/a \IBM_HEAPDUMPDIR=${DUMPS_NAME}/${WAS_SERVER_NAME}' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "newapp*" -exec sed -i '/IBM_HEAPDUMPDIR=${DUMPS_NAME}.${WAS_SERVER_NAME}/a \IBM_JAVACOREDIR=${DUMPS_NAME}/${WAS_SERVER_NAME}' {} \;
echo
echo "Deploying changes"
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/addapp/newapp/py/apply.py
echo
echo "logon to http://dmgrhost:9060/ibm/console/ just to be certain"
