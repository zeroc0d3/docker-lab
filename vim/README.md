# CentOS Vim Docker (Vim Container)
[![Build Status](https://travis-ci.org/zeroc0d3lab/centos-vim.svg?branch=master)](https://travis-ci.org/zeroc0d3lab/centos-vim) [![](https://images.microbadger.com/badges/image/zeroc0d3lab/centos-vim:latest.svg)](https://microbadger.com/images/zeroc0d3lab/centos-vim:latest "Layers") [![](https://images.microbadger.com/badges/version/zeroc0d3lab/centos-vim:latest.svg)](https://microbadger.com/images/zeroc0d3lab/centos-vim:latest "Version") [![GitHub issues](https://img.shields.io/github/issues/zeroc0d3lab/centos-vim.svg)](https://github.com/zeroc0d3lab/centos-vim/issues) [![GitHub forks](https://img.shields.io/github/forks/zeroc0d3lab/centos-vim.svg)](https://github.com/zeroc0d3lab/centos-vim/network) [![GitHub stars](https://img.shields.io/github/stars/zeroc0d3lab/centos-vim.svg)](https://github.com/zeroc0d3lab/centos-vim/stargazers) [![GitHub license](https://img.shields.io/badge/license-GPLv2-blue.svg)](https://raw.githubusercontent.com/zeroc0d3lab/centos-vim/master/LICENSE)

This docker image includes:

## Features:
* bash (+ themes)
* oh-my-zsh (+ themes)
* tmux (+ themes)
* vim (+ plugins with vundle & themes)

## Docker Compose
* Copy `env-example` to `.env`
* Build & running
  ```
  docker-compose build && docker-compose up
  ```
* Force recreate container
  ```
  docker-compose build && docker-compose up --force-recreate vim
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
[**GNU General Public License v2**](https://github.com/zeroc0d3lab/centos-vim/blob/master/LICENSE)