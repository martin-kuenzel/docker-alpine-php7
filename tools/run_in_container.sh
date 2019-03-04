#!/bin/bash
. "$(dirname $0)"/../app.cfg

SRCDIR=$( realpath $(dirname "$0")/.. )
docker exec -it $(DOCKER_PROCNAME) $@
