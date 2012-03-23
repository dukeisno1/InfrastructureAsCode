print "Extracting DAISY1 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/DAISY1.props -configData Server=DAISY1]')
print "done\n"
print "Extracting DAISY2 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "

AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/DAISY2.props -configData Server=DAISY2]')
print "done\n"


print "Extracting DVO1 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/DVO1.props -configData Server=DVO1]')
print "done\n"

print "Extracting DVO2 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName //var/websphere/src/install/bin/workspace/properties_orig/DVO2.props -configData Server=DVO2]')
print "done\n"
print "Extracting INSIGHT1 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/INSIGHT1.props -configData Server=INSIGHT1]')
print "done\n"
print "Extracting INSIGHT1 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/INSIGHT2.props -configData Server=INSIGHT2]')
print "done\n"
print "Extracting IVAN1 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/IVAN1.props -configData Server=IVAN1]')
print "done\n"
print "Extracting IVAN2 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/IVAN2.props -configData Server=IVAN2]')
print "done\n"
print "Pops file extraction is completed"
