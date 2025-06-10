# docker-php

<!-- > Docker & php 5 & php 7 & php 8 & Maria DB & phpmyadmin -->
> Docker & php 8 & Maria DB & phpmyadmin 

## Before installation

Before installation change this [line](https://github.com/emalherbi/docker/blob/main/docker-compose.yml).

```yml
volumes:
  - ../www:/var/www/html
```

## Installation

```bash
docker-compose down -v

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)

docker-compose up -d --build --force-recreate --remove-orphans
```
