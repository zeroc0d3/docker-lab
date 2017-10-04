# Docker-Lab
Docker Lab (Learn Docker), this repository inspired from [**Docker Alpine**](https://github.com/bhuisgen/docker-alpine).

## Features
Dynamic environments for:
* Consul
* MariaDB
* MongoDB
* Nginx
* NodeJS
* PostgreSQL
* Ruby
* Application (Workspace for NodeJS & Ruby)

## Build All (Shortcut)
```
./build_all.sh
```

## Docker Compose
* Copy `.env.example` to `.env`
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
  docker-compose build && docker-compose up --force-recreate consul nginx ruby postgresql mariadb mongodb redis application
  ```
* Running container only
  ```
  docker-compose up
  ```
* Running some containers only
  ```
  docker-compose up consul nginx ruby postgresql mariadb mongodb redis application
  ```

## Environments
You can run docker-compose for different environment with selected containers

* Running on development environment
  ```
  ./env_development.sh
  ```
* Running on production environment
  ```
  ./env_production.sh
  ```

## License
[**MIT License**](https://github.com/zeroc0d3/docker-lab/blob/master/LICENSE)
