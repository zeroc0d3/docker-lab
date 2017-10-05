#!/bin/sh

## Build Core Container ##
docker-compose build --no-cache base
docker-compose build --no-cache base-consul
docker-compose build --no-cache consul

## Rebuild All Container (Remove Old Containers) ##
# docker-compose build --no-cache

## Skip Remove Old Container ##
docker-compose build

## Just Running Some Containers ##
docker-compose up consul nginx ruby postgresql mariadb mongodb redis application

## Recreate Container ##
# docker-compose up --force-recreate consul nginx ruby postgresql mariadb mongodb redis application
