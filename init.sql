-- Crear y usar la base de datos
-- No necesitamos crear la BD porque MariaDB lo hace automáticamente con MARIADB_DATABASE
USE ordenamiento;

-- ordenamiento.estados definition
CREATE TABLE `estados` (
  `cve_estados` int(11) NOT NULL AUTO_INCREMENT,
  `abreviatura` varchar(20) DEFAULT NULL,
  `es_predeterminado` int(11) DEFAULT NULL,
  `latitud` varchar(30) DEFAULT NULL,
  `longitud` varchar(30) DEFAULT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `uuid` uuid DEFAULT NULL,
  PRIMARY KEY (`cve_estados`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ordenamiento.permissions definition
CREATE TABLE `permissions` (
  `id_permission` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `operation` varchar(255) DEFAULT NULL,
  `resourse` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_permission`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ordenamiento.roles definition
CREATE TABLE `roles` (
  `id_rol` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `name` varchar(35) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `UKofx66keruapi6vyqpv6f2or37` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ordenamiento.tipos_localidades definition
CREATE TABLE `tipos_localidades` (
  `cve_tipos_localidades` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) DEFAULT NULL,
  `uuid` uuid DEFAULT NULL,
  PRIMARY KEY (`cve_tipos_localidades`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ordenamiento.users definition
CREATE TABLE `users` (
  `id_user` bigint(20) NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `creation_date` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `last_access` datetime(6) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `non_expired_credentials` bit(1) DEFAULT NULL,
  `not_blocked` bit(1) DEFAULT NULL,
  `not_expired` bit(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ordenamiento.municipios definition
CREATE TABLE `municipios` (
  `cve_municipios` int(11) NOT NULL AUTO_INCREMENT,
  `abreviatura` varchar(255) DEFAULT NULL,
  `es_predeterminado` int(11) DEFAULT NULL,
  `latitud` varchar(30) DEFAULT NULL,
  `longitud` varchar(30) DEFAULT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `cve_estados` int(11) DEFAULT NULL,
  `uuid` uuid DEFAULT NULL,
  PRIMARY KEY (`cve_municipios`),
  KEY `FKqpta3cd5abhcmwyq3rqjvs247` (`cve_estados`),
  CONSTRAINT `FKqpta3cd5abhcmwyq3rqjvs247` FOREIGN KEY (`cve_estados`) REFERENCES `estados` (`cve_estados`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ordenamiento.roles_permissions definition
CREATE TABLE `roles_permissions` (
  `id_rol` bigint(20) NOT NULL,
  `id_permission` bigint(20) NOT NULL,
  PRIMARY KEY (`id_rol`,`id_permission`),
  KEY `FK108af3a237dcjglucidvcnns0` (`id_permission`),
  CONSTRAINT `FK108af3a237dcjglucidvcnns0` FOREIGN KEY (`id_permission`) REFERENCES `permissions` (`id_permission`),
  CONSTRAINT `FKby1b1c1bitxjxhgh6wveltjo7` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ordenamiento.users_roles definition
CREATE TABLE `users_roles` (
  `id_user` bigint(20) NOT NULL,
  `id_rol` bigint(20) NOT NULL,
  PRIMARY KEY (`id_user`,`id_rol`),
  KEY `FKaulyi2lejh5cckb2y8e2mlpud` (`id_rol`),
  CONSTRAINT `FK6ywr92flw5416dup8uc2egb83` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `FKaulyi2lejh5cckb2y8e2mlpud` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ordenamiento.localidades definition
CREATE TABLE `localidades` (
  `cve_localidades` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) DEFAULT NULL,
  `cve_estados` int(11) NOT NULL,
  `cve_municipios` int(11) NOT NULL,
  `cve_tipos_localidades` int(11) DEFAULT NULL,
  `uuid` uuid DEFAULT NULL,
  PRIMARY KEY (`cve_localidades`),
  KEY `FKoltkjbwyofsnurhblbw0h78id` (`cve_estados`),
  KEY `FK36nhp0m6i7wxlav1mcl7i41g` (`cve_municipios`),
  KEY `FKi494yimr9xi6gff7rswa1b9kc` (`cve_tipos_localidades`),
  CONSTRAINT `FK36nhp0m6i7wxlav1mcl7i41g` FOREIGN KEY (`cve_municipios`) REFERENCES `municipios` (`cve_municipios`),
  CONSTRAINT `FKi494yimr9xi6gff7rswa1b9kc` FOREIGN KEY (`cve_tipos_localidades`) REFERENCES `tipos_localidades` (`cve_tipos_localidades`),
  CONSTRAINT `FKoltkjbwyofsnurhblbw0h78id` FOREIGN KEY (`cve_estados`) REFERENCES `estados` (`cve_estados`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insertar los datos de permisos
INSERT INTO permissions (name, description, resourse, operation) VALUES
-- ESTADOS
('CREAR_ESTADO', 'Crear estado', 'estados', 'CREAR'),
('VER_ESTADO', 'Ver estados', 'estados', 'VER'),
('ACTUALIZAR_ESTADO', 'Actualizar estado', 'estados', 'ACTUALIZAR'),
('ELIMINAR_ESTADO', 'Eliminar estado', 'estados', 'ELIMINAR'),
('CREAR_MUNICIPIO', 'Crear municipio', 'municipios', 'CREAR'),
('VER_MUNICIPIO', 'Ver municipios', 'municipios', 'VER'),
('ACTUALIZAR_MUNICIPIO', 'Actualizar municipio', 'municipios', 'ACTUALIZAR'),
('ELIMINAR_MUNICIPIO', 'Eliminar municipio', 'municipios', 'ELIMINAR'),
('CREAR_TIPO_LOCALIDAD', 'Crear tipo de localidad', 'tipos_localidades', 'CREAR'),
('VER_TIPO_LOCALIDAD', 'Ver tipos de localidades', 'tipos_localidades', 'VER'),
('ACTUALIZAR_TIPO_LOCALIDAD', 'Actualizar tipo de localidad', 'tipos_localidades', 'ACTUALIZAR'),
('ELIMINAR_TIPO_LOCALIDAD', 'Eliminar tipo de localidad', 'tipos_localidades', 'ELIMINAR'),
('CREAR_LOCALIDAD', 'Crear localidad', 'localidades', 'CREAR'),
('VER_LOCALIDAD', 'Ver localidades', 'localidades', 'VER'),
('ACTUALIZAR_LOCALIDAD', 'Actualizar localidad', 'localidades', 'ACTUALIZAR'),
('ELIMINAR_LOCALIDAD', 'Eliminar localidad', 'localidades', 'ELIMINAR');

-- Insertar roles
INSERT INTO roles (name, description) VALUES
  ('ADMIN', 'Administrador del sistema con todos los privilegios'),
  ('DEV', 'Desarrollador con acceso completo a todas las operaciones');

-- Asignar todos los permisos a ADMIN
INSERT INTO roles_permissions (id_rol, id_permission)
SELECT r.id_rol, p.id_permission
FROM roles r, permissions p
WHERE r.name = 'ADMIN';

-- Asignar todos los permisos a DEV
INSERT INTO roles_permissions (id_rol, id_permission)
SELECT r.id_rol, p.id_permission
FROM roles r, permissions p
WHERE r.name = 'DEV';

-- Otorgar permisos al usuario de la aplicación (opcional)
GRANT ALL PRIVILEGES ON ordenamiento.* TO 'root'@'%';
FLUSH PRIVILEGES;
