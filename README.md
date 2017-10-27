# Docker-Lab
Docker Lab (Learn Docker), this repository inspired from [**Docker Alpine**](https://github.com/bhuisgen/docker-alpine).

## Features
Dynamic environments for:
* MariaDB
* MongoDB
* Nginx
* NodeJS
* PostgreSQL
* Ruby
* Vim
* Application (Workspace for Vim, NodeJS & Ruby)

## Application Container Features
* bash (+ themes)
* oh-my-zsh (+ themes)
* tmux (+ themes)
* vim (+ plugins with vundle & themes)
* rbenv / rvm
  - [X] gem test unit (rspec, serverspec)
  - [X] gem docker-api
  - [X] gem sqlite3, mongoid, sequel, apktools
  - [X] gem mysql2 (run: yum install -y mysql-devel)
  - [X] gem pg, sequel_pg (run: yum install -y postgresql-libs postgresql-devel)
  - [X] gem rubocop
  - [X] [**others**](https://github.com/zeroc0d3/docker-lab/blob/master/application/rootfs/root/Gemfile)
* npm
  - [X] npm test unit (ChaiJS, TV4, Newman)
* js package manager
  - [X] yarn
  - [X] bower
  - [X] grunt
  - [X] gulp
  - [X] yeoman

## Vim (`vundle`) Plugin
* Run vim then
  ```
  :PluginInstall
  ```
* Update plugin vim (vundle)
  ```
  :PluginUpdate
  ```
* Via terminal
  ```
  vim +PluginInstall +q
  vim +PluginUpdate +q
  ```

## Ruby Packages Dependency
* Path Gemfile
  ```
  $HOME/Gemfile
  $HOME/Gemfile.lock
  ```
* Gem Installation
  ```
  ./tmp/gems.sh
  ```
* Different User Installation
  ```
  /bin/sh $HOME/gems.sh
  ```

## Build & Run Containers (Without `docker-compose`)
* Build Containers
  ```
  ./build_all.sh
  ```
* Running Containers (Single Containers Only)
  ```
  ./run_nginx.sh
  ./run_mariadb.sh
  ./run_postgresql.sh
  ```

## Docker Compose
* Copy `env-example` to `.env`
* Copy `docker-compose.skeleton.yml` to `docker-compose.yml`
* Build & running
  ```
  docker-compose build && docker-compose up
  ```
* Force recreate container
  ```
  docker-compose build && docker-compose up --force-recreate
  ```
* Force recreate some containers only
  ```
  docker-compose build && docker-compose up --force-recreate mariadb mongodb nginx nodejs postgresql redis ruby application
  ```
* Running container only
  ```
  docker-compose up
  ```
* Running some containers only
  ```
  docker-compose up mariadb mongodb nginx nodejs postgresql redis ruby application
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
[**MIT License**](https://github.com/zeroc0d3/docker-lab/blob/master/LICENSE)