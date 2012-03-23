#!/bin/bash
if [ $(echo $HOSTNAME | grep ihshost | wc -l) -eq 0 ]; then
clear
echo $HOSTNAME " is not the IHS server script will not run"
exit
fi
rm -f /opt/websphere/ihsaliasinstall.txt
clear
echo "Enter password for wsadm"
read passwrd
clear
echo
echo "Installing ihs and plugins on " $HOSTNAME
echo " This is the start time " >> /opt/websphere/webinstall.txt
date >> /opt/websphere/webinstall.txt
/var/websphere/src/install/ihs_plugin_install/IHS/./install -options /var/websphere/src/install/ihs_plugin_install/responsefile/ihsresponsefile_ihsalias.txt -silent
/opt/websphere/ibmihs7/bin/versionInfo.sh >> /opt/websphere/webinstall.txt
/opt/websphere/ibmihs7/Plugins/bin/versionInfo.sh >> /opt/websphere/webinstall.txt
echo "Verifying base install "
if [ $(/opt/websphere/ibmihs7/bin/versionInfo.sh | grep Version | grep 7.0.0 | wc -l) -eq 0 ]; then
clear
echo "Base IHS install failed for " $HOSTNAME
exit
fi
echo 
/opt/websphere/ibmihs7/bin/versionInfo.sh | grep Version
if [ $(/opt/websphere/ibmihs7/Plugins/bin/versionInfo.sh | grep Version | grep 7.0.0 | wc -l) -eq 0 ]; then
clear
echo "Base Plugin install failed for " $HOSTNAME
exit
fi
echo 
/opt/websphere/ibmihs7/Plugins/bin/versionInfo.sh | grep Version
echo
echo "Installing fixpacks" 
/var/websphere/src/UpdateInstaller/./update.sh -silent -options /var/websphere/src/updates/700fplevel/ihs7/responsefiles/fpinstall.ihs.txt
/var/websphere/src/UpdateInstaller/./update.sh -silent -options /var/websphere/src/updates/700fplevel/ihs7/responsefiles/fpinstall.plg.txt
/opt/websphere/ibmihs7/bin/versionInfo.sh >> /opt/websphere/webinstall.txt
/opt/websphere/ibmihs7/Plugins/bin/versionInfo.sh >> /opt/websphere/webinstall.txt
echo
echo "Verifying fixpack install "
if [ $(/opt/websphere/ibmihs7/bin/versionInfo.sh | grep Version | grep 7.0.0.fplevel | wc -l) -eq 0 ]; then
clear
echo "IHS fixpack failed for " $HOSTNAME
exit
fi
echo
/opt/websphere/ibmihs7/bin/versionInfo.sh | grep Version
echo
if [ $(/opt/websphere/ibmihs7/Plugins/bin/versionInfo.sh | grep Version | grep 7.0.0.fplevel | wc -l) -eq 0 ]; then
clear
echo "Plugin fixpack failed for " $HOSTNAME
exit
fi
echo
/opt/websphere/ibmihs7/Plugins/bin/versionInfo.sh | grep Version
echo "Copying original httpd and admin conf before sed "
cp /opt/websphere/ibmihs7/conf/httpd.conf /var/websphere/src/install/backups/$(hostname -s).httpd.conf.orig
cp /opt/websphere/ibmihs7/conf/admin.conf /var/websphere/src/install/backups/$(hostname -s).admin.conf.orig
find /opt/websphere/ibmihs7/conf/ -type f -name "admin.conf" -exec sed -i 's/@@SetupadmGroup@@/wsadm/g' {} \;
find /opt/websphere/ibmihs7/conf/ -type f -name "admin.conf" -exec sed -i 's/@@SetupadmUser@@/wsadm/g' {} \;
find /opt/websphere/ibmihs7/conf/ -type f -name "httpd.conf" -exec sed -i 's/nobody/wsadm/g' {} \;
mv /opt/websphere/ibmihs7/bin/apachectl /opt/websphere/ibmihs7/bin/apachectl2
echo '#!/bin/bash' >> /opt/websphere/ibmihs7/bin/apachectl
echo '/usr/bin/sudo apachectl2 $@' >> /opt/websphere/ibmihs7/bin/apachectl
chmod 755 /opt/websphere/ibmihs7/bin/apachectl
/opt/websphere/ibmihs7/bin/./apachectl start
/opt/websphere/ibmihs7/bin/./adminctl start
sleep 10
/opt/websphere/ibmihs7/bin/./htpasswd -b /opt/websphere/ibmihs7/conf/admin.passwd wsadm $passwrd
workspace=/var/websphere/src/install/bin/workspace
sed -i 's/passwrd/'$passwrd'/g' $workspace/py/ihsalias.py
echo " This is the end time " >> /opt/websphere/webinstall.txt 
date >> /opt/websphere/webinstall.txt
ps -ef | grep '/opt/websphere/ibmihs7 -k start' | grep -v grep
ps -ef | grep '/opt/websphere/ibmihs7/conf/admin.conf' | grep -v grep
echo $0 " script has completed successfully"