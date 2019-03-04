#!/bin/bash

. ./app.cfg

#( rsync -avup "custom_config/.tmp"/ "src/FB.Switch/data"/.cache; )

COWSAY "GOOBYE $DOCKER_PROCNAME"

( docker stop "$DOCKER_PROCNAME" ) >/dev/null 2>&1
( docker rm "$DOCKER_PROCNAME" )  >/dev/null 2>&1

docker run \
 -it -d -p 80:80 \
 --label fb_switch \
 -v "$(pwd)"/custom_config/.tmp:/var/www/localhost/htdocs/data/.cache \
 fb_switch 

DOCKER_PROCNAME=$(docker ps -f label=fb_switch --format="{{.Names}}")
COWSAY "HELLO $DOCKER_PROCNAME" #$(docker ps -fa label=fb_switch --format="{{.Names}}")"
