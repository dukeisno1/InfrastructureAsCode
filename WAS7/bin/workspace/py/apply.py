print "#######starting Applying properties************"
print "Apply DAISY1 properties \n "

AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/DAISY1.props]')
AdminConfig.save()
print "done"


print "Apply DAISY2 properties \n "

AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/DAISY2.props]')
AdminConfig.save()
print "done"



print "Apply DVO1 properties \n "

AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/DVO1.props]')
AdminConfig.save()
print "done\n"

print "Apply DVO2 properties \n "
AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/DVO2.props]')
AdminConfig.save()
print "done\n"


print "Apply INSIGHT1 properties \n "

AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/INSIGHT1.props]')
AdminConfig.save()
print "done\n"

print "Apply INSIGHT2 properties \n "
AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/INSIGHT2.props]')
AdminConfig.save()
print "done\n"



print "Apply IVAN1 properties \n "

AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/IVAN1.props]')
AdminConfig.save()
print "done\n"

print "Apply IVAN2 properties \n "
AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/IVAN2.props]')
AdminConfig.save()
print "done\n"
print "###################DONE#######################"
