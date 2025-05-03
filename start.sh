#!/bin/bash

# Iniciar MariaDB en segundo plano
docker-entrypoint.sh mysqld &

# Obtener el puerto de la variable de entorno PORT o usar 8080 por defecto
PORT=${PORT:-8080}
echo "Iniciando servidor web en puerto $PORT"

# Crear un servidor web simple con Python en lugar de netcat
cat > /server.py << EOL
import http.server
import socketserver
from http import HTTPStatus

class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"MariaDB is running")

port = $PORT
httpd = socketserver.TCPServer(("", port), Handler)
print("Servidor web escuchando en puerto", port)
httpd.serve_forever()
EOL

# Ejecutar el servidor web
python3 /server.py
