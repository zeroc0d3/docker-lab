#!/bin/sh

docker-compose build

## Just Running Some Containers ##
# docker-compose up consul nginx ruby postgresql mongodb

## Recreate Container ##
docker-compose up --force-recreate consul nginx ruby postgresql mongodb