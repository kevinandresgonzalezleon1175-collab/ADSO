USE CasasJcAlpha;

DELIMITER //

/* 1. REGISTRAR CON INT(10) */
CREATE PROCEDURE Registrar_Usuario(
    IN p_numero INT(10), 
    IN p_correo VARCHAR(50),
    IN p_nombre VARCHAR(30),
    IN p_contrasenia VARCHAR(20),
    IN p_direccion VARCHAR(50),
    IN p_id_rol INT
)
BEGIN
    INSERT INTO Usuario (Numero, Correo, Nombre, Contrasenia, Direccion, id_rol)
    VALUES (p_numero, p_correo, p_nombre, p_contrasenia, p_direccion, p_id_rol);
END //

/* 2. EDITAR PERFIL CON INT(10) */
CREATE PROCEDURE Editar_Perfil_Usuario(
    IN p_numero INT(10), 
    IN p_contrasenia_actual VARCHAR(20),
    IN p_nuevo_nombre VARCHAR(30),
    IN p_nuevo_correo VARCHAR(50),
    IN p_nueva_direccion VARCHAR(50),
    IN p_nueva_contrasenia VARCHAR(20)
)
BEGIN
    UPDATE Usuario 
    SET Nombre = p_nuevo_nombre,
        Correo = p_nuevo_correo,
        Direccion = p_nueva_direccion,
        Contrasenia = p_nueva_contrasenia
    WHERE Numero = p_numero AND Contrasenia = p_contrasenia_actual;
END //

/* 3. DESACTIVAR CON INT(10) */
CREATE PROCEDURE Desactivar_Usuario(
    IN p_numero INT(10), 
    IN p_contrasenia_confirmacion VARCHAR(20)
)
BEGIN
    UPDATE Usuario 
    SET Estado = 'Inactivo'
    WHERE Numero = p_numero AND Contrasenia = p_contrasenia_confirmacion;
END //

/* 4. ELIMINAR CON INT(10) */
CREATE PROCEDURE Eliminar_Todo_Usuario(
    IN p_numero INT(10), 
    IN p_contrasenia_emergencia VARCHAR(20)
)
BEGIN
    DELETE FROM Usuario 
    WHERE Numero = p_numero AND Contrasenia = p_contrasenia_emergencia;
END //

DELIMITER ;