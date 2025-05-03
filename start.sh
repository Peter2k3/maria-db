#!/bin/bash

# Iniciar servidor web en segundo plano (requerido por Render)
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

port = int(__import__("os").environ.get("PORT", 8080))
httpd = socketserver.TCPServer(("", port), Handler)
print(f"Servidor web escuchando en puerto {port}")
httpd.serve_forever()
EOL

python3 /server.py &

# Ejecutar MariaDB como proceso principal
exec docker-entrypoint.sh mysqld

