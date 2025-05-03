FROM mariadb:latest

# Configurar variables de entorno con valores fijos 
ENV MARIADB_ROOT_PASSWORD=P0l1t3cn1c4C3ntr0
ENV MARIADB_DATABASE=ordenamiento

# Copiar script de inicialización
COPY init.sql /docker-entrypoint-initdb.d/

# Configuraciones adicionales si las necesitas
RUN echo "[mysqld]\ncharacter-set-server = utf8mb4\ncollation-server = utf8mb4_unicode_ci" > /etc/mysql/conf.d/custom.cnf

EXPOSE 3306
