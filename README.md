# Introduction

This image is built to run on ARMv7 devices, like the Raspberry Pi 2. It contains a Neo4j graphdatabase instance.

[Source code is on GitHub](https://github.com/oysteinjakobsen/docker-armv7-neo4j)

> TIP: Check out [this article](http://blog.hypriot.com/kick-ass-raspberry-pi-2-having-a-forbidden-love-affair-with-docker-1-dot-4-1) if you haven't yet got Docker up and running on your Raspberry Pi 2.

# How to use this image

## Create a new container with an emtpy database

The simplest possible way to use this image is like this:

```
docker run -it oysteinjakobsen/armv7-neo4j
```

Use `docker ps` to check which port 7474 mapped to on your host, and you're ready to connect using your browser!

## Keeping the database on your host file system

The image has a mount-point `/data` that can be used to keep your database on the host computer instead of inside the container. Assuming you want to keep your database in the host folder `/my-neo4j-data`:

```
docker run \
  --rm -it \
  -p 7474:7474 \
  -p 1337:1337 \
  -v /my-neo4j-data:/data \
  oysteinjakobsen/armv7-neo4j
```

When the server starts connections will be accepted on port 7474 (browser) and 1337 (shell, host only).

## Running Neo4j commands

You can run Neo4j commands using `docker exec`:

```
docker exec -it <container> neo4j status
docker exec -it <container> neo4j stop
docker exec -it <container> neo4j start
docker exec -it <container> neo4j-shell -c 'MATCH (n) RETURN n LIMIT 25;'
```

