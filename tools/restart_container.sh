#!/bin/bash
. "$(dirname $0)"/../app.cfg

./tools/stop_container.sh;
./tools/start_container.sh;