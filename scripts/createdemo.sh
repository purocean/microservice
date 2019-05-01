#!/bin/sh
cd microservice-demo
mvn package
cd ../docker
docker-compose build
