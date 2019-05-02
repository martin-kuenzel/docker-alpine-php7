#!/bin/sh
while true; do
  [ $(( $(date +%s) % 60 )) -eq 0 ] && {
    wget -q http://127.0.0.1/index.php?timerrun -O - >/dev/null 2>&1;
  }
done
exit 0;
