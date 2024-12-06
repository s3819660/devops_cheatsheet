# install jdk
yum install java-17-amazon-corretto -y

cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.97/bin/apache-tomcat-9.0.97.tar.gz
tar -xvzf apache-tomcat-9.0.97.tar.gz
mv apache-tomcat-9.0.97 tomcat
cd tomcat/bin

# comment out in context.xml
sed -i '/<Valve className="org.apache.catalina.valves.RemoteAddrValve/i\<!--' /opt/tomcat/webapps/host-manager/META-INF/context.xml
sed -i '/<Manager/i\-->' /opt/tomcat/webapps/host-manager/META-INF/context.xml
sed -i '/<Valve className="org.apache.catalina.valves.RemoteAddrValve/i\<!--' /opt/tomcat/webapps/manager/META-INF/context.xml
sed -i '/<Manager/i\-->' /opt/tomcat/webapps/manager/META-INF/context.xml

# edit tomcat-users.xml file
# add text into a new temporary file
echo '<role rolename="admin-gui"/>
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<user username="admin" password="s3cret" roles="admin-gui,manager-gui,manager-script,manager-jmx,manager-status"/>' > /tmp/new_content.xml

# then add text from the new temp file into the tomcat-users.xml
sed -i '/version="1.0">/r /tmp/new_content.xml' /opt/tomcat/conf/tomcat-users.xml

# symbolic links
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown

tomcatup