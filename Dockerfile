FROM mariadb:latest

ENV MARIADB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}
ENV MARIADB_DATABASE=${DB_NAME}
ENV MARIADB_USER=${DB_USER}
ENV MARIADB_PASSWORD=${DB_PASSWORD}

# Copiar script de inicialización
COPY init.sql /docker-entrypoint-initdb.d/

# Configuración personalizada de MariaDB (opcional)
COPY my.cnf /etc/mysql/conf.d/custom.cnf

EXPOSE 3306

# El comando por defecto de la imagen base es correcto, no necesitamos modificarlo
