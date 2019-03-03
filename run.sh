#!/bin/bash

COWSAY(){ COW=$(find /usr/share/cowsay/cows -name '*.cow' -type f | sort -R | head -1); cowsay -f "$COW" "$@"; }

DOCKER_PROCNAME=$(docker ps -fa label=fb_switch --format="{{.Names}}") 

#( rsync -avup "custom_config/.tmp"/ "src/FB.Switch/data"/.cache; )

COWSAY "GOOBYE $DOCKER_PROCNAME"

( docker stop "$DOCKER_PROCNAME" ) >/dev/null 2>&1
( docker rm "$DOCKER_PROCNAME" )  >/dev/null 2>&1

docker run \
 -it -d -p 80:80 \
 --label fb_switch \
 -v "$(pwd)"/custom_config/.tmp:/var/www/localhost/htdocs/data/.cache \
 fb_switch 

COWSAY "HELLO $(docker ps -fa label=fb_switch --format="{{.Names}}")"
