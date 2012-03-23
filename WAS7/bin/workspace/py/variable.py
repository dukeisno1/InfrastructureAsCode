
print "######################################################################################"
print "Creating ORACLE_JDBC_DRIVER_PATH on the node scopes of appsrv01_node and appsrv02_node"

AdminTask.setVariable(['-variableName', 'ORACLE_JDBC_DRIVER_PATH', '-variableValue', '/opt/websphere/wfm/lib', '-scope','Cell=was7_Cell,Node=appsrv01_node'])
AdminConfig.save()



AdminTask.setVariable(['-variableName', 'ORACLE_JDBC_DRIVER_PATH', '-variableValue', '/opt/websphere/wfm/lib', '-scope','Cell=was7_Cell,Node=appsrv02_node'])
AdminConfig.save()

print "done"

print "######################################################################################"


print "Creating INFORMIX_JDBC_DRIVER_PATH  at the node scopes of appsrv01_node and appsrv02_node"

AdminTask.setVariable(['-variableName', 'INFORMIX_JDBC_DRIVER_PATH', '-variableValue', '/opt/websphere/wfm/lib', '-scope','Cell=was7_Cell,Node=appsrv01_node'])
AdminConfig.save()



AdminTask.setVariable(['-variableName', 'INFORMIX_JDBC_DRIVER_PATH', '-variableValue', '/opt/websphere/wfm/lib', '-scope','Cell=was7_Cell,Node=appsrv02_node'])
AdminConfig.save()

print "done"



print "#############################################################################"

print "Creating Node scope variables for dumps on appsrv01_node and appsrv02_node "

AdminTask.setVariable(['-variableName', 'DUMPS_NAME', '-variableValue', '/opt/websphere/dumps/', '-scope','Cell=was7_Cell,Node=appsrv01_node'])
AdminConfig.save()

AdminTask.setVariable(['-variableName', 'DUMPS_NAME', '-variableValue', '/opt/websphere/dumps/', '-scope','Cell=was7_Cell,Node=appsrv02_node'])

AdminConfig.save()

print "done"

print "##############################################################################"

print  "Creating Shared_LIB for DAISYCLUSTER"
print "Creating DAISYCLUSTER shared_lib "

serv = AdminConfig.getid("/ServerCluster:DAISYCLUSTER/")
print serv
print AdminConfig.create('Library', serv, [['name', 'shared_lib'], ['classPath', '/opt/websphere/wfm/lib/voxware/shared-lib']])
AdminConfig.save()
print "done"

print "#################################################################################"

print "Creating JDBC providers"

Serverid = AdminConfig.getid("/ServerCluster:DVOCLUSTER/")

Serverid2 = AdminConfig.getid("/ServerCluster:INSIGHTCLUSTER/")

n1 = ["name" , "Oracle JDBC Driver-DVO" ]

n2= ["name" , "Oracle JDBC Driver-INSIGHT" ]

desc = ["description" , "Oracle JDBC Driver"]

impn = ["implementationClassName" , "oracle.jdbc.pool.OracleConnectionPoolDataSource"]

classpath = ["classpath" , "${ORACLE_JDBC_DRIVER_PATH}/classes14.jar" ]

attrs1 = [n1 , impn , desc , classpath]

attrs2 = [n2 , impn , desc , classpath]

jdbcDVO = AdminConfig.create('JDBCProvider' , Serverid , attrs1)

print jdbcDVO

jdbINSIGHT = AdminConfig.create('JDBCProvider' , Serverid2 , attrs2)

print jdbINSIGHT

AdminConfig.save()


print " Saving Configuraion "

print " done"

print "##############################################################################################"


print "Creating mail session for INSIGHTCLUSTER"

print "Creating mail seesion attributes for INSIGHTCLUSTER Blue Sky Mail "
name = ['name', 'Blue Sky Mail']
jndi = ['jndiName', 'mail/blueSkyMail']
msAttrs = [name, jndi]
print msAttrs

newmp = AdminConfig.getid("/ServerCluster:INSIGHTCLUSTER/MailProvider:Built-in Mail Provider")

print newmp

print AdminConfig.create('MailSession', newmp, msAttrs)

AdminConfig.save()
print "Done"
print "#########################################################################################"

print "Creating JDBC providers for INFORMIX_JDBC"

Serverid3 = AdminConfig.getid("/ServerCluster:INSIGHTCLUSTER/")

n3 = ["name" , "INFORMIX-INSIGHT" ]

desc3 = ["description" , "INFORMIX JDBC Driver"]

impn3 = ["implementationClassName" , "com.informix.jdbcx.IfxConnectionPoolDataSource"]

classpath3 = ["classpath" , "${INFORMIX_JDBC_DRIVER_PATH}/ifxjdbc.jar ${INFORMIX_JDBC_DRIVER_PATH}/ifxjdbcx.jar" ]

attrs3 = [n3 , impn3 , desc3 , classpath3]


jdbinformixINSIGHT = AdminConfig.create('JDBCProvider' , Serverid3 , attrs3)

print jdbinformixINSIGHT

AdminConfig.save()


print " Saving Configuraion "

print " done"
print "#######################################################"

