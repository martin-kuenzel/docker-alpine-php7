#!/bin/sh
CTIME=5
[ $CTIME -lt 2 ] && CTIME=2;

while true; do
  [ $(( $(date +%s) % $CTIME )) -eq 0 ] && {
    rsync -aup "/var/www/localhost/htdocs/data/" "/var/www/localhost/htdocs/.cache";
    sleep $(( $CTIME / 2 ))
  }
done
exit 0;
