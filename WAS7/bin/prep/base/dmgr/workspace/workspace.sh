#!/bin/bash
if [ $(echo $HOSTNAME | grep dmgrhost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the dmgrserver script will not run"
exit
fi
clear
echo "Creating cluster and servers"
echo
echo
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/workspace/py/cluster.py
exit_code1=$?
if [ "$exit_code1" -ne "0" ]; then
echo
echo "cluster.py failed"
exit
fi
echo
echo "Servers and Cluster created"
echo
echo "Creating needed custom dir for virtual host"
mkdir /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom
echo
echo "Copying virtualhosts.xml templates for editing"
echo
cp /opt/websphere/appserver7/profiles/Dmgr/config/templates/default/virtualhosts.xml /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom/DVO_VH_virtualhosts.xml
cp /opt/websphere/appserver7/profiles/Dmgr/config/templates/default/virtualhosts.xml /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom/DAISY_VH_virtualhosts.xml
cp /opt/websphere/appserver7/profiles/Dmgr/config/templates/default/virtualhosts.xml /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom/IVAN_VH_virtualhosts.xml
cp /opt/websphere/appserver7/profiles/Dmgr/config/templates/default/virtualhosts.xml /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom/INSIGHT_VH_virtualhosts.xml
echo "Making changes to xml files"
echo
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name "DAISY*" -exec sed -i 's/name="default_host"/name="DAISY_VH"/g' {} \;
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name "DAISY*" -exec sed -i '$ i\<aliases xmi:id="HostAlias_1" hostname="*" port="9086" />' {} \;
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name "DVO*" -exec sed -i 's/name="default_host"/name="DVO_VH"/g' {} \;
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name "DVO*" -exec sed -i '$ i\<aliases xmi:id="HostAlias_1" hostname="*" port="9081" />' {} \;
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name "IVAN*" -exec sed -i 's/name="default_host"/name="IVAN_VH"/g' {} \;
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name "IVAN*" -exec sed -i '$ i\<aliases xmi:id="HostAlias_1" hostname="*" port="9087" />' {} \;
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name "INSIGHT*" -exec sed -i 's/name="default_host"/name="INSIGHT_VH"/g' {} \;
find /opt/websphere/appserver7/profiles/Dmgr/config/templates/custom -type f -name "INSIGHT*" -exec sed -i '$ i\<aliases xmi:id="HostAlias_1" hostname="*" port="9086" />' {} \;
echo
echo "Applying the changes"
echo
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/workspace/py/virtual_host.py
exit_code1=$?
if [ "$exit_code1" -ne "0" ]; then
echo 
echo "virtual_host.py failed "
exit
fi
echo
echo "Creating variables"
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/workspace/py/variable.py
exit_code1=$?
if [ "$exit_code1" -ne "0" ]; then
echo
echo "variable.py failed"
exit
fi
echo "Creating original properties files"
echo
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/workspace/py/Genprop.py
exit_code1=$?
if [ "$exit_code1" -ne "0" ]; then
echo
echo "Genprop.py failed"
exit
fi
echo "Backing up properties file to ../properties_active for editing"
echo
cp /var/websphere/src/install/bin/workspace/properties_orig/* /var/websphere/src/install/bin/workspace/properties_active/
echo
echo "Editing properties file in ../properties_active"
echo
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "DAISY*" -exec sed -i 's/WC_defaulthost=..../WC_defaulthost=9086/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "DVO*" -exec sed -i 's/WC_defaulthost=..../WC_defaulthost=9081/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "INSIGHT*" -exec sed -i 's/WC_defaulthost=..../WC_defaulthost=9084/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "IVAN*" -exec sed -i 's/WC_defaulthost=..../WC_defaulthost=9087/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "DAISY*" -exec sed -i 's/HeapSize=0/HeapSize=1024/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "DVO*" -exec sed -i 's/HeapSize=0/HeapSize=1024/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "INSIGHT*" -exec sed -i 's/HeapSize=0/HeapSize=768/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "IVAN*" -exec sed -i 's/HeapSize=0/HeapSize=512/g' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "*" -exec sed -i '/AttributeInfo=environment(name,value)/a \IBM_HEAPDUMPDIR=${DUMPS_NAME}/${WAS_SERVER_NAME}' {} \;
find /var/websphere/src/install/bin/workspace/properties_active -type f -name "*" -exec sed -i '/IBM_HEAPDUMPDIR=${DUMPS_NAME}.${WAS_SERVER_NAME}/a \IBM_JAVACOREDIR=${DUMPS_NAME}/${WAS_SERVER_NAME}' {} \;
echo
echo "Deploying changes"
/opt/websphere/appserver7/profiles/Dmgr/bin/./wsadmin.sh -lang jython -f /var/websphere/src/install/bin/workspace/py/apply.py
exit_code1=$?
if [ "$exit_code1" -ne "0" ]; then
echo
echo "apply.py failed "
exit
fi
echo
clear
echo $0 " script has completed successfully"
echo
echo "logon to http://dmgralias:9060/ibm/console/ just to be certain"