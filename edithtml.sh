#!/bin/sh

# Esperar hasta que POD_NAMESPACE tenga un valor
while [ -z "$SECRET_VALUE" ]; do
  echo "Esperando que la variable SECRET_VALUE esté disponible..."
  sleep 1
done

sed -i '/<span>server_url<\/span><\/p>/a <p class="smaller"><span>Environment2:<\/span> <span>'"$ENVIRONMENT"'<\/span><\/p>' /usr/share/nginx/html/index.html
sed -i '/<span>server_url<\/span><\/p>/a <p class="smaller"><span>Secret value2:<\/span> <span>'"$SECRET_VALUE"'<\/span><\/p>' /usr/share/nginx/html/index.html

# Iniciar NGINX
nginx -g "daemon off;"
