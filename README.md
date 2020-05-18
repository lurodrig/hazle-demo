# Hazlecast client for hibernate second level demo (Work In Progress)

## What?

Spring-boot REST service client against MySQL database. Hibernate ORM with second level cache enabled.

## How?

Run mysql and create the demo empty database:
```
docker run --name some-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql:latest 
CREATE DATABASE `demo`
```

Run Hazlecast In Memory Grid
```
docker run --network=host -e JAVA_OPTS="-Xms512M -Xmx512M" hazelcast/hazelcast:4.0.1
``` 

Compile, run the tests and package
```
mvn clean package
```

Build an apache-tomcat container with our app added to `${CATALINA_BASE}/webapps`
```
docker build -t 9.0.35-jdk8-spring-boot-hazle .
```

Run apache-tomcat
```
docker run --network=host --name tomcat-hazle-demo 9.0.35-jdk8-spring-boot-hazle:latest
```
