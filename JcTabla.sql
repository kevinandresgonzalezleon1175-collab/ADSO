#Base de datos Restaurante Jc Casas
DROP DATABASE IF EXISTS CasasJcAlpha;
CREATE DATABASE CasasJcAlpha;
USE CasasJcAlpha;

-- Desactivamos cheques para evitar errores de orden al crear/modificar
SET FOREIGN_KEY_CHECKS = 0;

-- 1. TABLA ROLES
CREATE TABLE Usuario_Rol(
    Rol INT PRIMARY KEY,
    Tipo VARCHAR(20) NOT NULL
);

-- 2. TABLA USUARIO (Cambio Crítico a BIGINT)
CREATE TABLE Usuario(
    Numero BIGINT NOT NULL,
    Correo VARCHAR(50) NOT NULL, 
    Nombre VARCHAR(30) DEFAULT "New User",
    Contrasenia VARCHAR(20) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    Estado VARCHAR(20) DEFAULT "Activo",
    id_Rol INT DEFAULT 1,
    PRIMARY KEY (Numero, Correo),
    FOREIGN KEY (id_Rol) REFERENCES Usuario_Rol(Rol) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 3. TABLAS DE ESTRUCTURA (Pasamos a BIGINT para evitar incompatibilidad)
CREATE TABLE Menu(
    Id_Menu BIGINT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Menu VARCHAR(30) NOT NULL
);

CREATE TABLE Categoria(
    Id_Categoria BIGINT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Categoria VARCHAR(30) NOT NULL
);

CREATE TABLE Ingrediente(
    Id_Ingrediente BIGINT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(30) NOT NULL,
    Nombre_Ingrediente VARCHAR(30) NOT NULL,
    Cantidad INT NOT NULL
);

-- 4. TABLA PLATO
CREATE TABLE Plato(
    Id_Plato BIGINT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Plato VARCHAR(30) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Id_Categoria BIGINT,
    Id_Principio BIGINT,
    Id_Proteina BIGINT,
    Id_Acompanante BIGINT,
    FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (Id_Principio) REFERENCES Ingrediente(Id_Ingrediente),
    FOREIGN KEY (Id_Proteina) REFERENCES Ingrediente(Id_Ingrediente),
    FOREIGN KEY (Id_Acompanante) REFERENCES Ingrediente(Id_Ingrediente)
);

CREATE TABLE Adicional(
    Id_Adicional BIGINT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(30) NOT NULL,
    Nombre_Adicional VARCHAR(30) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
);

-- 5. TABLA PEDIDO (Simplificada con BIGINT)
CREATE TABLE Pedido(
    Id_Pedido BIGINT PRIMARY KEY AUTO_INCREMENT,
    Id_Plato BIGINT NOT NULL,
    Id_Adicional BIGINT DEFAULT NULL,
    Cantidad INT NOT NULL DEFAULT 1,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Id_Plato) REFERENCES Plato(Id_Plato),
    FOREIGN KEY (Id_Adicional) REFERENCES Adicional(Id_Adicional)
);

-- 6. TABLA COMANDA (Sincronizada con Usuario y Pedido)
CREATE TABLE Comanda(
    Id_Comanda BIGINT PRIMARY KEY AUTO_INCREMENT,
    U_Numero BIGINT NOT NULL,
    U_Correo VARCHAR(50) NOT NULL,
    Id_Pedido BIGINT NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Estado_Envio VARCHAR(20) DEFAULT "Pendiente",
    Total_Pagar DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_usuario_comanda 
        FOREIGN KEY (U_Numero, U_Correo) 
        REFERENCES Usuario(Numero, Correo) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Id_Pedido) REFERENCES Pedido(Id_Pedido) ON DELETE CASCADE
);
