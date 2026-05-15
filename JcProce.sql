USE CasasJcAlpha;

DROP PROCEDURE IF EXISTS Registrar_Usuario;
DROP PROCEDURE IF EXISTS Editar_Perfil_Usuario;
DROP PROCEDURE IF EXISTS Desactivar_Usuario;
DROP PROCEDURE IF EXISTS Eliminar_Todo_Usuario;

DELIMITER //

/* 1. REGISTRAR CON MANEJO DE EXCEPCIÓN */
CREATE PROCEDURE Registrar_Usuario(
    IN p_numero INT(10), 
    IN p_correo VARCHAR(50),
    IN p_nombre VARCHAR(30),
    IN p_contrasenia VARCHAR(20),
    IN p_direccion VARCHAR(50)
)
BEGIN
    -- Declaramos el manejo de error (llave duplicada o error general)
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'X Error: Los datos son inválidos o el usuario ya existe.' AS Mensaje;
        ROLLBACK;
    END;

    START TRANSACTION;
        INSERT INTO Usuario (Numero, Correo, Nombre, Contrasenia, Direccion)
        VALUES (p_numero, p_correo, p_nombre, p_contrasenia, p_direccion);
    COMMIT;
    
    SELECT ':3 Registro exitoso' AS Mensaje;
END //

/* 2. EDITAR PERFIL (Requiere Correo por ser Llave Compuesta) */
CREATE PROCEDURE Editar_Perfil_Usuario(
    IN p_numero INT(10), 
    IN p_correo VARCHAR(50), -- Agregado para identificar la PK completa
    IN p_contrasenia_actual VARCHAR(20),
    IN p_nuevo_nombre VARCHAR(30),
    IN p_nuevo_correo VARCHAR(50),
    IN p_nueva_direccion VARCHAR(50),
    IN p_nueva_contrasenia VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'X Error: No se pudo actualizar el perfil.' AS Mensaje;
    END;

    UPDATE Usuario 
    SET Nombre = p_nuevo_nombre,
        Correo = p_nuevo_correo,
        Direccion = p_nueva_direccion,
        Contrasenia = p_nueva_contrasenia
    WHERE Numero = p_numero AND Correo = p_correo AND Contrasenia = p_contrasenia_actual;
    
    SELECT '✅ Perfil actualizado' AS Mensaje;
END //

/* 3. DESACTIVAR */
CREATE PROCEDURE Desactivar_Usuario(
    IN p_numero INT(10), 
    IN p_correo VARCHAR(50),
    IN p_contrasenia_confirmacion VARCHAR(20)
)
BEGIN
    UPDATE Usuario 
    SET Estado = 'Inactivo'
    WHERE Numero = p_numero AND Correo = p_correo AND Contrasenia = p_contrasenia_confirmacion;
    
    SELECT '⚠️ Cuenta desactivada' AS Mensaje;
END //

/* 4. ELIMINAR TODO */
CREATE PROCEDURE Eliminar_Todo_Usuario(
    IN p_numero INT(10), 
    IN p_correo VARCHAR(50),
    IN p_contrasenia_emergencia VARCHAR(20)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'X Error: No se puede eliminar por integridad de datos.' AS Mensaje;
    END;

    DELETE FROM Usuario 
    WHERE Numero = p_numero AND Correo = p_correo AND Contrasenia = p_contrasenia_emergencia;
    
    SELECT '🗑️ Usuario eliminado permanentemente' AS Mensaje;
END //

DELIMITER ;