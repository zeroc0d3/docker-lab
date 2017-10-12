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
