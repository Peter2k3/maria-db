#!/bin/bash

# Iniciar MariaDB en segundo plano
docker-entrypoint.sh mysqld &

# Iniciar un servidor web simple que responda en el puerto 10000 (o el que prefieras)
# Esto es solo para que Render pueda detectar un puerto abierto
while true; do
    { echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nMariaDB is running"; } | nc -l -p 10000
done
