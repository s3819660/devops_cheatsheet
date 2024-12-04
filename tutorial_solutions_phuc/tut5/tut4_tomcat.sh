#!/bin/bash

# Java, Tomcat

# Install Java
if ! sudo yum install java-17-amazon-corretto -y; then
    echo 'Failed to install Java'
    exit 1
fi

# Install Tomcat
cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.97/bin/apache-tomcat-9.0.97.tar.gz
if ! tar -xvzf apache-tomcat-9.0.97.tar.gz; then
    echo 'Failed to unzip tomcat'
    exit 1
fi
mv apache-tomcat-9.0.97 tomcat

# Configure Tomcat
sed -i '/<Valve/,/>/d' /opt/tomcat/webapps/docs/META-INF/context.xml
sed -i '/<Valve/,/>/d' /opt/tomcat/webapps/examples/META-INF/context.xml

sed -i '/<Valve/s/^/<!-- /' /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i '/allow="127/s/$/ -->/' /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i '/<Valve/s/^/<!-- /' /opt/tomcat/webapps/host-manager/META-INF/context.xml
sed -i '/allow="127/s/$/ -->/' /opt/tomcat/webapps/host-manager/META-INF/context.xml

echo '<role rolename="admin-gui"/>
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<user username="admin" password="s3cret" roles="admin-gui,manager-gui, manager-script, manager-jmx, manager-status"/>' > /tmp/tomcatu_content.xml

sed -i '/version="1.0">/r /tmp/tomcatu_content.xml' /opt/tomcat/conf/tomcat-users.xml

# Symbolic links
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

tomcatup

