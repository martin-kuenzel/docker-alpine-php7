#!/bin/bash
. ./app.cfg

echo -e '\n#########'
echo PROJEKT: $PROJECT_NAME
echo SOURCE: $SRCDIR
echo CUSTOM_CONFIG: $(ls "$CUSTOM_CONFIG")
echo PLATFORM: $(PLATFORM)
echo -e '#########\n'

( cat <<HDOC
FROM $(PLATFORM)

RUN $(INSTALLATION_ROUTINES)

$(EXPOSE_PORTS)

ADD custom_config/bin /usr/local/bin

CMD ( \
 chmod 500 -R "/usr/local/bin"; \
 for i in \$( find /usr/local/bin/services -type f ); do \
  ( ( "\$i" >/dev/null 2>&1 ) & ); \
 done; \
 $(CMD_PARTS) \
)
HDOC
) > ./Dockerfile

# get the current version of underlying software from GIT
sudo $SRCDIR/tools/get_source.sh;

# if new installation without manual backup, cp template into backup
ls "$CUSTOM_CONFIG/backup/config.xml" >/dev/null 2>&1; 
{ [ $? -ne 0 ] && sudo rsync -avup "$SRC_GITPROJECT/data/" "$CUSTOM_CONFIG/backup"; } || {
  # else cp from backup into git source
  sudo find "$CUSTOM_CONFIG/backup/" -mindepth 1 -name '*' -exec cp -r {} "$SRC_GITPROJECT/data" \; ;
}

# not a new installation, rsync cached data into git source
sudo find "$CUSTOM_CONFIG/.tmp/" -mindepth 1 -name '*' -exec cp -r {} "$SRC_GITPROJECT/data" \; ;

docker build --rm --force-rm --tag $PROJECT_NAME "$SRCDIR";

. $SRCDIR/run.sh
