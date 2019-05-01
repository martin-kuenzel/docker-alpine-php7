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

# new installation without manual backup, rsync template into backup
ls "$CUSTOM_CONFIG/backup/config.xml" >/dev/null 2>&1; 
[ $? -ne 0 ] && sudo rsync -avup "$SRC_GITPROJECT/data/" "$CUSTOM_CONFIG/backup";

# rsync from backup into git source
sudo find "$CUSTOM_CONFIG/backup/" -mindepth 1 -name '*' -exec cp -rv {} "$SRC_GITPROJECT/data" \; ;

# not a new installation, rsync cached data into git source
sudo find "$CUSTOM_CONFIG/.tmp/" -mindepth 1 -name '*' -exec cp -rv {} "$SRC_GITPROJECT/data" \; ;
#sudo cp -rv "$CUSTOM_CONFIG/.tmp/" "$SRC_GITPROJECT/data";

#rsync -avup "$CUSTOM_CONFIG"/*.xml "$SRC_GITPROJECT"/data/.sys/
#rsync -avup "$CUSTOM_CONFIG"/.tmp/*.xml "$SCR_FBSWITCH"/data/.cache
#rsync -avup "$CUSTOM_CONFIG"/.tmp/ "$CUSTOM_CONFIG"/.backup/

docker build --rm --force-rm --tag $PROJECT_NAME "$SRCDIR";

. $SRCDIR/run.sh
