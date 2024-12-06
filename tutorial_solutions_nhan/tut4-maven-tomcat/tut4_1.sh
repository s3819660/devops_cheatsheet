# Modify the index.jsp file
nano ~/helloWorld/src/main/webapp/index.jsp
<p>The current server date and time is: <%= new java.util.Date() %></p>
# format follow pattern
<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/>

(https://www.tutorialspoint.com/how-to-format-date-in-jsp)



# rebuild & redeploy
mvn package
cp target/helloWorld.war /opt/tomcat/webapps/
tomcatdown && tomcatup
