FROM mariadb:latest

# Configurar variables de entorno con valores fijos 
ENV MARIADB_ROOT_PASSWORD=P0l1t3cn1c4C3ntr0
ENV MARIADB_DATABASE=ordenamiento

# Copiar script de inicialización
COPY init.sql /docker-entrypoint-initdb.d/

# Configuraciones adicionales
COPY custom.cnf /etc/mysql/conf.d/

# Exponer el puerto - asegúrate de que esto sea claro
EXPOSE 3306

# Render busca un proceso web, así que necesitamos un script que mantenga el proceso activo y escuche en otro puerto
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Establecer punto de entrada
CMD ["/start.sh"]
