FROM tomcat:9.0.35-jdk8-adoptopenjdk-hotspot

ADD target/hazle-demo.war.original $CATALINA_HOME/webapps/hazle-demo.war
ADD setenv.sh $CATALINA_HOME/bin/setenv.sh
