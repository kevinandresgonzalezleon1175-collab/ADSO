USE CasasJcAlpha

#"SELECCION COMPLETA POR TABLAS"
SELECT * FROM Usuario_Rol

SELECT * FROM Usuario

SELECT * FROM Menu

SELECT * FROM Categoria

SELECT * FROM Ingrediente

SELECT * FROM Plato

#"SELECCIONES COMPUESTA"
SELECT 
    Nombre, 
    Numero AS Telefono, 
    CASE 
        WHEN id_Rol = 1 THEN 'Cliente'
        WHEN id_Rol = 2 THEN 'Repartidor'
        WHEN id_Rol = 3 THEN 'Administrador'
        ELSE 'Sin Rol'
    END AS Usuarios_Rol
FROM Usuario;