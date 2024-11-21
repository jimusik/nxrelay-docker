# NxRelay #

## About ##
NxRelay is an agent for NXCloud which is a fully rebrandable multi-tenancy cloud based DNS filter software by Jahastech. It is developed based on [NxFilter](http://nxfilter.org/p3/) and inherits most of the features of [NxFilter](http://nxfilter.org/p3/).

Container image is based off of Ubuntu:latest minimal with the most current DEB package for NxRelay from [NxFilter](https://nxfilter.org/p3/download/).  This whole project is a clone from [Deepwoods](https://github.com/DeepWoods) based on the NxCloud Docker.  All credit goes to Rob Asher.

## Usage ##

#### Interactive container for testing: ####

```
docker run -it --name nxcloud \
   -p 53:53/udp \
   jimusik/nxrelay:1.1
```

#### Detached container with persistent data volumes: ####

```
docker run -dt --name nxcloud \
  -e TZ=America/Los_Angeles \
  -v nxrconf:/nxrelay/conf \
  -v nxrdb:/nxrelay/db \
  -v nxrlog:/nxrelay/log \
  -p 53:53/udp \
  jimusik/nxrelay:1.1
```


## Configuration
* Must setup the cfg.properties file inside the container using
* TZ of the container defaults to UTC unless overridden by setting the environment variable to your locale.  [see List of tz time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)


---
## Docker-compose example ##

```yaml
version: '1.1'

services:
  nxcloud:
    image: jimusik/nxrelay:1.1
    container_name: nxrelay
    hostname: nxrelay
    restart: unless-stopped
    environment:
      TZ: "America/Los_Angeles"
    volumes:
      - nxrconf:/nxrelay/conf
      - nxrlog:/nxrelay/log
      - nxrdb:/nxrelay/db
    ports:
      - 53:53/udp
volumes:
  nxrconf:
  nxrdb:
  nxrlog:
```

### Useful Commands ###
docker-compose to start and detach container: `docker-compose up -d`

Stop and remove container: `docker-compose down`

Restart a service: `docker-compose restart nxcloud`

View logs: `docker-compose logs`

Open a bash shell on running container name: `docker exec -it nxrelay /bin/bash`

> **Warning**
> Commands below will delete all data volumes not associated with a container!
> 
> Remove container & persistent volumes(clean slate): `docker-compose down && docker volume prune`

## Updating ##
1. Pull the latest container.  `docker pull jimusik/nxrelay:1.1`
2. Stop and remove the current container.  `docker stop nxrelay && docker rm nxrelay `
> **Note** If using docker-compose:  `docker-compose down`
3. Run the new container with the same command from above.  [Detached container](#detached-container-with-persistent-data-volumes)
> **Note** If using docker-compose:  `docker-compose up -d`
4. Make sure that the container is running.  `docker ps`
5. Check the container logs if unable to access the GUI for some reason.  `docker logs nxrelay`
> **Note** If using docker-compose:  `docker-compose logs`
