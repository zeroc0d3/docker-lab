# CentOS Ruby Docker (Ruby Container)
[![Build Status](https://travis-ci.org/zeroc0d3lab/centos-ruby.svg?branch=master)](https://travis-ci.org/zeroc0d3lab/centos-ruby) [![](https://images.microbadger.com/badges/image/zeroc0d3lab/centos-ruby:latest.svg)](https://microbadger.com/images/zeroc0d3lab/centos-ruby:latest "Layers") [![](https://images.microbadger.com/badges/version/zeroc0d3lab/centos-ruby:latest.svg)](https://microbadger.com/images/zeroc0d3lab/centos-ruby:latest "Version") [![GitHub issues](https://img.shields.io/github/issues/zeroc0d3lab/centos-ruby.svg)](https://github.com/zeroc0d3lab/centos-ruby/issues) [![GitHub forks](https://img.shields.io/github/forks/zeroc0d3lab/centos-ruby.svg)](https://github.com/zeroc0d3lab/centos-ruby/network) [![GitHub stars](https://img.shields.io/github/stars/zeroc0d3lab/centos-ruby.svg)](https://github.com/zeroc0d3lab/centos-ruby/stargazers) [![GitHub license](https://img.shields.io/badge/license-GPLv2-blue.svg)](https://raw.githubusercontent.com/zeroc0d3lab/centos-ruby/master/LICENSE)

This docker image includes:

## Features:
* bash (+ themes)
* oh-my-zsh (+ themes)
* tmux (+ themes)
* rbenv / rvm
  - [X] gem test unit (rspec, serverspec)
  - [X] gem docker-api
  - [X] gem sqlite3, mongoid, sequel, apktools
  - [X] gem mysql2 (run: yum install -y mysql-devel)
  - [X] gem pg, sequel_pg (run: yum install -y postgresql-libs postgresql-devel)
  - [X] gem rubocop
  - [X] [**others**](https://github.com/zeroc0d3lab/centos-ruby/blob/master/rootfs/root/Gemfile)

## Docker Compose
* Copy `env-example` to `.env`
* Build & running
  ```
  docker-compose build && docker-compose up
  ```
* Force recreate container
  ```
  docker-compose build && docker-compose up --force-recreate ruby
  ```
* Running container only
  ```
  docker-compose up
  ```

## Environments
You can run docker-compose for different environment with selected containers
* Copy `env.sh.example` to `env.sh`
* Change to execute script
  ```
  chmod a+x env.sh
  ```
* Change environment in `env.sh` file
  ```
  ENV="development"            # (use: "development" or "production" as selected environment)
  CONTAINER_PRODUCTION="..."   # (selected containers will be run in production environment)
  CONTAINER_DEVELOPMENT="..."  # (selected containers will be run in development environment)
  ```
* Running script
  ```
  ./env.sh
  ```

## License
[**GNU General Public License v2**](https://github.com/zeroc0d3lab/centos-ruby/blob/master/LICENSE)