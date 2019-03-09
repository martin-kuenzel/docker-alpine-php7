#!/bin/bash
. "$(dirname $0)"/../app.cfg

docker stop $(DOCKER_PROCNAME)