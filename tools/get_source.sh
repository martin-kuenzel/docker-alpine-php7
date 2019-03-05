#!/bin/bash

. "$(dirname $0)"/../app.cfg

SRCDIR=$( realpath $(dirname "$0")/.. )
SRC_GITPROJECT="$SRCDIR/src/$PROJECT_NAME" #"$( find src/ -mindepth 1 -maxdepth 1 -type d )"

echo "@@$SRC_GITPROJECT"

echo "Hint: you need to be root to remove git-source @$SRC_GITPROJECT" && \
{ [ -d "$SRC_GITPROJECT" ] && { \
    sudo rm -rfv "$SRC_GITPROJECT" | sed -e '/ *directory */!d' -e '/\([/][^/]*\)\{4,\}/d'; \
}; }; # || SRC_GITPROJECT=$SRCDIR;

#[ -d "$SRCDIR"/src ] || mkdir "$SRCDIR"/src; 

#exit 0
( git clone $SRC_GIT "$SRC_GITPROJECT"  )
#rm $TRANSPATH
