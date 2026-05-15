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
            # Quitamos el id_rol de la llamada; la DB lo asigna sola
            cursor.callproc('Registrar_Usuario', (num, em, nom, pw, dir))
            conn.commit()
            print(":3 Registro exitoso.")
            conn.close()
            
            # Pasamos al main solo con lo necesario
            JcMain.menu_principal(num, nom)
            
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
            
            # Traemos solo Numero y Nombre
            query = "SELECT Numero, Nombre FROM Usuario WHERE Numero = %s AND Contrasenia = %s"
            cursor.execute(query, (doc, clave))
            usuario = cursor.fetchone()
            
            if usuario:
                print(f"¡Bienvenido de nuevo {usuario['Nombre']}!")
                conn.close()
                # Salto al módulo principal
                JcMain.menu_principal(usuario['Numero'], usuario['Nombre'])
            else:
                print("X Credenciales incorrectas.")
                conn.close()
                
    except Exception as e:
        print(f"X Error en el inicio de sesión: {e}")

if __name__ == "__main__":
    inicio()