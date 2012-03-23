print "Apply newapp1 properties \n "
AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/newapp1.props]')
AdminConfig.save()
print "done\n"
print "Apply newapp2 properties \n "
AdminTask.applyConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_active/newapp2.props]')
AdminConfig.save()
print "done\n"
print "###################DONE#######################"
