#!/bin/sh
rsync -avup "/var/www/localhost/htdocs/data/" "/var/www/localhost/htdocs/.cache";
sleep 1;
$0;
