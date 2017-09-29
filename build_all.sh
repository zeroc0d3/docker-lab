#!/bin/sh

docker build -t domikadolab/nginx nginx
docker build -t domikadolab/node node
docker build -t domikadolab/postgres postgresql
docker build -t domikadolab/ruby ruby
