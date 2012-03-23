
#Creating Unmanaged Node
print "Creating Unmanaged Node\n"

AdminTask.createUnmanagedNode('[-nodeName ihsalias -hostName ihsalias -nodeOperatingSystem linux]')

##end Unmanaged Node
print "Creating Unmanaged Node is completed successfully\n"

#creating Webserver intance on the console .
print "Creating webserver ihsalias\n"

AdminTask.createWebServer('ihsalias', '[-name ihsalias -templateName IHS -serverConfig [-webPort 80 -webInstallRoot /opt/websphere/ibmihs7 -pluginInstallRoot /opt/websphere/ibmihs7/Plugins -configurationFile /opt/websphere/ibmihs7/conf/httpd.conf -serviceName -errorLogfile /opt/websphere/ibmihs7/logs/error_log -accessLogfile /opt/websphere/ibmihs7/logs/access_log -webAppMapping ALL] -remoteServerConfig [-adminPort 8008 -adminUserID wsadm -adminPasswd passwrd]]')

AdminConfig.save()
print "Done Configurations are SAVED \n"
