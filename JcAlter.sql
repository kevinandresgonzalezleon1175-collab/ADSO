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