USE CasasJcAlpha

INSERT INTO Usuario_Rol (Rol , Tipo)
VALUES 
    (1, "Cliente"),
    (2, "Repartidor"),
    (3, "Administrador");

INSERT INTO Menu (Nombre_Menu)
VALUES
    ("Menu Del Dia");

INSERT INTO Usuario (Numero, Correo, Nombre, Contrasenia, Direccion, id_Rol) 
VALUES (3232315521, 'Dmo@casasjc.com', 'Andres Leon', '123', 'Sede Principal', 3);


-- 1. PRINCIPIOS (Los granos del seco)
INSERT INTO Ingrediente (Tipo, Nombre_Ingrediente, Cantidad) VALUES 
('Principio', 'Frijoles con Garra', 50),
('Principio', 'Lentejas Caseras', 40),
('Principio', 'Garbanzos Guisados', 30);

-- 2. PROTEÍNAS (Las 3 básicas que pediste)
INSERT INTO Ingrediente (Tipo, Nombre_Ingrediente, Cantidad) VALUES 
('Proteina', 'Carne de Res', 60),
('Proteina', 'Carne de Cerdo', 45),
('Proteina', 'Pollo Frito', 55);

-- 3. ACOMPAÑANTE BASE
INSERT INTO Ingrediente (Tipo, Nombre_Ingrediente, Cantidad) VALUES 
('Acompanante', 'Arroz Blanco', 200);


INSERT INTO Adicional (Tipo, Nombre_Adicional, Precio) VALUES 
('Sopa', 'Sopa de Guineo', 0.00),
('Sopa', 'Sopa de Patacón', 0.00),
('Sopa', 'Sancocho de Res', 0.00);

#Actualiza Los datos
COMMIT;