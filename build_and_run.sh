#!/bin/bash
. ./app.cfg

echo -e '\n#########'
echo PROJEKT: $PROJECT_NAME
echo SOURCE: $SRCDIR
echo CUSTOM_CONFIG: $(ls "$CUSTOM_CONFIG")
echo PLATFORM: $(PF)
echo -e '#########\n'

DOCKERFILE_TMP='./.Dockerfile'

# FROM part creation
echo -e "FROM $(PF)" > "$DOCKERFILE_TMP"

# adding Dockerfile body
grep -vE '^FROM[\t ]*' ./Dockerfile >> "$DOCKERFILE_TMP"

cat "$DOCKERFILE_TMP" > ./Dockerfile

sudo $SRCDIR/tools/get_source.sh;
sudo rsync -avup "$CUSTOM_CONFIG"/*.xml "$SRC_GITPROJECT"/data/

#rsync -avup "$CUSTOM_CONFIG"/*.xml "$SRC_GITPROJECT"/data/.sys/
#rsync -avup "$CUSTOM_CONFIG"/.tmp/*.xml "$SCR_FBSWITCH"/data/.cache
rsync -avup "$CUSTOM_CONFIG"/.tmp/ "$CUSTOM_CONFIG"/.backup/

docker build --rm --force-rm --tag $PROJECT_NAME "$SRCDIR";

. $SRCDIR/run.sh
