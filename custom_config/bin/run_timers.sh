#!/bin/sh
CTIME=60
[ $CTIME -lt 2 ] && CTIME=2;

while true; do
  [ $(( $(date +%s) % $CTIME )) -eq 0 ] && {
    wget -q http://127.0.0.1/index.php?timerrun -O - >/dev/null 2>&1;
    sleep $(( $CTIME / 2 ))
  }
done
exit 0;
