#!/bin/bash

LOCALPATH=$( realpath "$(dirname $0)" )"/src/FB.Switch"
( ( [ -d "$LOCALPATH" ] && rm -rf "$LOCALPATH" ) );

#( ( [ -d "$TRANSPATH" ] && rm "$TRANSPATH" ) & );
#TRANSPATH=$(mktemp)

( git clone https://github.com/bombcheck/FB.Switch.git "$LOCALPATH" )
#rm $TRANSPATH

