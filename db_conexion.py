import mysql.connector
from mysql.connector import Error

def obtener_conexion():
    """
    Establece la conexión con la base de datos CasasJcAlpha en Laragon.
    """
    try:
        conexion = mysql.connector.connect(
            host='localhost',
            user='root',      # Usuario por defecto de Laragon
            password='',      # Contraseña por defecto (vacía)
            database='CasasJcAlpha'
        )
        
        if conexion.is_connected():
            return conexion

    except Error as e:
        print(f"X Error al conectar a la base de datos: {e}")
        return None