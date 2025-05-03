# Imagen base oficial de MariaDB
FROM mariadb:11.3

# Variables de entorno (puedes sobrescribirlas desde Render)
ENV MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD}
ENV MARIADB_DATABASE=${MARIADB_DATABASE:-ordenamiento}

# Crear carpeta para config adicional
RUN mkdir -p /etc/mysql/conf.d

# Instalar solo lo necesario
RUN apt-get update && apt-get install -y python3 && rm -rf /var/lib/apt/lists/*

# Copiar archivo de configuración personalizado si lo tienes
COPY custom.cnf /etc/mysql/conf.d/

# Copiar scripts de inicialización de la base de datos
COPY init.sql /docker-entrypoint-initdb.d/

# Copiar script de arranque
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exponer solo el puerto del contenedor que usará Render internamente
EXPOSE 3306
EXPOSE 8080  # Render requiere que el contenedor escuche en algún puerto HTTP

# Iniciar MariaDB y el servidor web para Render
CMD ["/start.sh"]

