USE CasasJcAlpha

INSERT INTO Usuario_Rol (Rol , Tipo)
VALUES 
    (1, "Cliente"),
    (2, "Repartidor"),
    (3, "Administrador");

INSERT INTO Menu (Nombre_Menu)
VALUES
    ("Menu Del Dia");



#Actualiza Los datos
COMMIT;