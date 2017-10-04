#!/bin/sh

## Remove Old Container ##
# docker-compose build --no-cache

## Skip Remove Old Container ##
docker-compose build


## Just Running Some Containers ##
docker-compose up consul nginx ruby postgresql mariadb mongodb redis application

## Recreate Container ##
# docker-compose up --force-recreate consul nginx ruby postgresql mariadb mongodb redis application
