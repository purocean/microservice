#!/bin/sh
cd microservice-demo
docker run -it --rm --name my-maven-project -v /tmp/.m2/:/root/.m2 -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3-jdk-11-slim mvn -s setting.xml -Dmaven.test.skip=true package
cd ../docker
docker-compose build
