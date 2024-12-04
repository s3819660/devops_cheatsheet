# TEXT MANIPULATION
 
## Remove comment
sed -i '/<Valve/s/<!-- //' context.xml
sed -i '/allow="127/s/ -->//' context.xml

## Add comment symbols
sed -i '/<Valve/s/^/<!-- /' /opt/tomcat/webapps/docs/META-INF/context.xml
sed -i '/allow="127\\.\\d/s/$/ -->/' /opt/tomcat/webapps/docs/META-INF/context.xml

## Remove range including pattern
sed -i '/<Valve/,/>/d' /opt/tomcat/webapps/docs/META-INF/context.xml

## Replace
sed -i 's/port="8080"/port="80"/g' /opt/tomcat/conf/server.xml
