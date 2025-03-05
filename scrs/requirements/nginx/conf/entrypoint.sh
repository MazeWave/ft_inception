#!/bin/sh

# Create needed folders if not here
mkdir -p /var/run/nginx /var/log/nginx
chown -R nginx:nginx /var/run/nginx /var/log/nginx

# start nginx in foreground
exec nginx -g 'daemon off;'