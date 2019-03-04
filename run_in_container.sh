#!/bin/bash
docker exec $(docker ps -f label=fb_switch --format="{{.Names}}") "$@"
