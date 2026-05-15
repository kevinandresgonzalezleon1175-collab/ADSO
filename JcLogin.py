import db_conexion
import JcMain 

def inicio():
    while True:
        print("--------------------------------")
        print("      ACCESO CASAS JC")
        print("--------------------------------")
        print("1. Registrarse")
        print("2. Iniciar Sesión")
        print("0. Salir")
        print("--------------------------------")
        
        opcion = input("Seleccione: ")
        
        if opcion == "1":
            registrar()
        elif opcion == "2":
            login()
        elif opcion == "0":
            print("Saliendo del sistema...")
            break

def registrar():
    print("\n--- NUEVO REGISTRO ---")
    try:
        print("--------------------------------")
        num = int(input("Numero Telefonico: "))
        em = input("Correo: ")
        nom = input("Nombre: ")
        pw = input("Contraseña: ")
        dir = input("Dirección: ")
        print("--------------------------------")
        
        conn = db_conexion.obtener_conexion()
        if conn:
            cursor = conn.cursor()
            # Pasamos un 1 por defecto (Rol de Cliente) para cumplir con los parámetros del procedimiento
            cursor.callproc('Registrar_Usuario', (num, em, nom, pw, dir, 1))
            conn.commit()
            print(":3 Registro exitoso.")
            conn.close()
            
            # Entra al menú principal con Rol = 1 (Cliente)
            JcMain.menu_principal(num, nom, 1)
            
    except Exception as e:
        print(f"X Error al registrar: {e}")

def login():
    print("--------------------------------")
    print("--- INICIO DE SESIÓN ---")
    doc = input("Numero Telefonico: ")
    clave = input("Contraseña: ")
    print("--------------------------------")
    
    try:
        conn = db_conexion.obtener_conexion()
        if conn:
            cursor = conn.cursor(dictionary=True)
            
            # CORRECCIÓN AQUÍ: Agregamos 'id_Rol' a la consulta SQL
            query = "SELECT Numero, Nombre, id_Rol FROM Usuario WHERE Numero = %s AND Contrasenia = %s"
            cursor.execute(query, (doc, clave))
            usuario = cursor.fetchone()
            
            if usuario:
                print(f"¡Bienvenido de nuevo {usuario['Nombre']}!")
                conn.close()
                
                # CORRECCIÓN AQUÍ: Enviamos los 3 datos requeridos por JcMain
                JcMain.menu_principal(usuario['Numero'], usuario['Nombre'], usuario['id_Rol'])
            else:
                print("X Credenciales incorrectas.")
                conn.close()
                
    except Exception as e:
        print(f"X Error en el inicio de sesión: {e}")

if __name__ == "__main__":
    inicio()