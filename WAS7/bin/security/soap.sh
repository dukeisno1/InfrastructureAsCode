#!/bin/bash
echo "type the admin user name for console most likely it is admin"
read user
echo
echo "type the password for $user"
read userpasswrd
clear
echo "creating original props file if not already done"
if [ $(ls /opt/websphere/appserver7/profiles/Dmgr/properties/soap.client.props.org | wc -l) -eq 0 ]; then
echo "creating first original dmgr props file"
cp /opt/websphere/appserver7/profiles/Dmgr/properties/soap.client.props /opt/websphere/appserver7/profiles/Dmgr/properties/soap.client.props.org
fi
if [ $(ls /opt/websphere/appserver7/profiles/Appsrv/properties/soap.client.props.org | wc -l) -eq 0 ]; then
echo "creating first original dmgr props file"
cp /opt/websphere/appserver7/profiles/Appsrv/properties/soap.client.props /opt/websphere/appserver7/profiles/Appsrv/properties/soap.client.props.org
fi
echo "copying original back to soap.client.props"
cp /opt/websphere/appserver7/profiles/Dmgr/properties/soap.client.props.org /opt/websphere/appserver7/profiles/Dmgr/properties/soap.client.props
cp /opt/websphere/appserver7/profiles/Appsrv/properties/soap.client.props.org /opt/websphere/appserver7/profiles/Appsrv/properties/soap.client.props
echo
echo "editing the soap.client.props file"
sed -i 's/loginUserid=/loginUserid='$user'/g' /opt/websphere/appserver7/profiles/Dmgr/properties/soap.client.props
sed -i 's/loginPassword=/loginPassword='$userpasswrd'/g' /opt/websphere/appserver7/profiles/Dmgr/properties/soap.client.props
sed -i 's/loginUserid=/loginUserid='$user'/g' /opt/websphere/appserver7/profiles/Appsrv/properties/soap.client.props
sed -i 's/loginPassword=/loginPassword='$userpasswrd'/g' /opt/websphere/appserver7/profiles/Appsrv/properties/soap.client.props
echo
echo "Encrypting password for $user"
/opt/websphere/appserver7/profiles/Dmgr/bin/PropFilePasswordEncoder.sh /opt/websphere/appserver7/profiles/Dmgr/properties/soap.client.props com.ibm.SOAP.loginPassword
/opt/websphere/appserver7/profiles/Appsrv/bin/PropFilePasswordEncoder.sh /opt/websphere/appserver7/profiles/Appsrv/properties/soap.client.props com.ibm.SOAP.loginPassword

