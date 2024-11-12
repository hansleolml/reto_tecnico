#!/bin/sh

while [ -z "$SECRET_VALUE" ]; do
  echo "Esperando que la variable SECRET_VALUE esté disponible..."
  sleep 1
done

sed -i '/<span>server_url<\/span><\/p>/a <p class="smaller"><span>Secret value:<\/span> <span>'"$SECRET_VALUE"'<\/span><\/p>' /usr/share/nginx/html/index.html
sed -i '/<span>server_url<\/span><\/p>/a <p class="smaller"><span>Environment:<\/span> <span>'"$ENVIRONMENT"'<\/span><\/p>' /usr/share/nginx/html/index.html

nginx -g "daemon off;"
