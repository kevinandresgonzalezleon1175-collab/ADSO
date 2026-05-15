#Base de datos Restaurante Jc Casas
CREATE DATABASE IF NOT EXISTS CasasJcAlpha;
USE CasasJcAlpha;

CREATE TABLE IF NOT EXISTS Usuario_Rol(
    Rol INT(1) PRIMARY KEY,
    Tipo VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Usuario(
    Numero INT(10) NOT NULL,
    Correo VARCHAR(50) NOT NULL, 
    Nombre VARCHAR(30) DEFAULT "New User" ,
    Contrasenia VARCHAR(20) NOT NULL,
    Direccion VARCHAR(50) NOT NULL,
    Estado VARCHAR(20) DEFAULT "Activo",
    id_Rol INT(1) DEFAULT 1,
    PRIMARY KEY (Numero, Correo),
    FOREIGN KEY (id_Rol) REFERENCES Usuario_Rol(Rol) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Menu(
    Id_Menu INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Menu VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Categoria(
    Id_Categoria INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Categoria VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Ingrediente(
    Id_Ingrediente INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(30) NOT NULL,
    Nombre_Ingrediente VARCHAR(30) NOT NULL,
    Cantidad INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Plato(
    Id_Plato INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Plato VARCHAR(30) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    Id_Categoria INT,
    Id_Principio INT,
    Id_Proteina INT,
    Id_Acompanante INT,
    FOREIGN KEY (Id_Categoria) REFERENCES Categoria(Id_Categoria) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (Id_Principio) REFERENCES Ingrediente(Id_Ingrediente),
    FOREIGN KEY (Id_Proteina) REFERENCES Ingrediente(Id_Ingrediente),
    FOREIGN KEY (Id_Acompanante) REFERENCES Ingrediente(Id_Ingrediente)
);

CREATE TABLE IF NOT EXISTS Adicional(
    Id_Adicional INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(30) NOT NULL,
    Nombre_Adicional VARCHAR(30) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Pedido(
    Id_Pedido INT PRIMARY KEY AUTO_INCREMENT,
    U_Numero INT(10) NOT NULL,
    Id_Plato INT NOT NULL,
    Id_Adicional INT,
    Cantidad INT NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (U_Numero) REFERENCES Usuario(Numero) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Id_Plato) REFERENCES Plato(Id_Plato),
    FOREIGN KEY (Id_Adicional) REFERENCES Adicional(Id_Adicional)
);

