import db_conexion

enlace = db_conexion.obtener_conexion()

if enlace:
    print("✅ ¡Enlace exitoso! Python y Laragon están conectados.")
    enlace.close() # Siempre cerramos la llave al terminar
else:
    print("🚀 El enlace falló. Verifica que MySQL en Laragon esté en verde (Start).")