#!/bin/sh
cd microservice-demo
docker run -it --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3-jdk-11-slim mvn package
cd ../docker
docker-compose build
