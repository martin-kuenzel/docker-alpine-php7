#!/bin/sh
while true; do
  [ $(( $(date +%s) % 60 )) -eq 0 ] && {
    rsync -avup "/var/www/localhost/htdocs/data/" "/var/www/localhost/htdocs/.cache";
  }
done
