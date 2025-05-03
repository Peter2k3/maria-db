#!/bin/bash

# Obtener el puerto de la variable de entorno PORT o usar 8080 por defecto
PORT=${PORT:-8080}
echo "Iniciando servidor web en puerto $PORT"

# Crear un servidor web simple con Python
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

# Iniciar el servidor web en segundo plano
python3 /server.py &

# Iniciar MariaDB como proceso principal
exec docker-entrypoint.sh mysqld

