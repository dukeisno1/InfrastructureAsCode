#create cluster  newappCLUSTER, Cluster members newapp1 newapp2 
print "Creating newappCLUSTER and adding members newapp1 and newapp2 \n"
AdminServerManagement.createApplicationServer("appsrv01_node", "newapp1", "default")
AdminClusterManagement.createClusterWithFirstMember("newappCLUSTER", "APPLICATION_SERVER", "appsrv01_node", "newapp1")
AdminClusterManagement.createClusterMember("newappCLUSTER", "appsrv02_node", "newapp2")
print "cluster newappCLUSTER is completed \n"
print "#################################"
print "Done ...Creating newapp Clusters is completed#####"
