#!/bin/bash
clear
if [ $(/var/websphere/src/UpdateInstaller/bin/./versionInfo.sh | grep Version | grep 7.0.0 | wc -l) -gt 0 ]; then
clear
echo "Looks like UpdateInstaller is already installed"
/var/websphere/src/UpdateInstaller/bin/./versionInfo.sh | grep Version
exit
fi
clear
echo "This will install the update installer on the shared nas mount on /var/websphere"
/var/websphere/src/install/updateinstall/UpdateInstaller/./install -silent -options /var/websphere/src/install/bin/prep/updateinstall_all.txt
echo $0 " script has completed successfully"