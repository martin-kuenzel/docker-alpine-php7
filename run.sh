#!/bin/bash
. ./app.cfg

COW "rebuilding and starting Project $PROJECT_NAME"

#( rsync -avup "custom_config/.tmp"/ "src/FB.Switch/data"/.cache; )

( docker stop "$(DOCKER_PROCNAME)" ) >/dev/null 2>&1

( docker rm $(docker ps -af name="$PROJECT_NAME" | awk '{print $1}' ) ) > /dev/null 2>&1
( docker rm "$(DOCKER_PROCNAME)" )  >/dev/null 2>&1

tput setaf 160
COW "Hello $USER. I'm afraid I have to tell you that container $(DOCKER_PROCNAME) is no longer with us. We do not exactly know what happened yet and you are the only one who can find out... Farewell!"
tput setaf 0;
tput sgr0;


# docker run \
#  -it -d -p 80:80 \
#  --label $PROJECT_NAME \
#  -v "$SRC_GITPROJECT":"/var/www/localhost/htdocs" \
#  -v "$CUSTOM_CONFIG/.tmp":"/var/www/localhost/htdocs/data/.cache" \
#  -v "$CUSTOM_CONFIG/backup":"/var/www/localhost/htdocs/data/.sys" \
#  --name $PROJECT_NAME \
#  $PROJECT_NAME

(
    (
    docker run \
        -it -d -p 80:80 \
        --label $PROJECT_NAME \
        -v "$SRC_GITPROJECT":"/var/www/localhost/htdocs" \
        -v "$CUSTOM_CONFIG/.tmp":"/var/www/localhost/htdocs/data/.cache" \
        -v "$CUSTOM_CONFIG/backup":"/var/www/localhost/htdocs/data/.sys" \
        --name $PROJECT_NAME \
        $PROJECT_NAME
    ) && (
        tput setaf 76
        COW "Hey, my name is container $(DOCKER_PROCNAME). Nice to meet you $USER. I am your new pet."
        tput setaf 0;
        tput sgr0;
    )
)
# I 10
# tput setaf 76
# COW "Hey, my name is container $(DOCKER_PROCNAME). Nice to meet you $USER. I am your new pet."
# tput setaf 0;
# tput sgr0;

