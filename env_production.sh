#!/bin/sh

docker-compose build
docker-compose up consul nginx ruby postgresql mariadb redis
