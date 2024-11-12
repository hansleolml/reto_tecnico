#!/bin/sh

# Esperar hasta que POD_NAMESPACE tenga un valor
while [ -z "$SECRET_VALUE" ]; do
  echo "Esperando que la variable SECRET_VALUE esté disponible..."
  sleep 1
done

# Usar `sed` para reemplazar el marcador de posición en el archivo HTML
#sed -i "s/\${POD_NAMESPACE}/$POD_NAMESPACE/g" /usr/share/nginx/html/index.html
sed -i '/<span>server_url<\/span><\/p>/a <p class="smaller"><span>Environment:<\/span> <span>'"$SECRET_VALUE"'<\/span><\/p>' /usr/share/nginx/html/index.html

# Iniciar NGINX
nginx -g "daemon off;"
