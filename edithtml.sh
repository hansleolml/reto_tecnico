#!/bin/sh
envsubst '${SECRET_VALUE}' < /usr/share/nginx/html/index.html > /usr/share/nginx/html/index.html
nginx -g "daemon off;"
