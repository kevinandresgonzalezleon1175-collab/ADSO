USE CasasJcAlpha;

-- 1. Si tienes llaves foráneas apuntando a esta tabla, es mejor desactivar los checks un momento
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Modificamos la columna Numero a BIGINT para que soporte hasta 20 dígitos
-- También aplicamos los NOT NULL y el DEFAULT para el Nombre
ALTER TABLE Usuario 
    MODIFY COLUMN Numero BIGINT NOT NULL,
    MODIFY COLUMN Correo VARCHAR(50) NOT NULL,
    MODIFY COLUMN Nombre VARCHAR(30) DEFAULT 'New User',
    MODIFY COLUMN Contrasenia VARCHAR(20) NOT NULL,
    MODIFY COLUMN Direccion VARCHAR(50) NOT NULL;

USE CasasJcAlpha;
ALTER TABLE Usuario MODIFY COLUMN Numero BIGINT NOT NULL;

ALTER TABLE Pedido MODIFY COLUMN U_Numero INT(10) NOT NULL;

SET FOREIGN_KEY_CHECKS = 1;

-- 3. Volvemos a activar los checks
SET FOREIGN_KEY_CHECKS = 1;


USE CasasJcAlpha;

-- Desactivamos revisiones para poder modificar las llaves foráneas sin errores
SET FOREIGN_KEY_CHECKS = 0;

-- 1. Modificar Usuario
ALTER TABLE Usuario MODIFY COLUMN Numero BIGINT NOT NULL;

-- 2. Modificar Comanda (Debe coincidir con Usuario)
ALTER TABLE Comanda MODIFY COLUMN U_Numero BIGINT NOT NULL;

SET FOREIGN_KEY_CHECKS = 1;

USE CasasJcAlpha;

DROP PROCEDURE IF EXISTS Registrar_Usuario;

DELIMITER //

CREATE PROCEDURE Registrar_Usuario(
    IN p_numero BIGINT,          -- Cambiado a BIGINT para soportar los celulares de 10 dígitos
    IN p_correo VARCHAR(50),
    IN p_nombre VARCHAR(30),
    IN p_contrasenia VARCHAR(20),
    IN p_direccion VARCHAR(50),
    IN p_id_rol INT              -- Agregado el sexto parámetro para el Rol
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'X Error: No se pudo completar el registro.' AS Resultado;
        ROLLBACK;
    END;

    START TRANSACTION;
        INSERT INTO Usuario (Numero, Correo, Nombre, Contrasenia, Direccion, id_rol)
        VALUES (p_numero, p_correo, p_nombre, p_contrasenia, p_direccion, p_id_rol);
    COMMIT;
    
    SELECT ':3 Registro exitoso' AS Resultado;
END //

DELIMITER ;