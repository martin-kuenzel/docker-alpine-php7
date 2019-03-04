#!/bin/bash
. ./app.cfg

echo #########
echo PROJEKT: $PROCNAME
echo SOURCE: $SRCDIR
echo SUBPROJEKT: $PROJECT_NAME
echo CUSTOM_CONFIG: $(ls "$CUSTOM_CONFIG")
echo #########

sudo $SRCDIR/tools/get_source.sh;
sudo rsync -avup "$CUSTOM_CONFIG"/*.xml "$SRC_GITPROJECT"/data/

#rsync -avup "$CUSTOM_CONFIG"/*.xml "$SRC_GITPROJECT"/data/.sys/
#rsync -avup "$CUSTOM_CONFIG"/.tmp/*.xml "$SCR_FBSWITCH"/data/.cache
rsync -avup "$CUSTOM_CONFIG"/.tmp/*.xml "$CUSTOM_CONFIG"/.backup/

docker build --rm --force-rm --tag $PROJECT_NAME "$SRCDIR";

. $SRCDIR/run.sh
