print "creating  virtual host"

print AdminConfig.listTemplates('VirtualHost')

cell = AdminConfig.getid('/Cell:was7_Cell/')

print AdminConfig.listTemplates('VirtualHost')

#creating IVAN_VH using default templates
print "creating IVAN_VH using default templates"
IVAN_VH1 = AdminConfig.listTemplates('VirtualHost', 'IVAN_VH')
AdminConfig.createUsingTemplate('VirtualHost', cell, [['name', 'IVAN_VH']], IVAN_VH1)
AdminConfig.save()
print "done"

#creating DAISY_VH using default templates
print "creating DAISY_VH using default templates"
DAISY_VH1 = AdminConfig.listTemplates('VirtualHost', 'DAISY_VH')
AdminConfig.createUsingTemplate('VirtualHost', cell, [['name', 'DAISY_VH']], DAISY_VH1)
AdminConfig.save()
print "done"

#creating INSIGHT_VH  using default templates
print "creating INSIGHT_VH using default templates"
INSIGHT_VH1 = AdminConfig.listTemplates('VirtualHost', 'INSIGHT_VH')
AdminConfig.createUsingTemplate('VirtualHost', cell, [['name', 'INSIGHT_VH']], INSIGHT_VH1)
AdminConfig.save()
print "done"

#creating DVO_VH using default templates
print "creating DVO_VH using default templates"
DVO_VH1 = AdminConfig.listTemplates('VirtualHost', 'DVO_VH')
AdminConfig.createUsingTemplate('VirtualHost', cell, [['name', 'DVO_VH']], DVO_VH1)
AdminConfig.save()
print "done"

print "#####Completed #######"
