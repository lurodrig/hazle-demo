#!/bin/sh

mvn clean package
docker build --no-cache -t 9.0.35-jdk8-spring-boot-hazle .
docker rm tomcat-hazle-demo
docker run --network=host --name tomcat-hazle-demo 9.0.35-jdk8-spring-boot-hazle:latest
