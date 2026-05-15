
USE CasasJcAlpha;

CALL Registrar_Usuario(12345, 'zai@manga.com', 'Zai Codex', 'pass123', 'Calle 10 #5-20', 1);

-- Llamamos al procedimiento con los datos de Julio Cesar
-- El último parámetro es '3', que corresponde al rol de Administrador
CALL Registrar_Usuario(
    123456789,             -- p_numero (Documento/Teléfono)
    'juliocesar@mail.com',  -- p_correo
    'Julio Cesar',          -- p_nombre
    'admin123',             -- p_contrasenia
    'Sede Central JC',      -- p_direccion
    3                       -- p_id_rol (ADMINISTRADOR)
);
