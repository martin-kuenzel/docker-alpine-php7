#!/bin/bash

SRCDIR=$( realpath $(dirname "$0") )
SRC_FBSWITCH="$SRCDIR"/src/$( ls "$SRCDIR/src" ) 
CUSTOM_CONFIG="$SRCDIR/custom_config"

echo $SRCDIR
echo $SRC_FBSWITCH
echo $CUSTOM_CONFIG 

sudo $SRCDIR/get_source_fb_switch.sh; \
sudo rsync -avup "$CUSTOM_CONFIG"/*.xml "$SRC_FBSWITCH"/data/
 

#rsync -avup "$CUSTOM_CONFIG"/*.xml "$SRC_FBSWITCH"/data/.sys/
#rsync -avup "$CUSTOM_CONFIG"/.tmp/*.xml "$SCR_FBSWITCH"/data/.cache
rsync -avup "$CUSTOM_CONFIG"/.tmp/*.xml "$CUSTOM_CONFIG"/backup/

docker build --rm --force-rm --tag fb_switch "$SRCDIR";

$SRCDIR/run.sh
