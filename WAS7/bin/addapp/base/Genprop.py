print "Extracting newapp1 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/newapp1.props -configData Server=newapp1]')
print "done\n"
print "Extracting newapp2 properties to /var/websphere/src/install/bin/workspace/properties_orig\n "
AdminTask.extractConfigProperties('[-propertiesFileName /var/websphere/src/install/bin/workspace/properties_orig/newapp2.props -configData Server=newapp2]')
print "done\n"
print "Pops file extraction is completed"
