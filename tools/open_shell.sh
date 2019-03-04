#!/bin/bash
docker exec -it $(docker ps -fa label=fb_switch --format="{{.Names}}") /bin/sh
