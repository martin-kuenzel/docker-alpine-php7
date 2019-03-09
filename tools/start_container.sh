#!/bin/bash
. "$(dirname $0)"/../app.cfg

docker start $(DOCKER_PROCNAME)