#!/bin/bash
. ./app.cfg

COW "rebuilding and starting Project $PROJECT_NAME"

#( rsync -avup "custom_config/.tmp"/ "src/FB.Switch/data"/.cache; )

( docker stop "$(DOCKER_PROCNAME)" ) >/dev/null 2>&1
COW "Hello $USER. I'm afraid I have to tell you that container $(DOCKER_PROCNAME) is no longer with us. We do not exactly know what happened yet and you are the only one who can find out... Farewell!"

( docker rm $(docker ps -af label="$PROJECT_NAME" -f status='exited' -f status='created' |awk '{print $1}' ) )   >/dev/null 2>&1
( docker rm "$(DOCKER_PROCNAME)" )  >/dev/null 2>&1

docker run \
 -it -d -p 80:80 \
 --label fb_switch \
 -v "$PROJECT_NAME":"/var/www/localhost/htdocs" \
 -v "$CUSTOM_CONFIG/.tmp":"/var/www/localhost/htdocs/data/.cache" \
 -v "$CUSTOM_CONFIG/backup":"/var/www/localhost/htdocs/data/.sys" \
 fb_switch 

COW "Hey, my name is container $(DOCKER_PROCNAME). Nice to meet you $USER."

