FROM mariadb:latest

# Configurar variables de entorno con valores fijos (no usar ${...})
ENV MARIADB_ROOT_PASSWORD=P0l1t3cn1c4C3ntr0
ENV MARIADB_DATABASE=ordenamiento
ENV MARIADB_USER=root
ENV MARIADB_PASSWORD=P0l1t3cn1c4C3ntr0

# Copiar script de inicialización
COPY init.sql /docker-entrypoint-initdb.d/

# Configuraciones adicionales si las necesitas
RUN echo "[mysqld]\ncharacter-set-server = utf8mb4\ncollation-server = utf8mb4_unicode_ci\ndefault_authentication_plugin = mysql_native_password" > /etc/mysql/conf.d/custom.cnf

EXPOSE 3306
