#create cluster DV01 ,cluster Members DVO1  and "DVO2

print "Creating DVOCLUSTER and adding members DV01 and DV02 \n"
AdminServerManagement.createApplicationServer("appsrv01_node", "DVO1", "default")
AdminClusterManagement.createClusterWithFirstMember("DVOCLUSTER", "APPLICATION_SERVER", "appsrv01_node", "DVO1")
AdminClusterManagement.createClusterMember("DVOCLUSTER", "appsrv02_node", "DVO2")
print " DVOCLUSTER is completed \n"
print "###############################" 

#create cluster INSIGHTCLUSTER ,cluster Members INSIGHT1, INSIGHT2

print "Creating INSIGHTCLUSTER and adding members INSIGHT1 and INSIGHT2 \n"
AdminServerManagement.createApplicationServer("appsrv01_node", "INSIGHT1", "default")
AdminClusterManagement.createClusterWithFirstMember("INSIGHTCLUSTER", "APPLICATION_SERVER", "appsrv01_node", "INSIGHT1")
AdminClusterManagement.createClusterMember("INSIGHTCLUSTER", "appsrv02_node", "INSIGHT2")
print "INSIGHTCLUSTER is completed \n"
print "#################################"

#create cluster DAISYCLUSTER , Cluster Members DAISY1 DAISY2

print "Creating DAISYCLUSTER and adding members DAISY1 DAISY2 \n"
AdminServerManagement.createApplicationServer("appsrv01_node", "DAISY1", "default")
AdminClusterManagement.createClusterWithFirstMember("DAISYCLUSTER", "APPLICATION_SERVER", "appsrv01_node", "DAISY1")
AdminClusterManagement.createClusterMember("DAISYCLUSTER", "appsrv02_node", "DAISY2")
print "cluster DAISYCLUSTER is completed \n"
print "####################################"

#create cluster  IVANCLUSTER, Cluster members IVAN1 IVAN2 

print "Creating IVANCLUSTER and adding members IVAN1 and IVAN2 \n"
AdminServerManagement.createApplicationServer("appsrv01_node", "IVAN1", "default")
AdminClusterManagement.createClusterWithFirstMember("IVANCLUSTER", "APPLICATION_SERVER", "appsrv01_node", "IVAN1")
AdminClusterManagement.createClusterMember("IVANCLUSTER", "appsrv02_node", "IVAN2")
print "cluster IVANCLUSTER is completed \n"
print "#################################"
print "Done ...Creating DVO INSIGHT DAISY and IVAN Clusters is completed#####"


