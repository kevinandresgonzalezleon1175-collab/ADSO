import mysql.connector
import db_conexion

def mostrar_opciones(rol, nombre):
    while True:
        if rol == 3: # ADMINISTRADOR
            print("\n========================================")
            print(f"    PANEL ADMINISTRATIVO - {nombre}")
            print("========================================")
            print("1. Gestionan de Pedidos (Comandas)")
            print("2. Gestion de Usuarios")
            print("3. Gestion de Platos y Menu")
            print("0. Volver al Menu Principal")
            print("----------------------------------------")
            
            opc = input("Seleccione una opc: ")
            
            if opc == "1":
                panel_pedidos()
            elif opc == "2":
                panel_usuarios() # Llama al sub-panel de abajo
            elif opc == "3":
                panel_platos_menu()
            elif opc == "0":
                break
            else:
                print("X Opc no valida.")

        elif rol == 2: # REPARTIDOR
            print("\n========================================")
            print(f"    PANEL DE REPARTO - {nombre}")
            print("========================================")
            print("1. Ver Pedidos Pendientes")
            print("0. Volver al Menu Principal")
            print("----------------------------------------")
            
            opc = input("Seleccione una opc: ")
            
            if opc == "1":
                panel_pedidos()
            elif opc == "0":
                break
            else:
                print("X Opc no valida.")
        else:
            print("Acceso denegado: No tienes los permisos necesarios.")
            break

# --- SUB-PANEL: GESTION DE USUARIOS ---

def panel_usuarios():
    while True:
        print("--- [GESTION DE USUARIOS] ---")
        print("1. Listar todos los Usuarios")
        print("2. Cambiar Rol de un Usuario")
        print("3. Cambiar Estado (Activo/Inactivo)")
        print("4. Eliminar Usuario (Baja Total)")
        print("0. Regresar al Panel Administrativo")
        print("--------------------------------")
        
        opc = input("Seleccione una opc: ")
        
        if opc == "1":
            listar_usuarios()
        elif opc == "2":
            cambiar_rol_usuario()
        elif opc == "3":
            cambiar_estado_usuario()
        elif opc == "4":
            eliminar_usuario_admin()
        elif opc == "0":
            break
        else:
            print("X Opc no valida.")

# --- INSERCIONES Y CONSULTAS EN BASE DE DATOS ---

def listar_usuarios():
    print("--- LISTADO GENERAL DE USUARIOS ---")
    try:
        conn = db_conexion.obtener_conexion()
        if conn:
            cursor = conn.cursor(dictionary=True)
            query = """
                SELECT u.Numero, u.Correo, u.Nombre, u.Estado, r.Tipo AS Rol 
                FROM Usuario u 
                JOIN Usuario_Rol r ON u.id_Rol = r.Rol
            """
            cursor.execute(query)
            usuarios = cursor.fetchall()
            
            if usuarios:
                print(f"{'Numero':<12} | {'Nombre':<15} | {'Correo':<25} | {'Estado':<10} | {'Rol':<10}")
                print("-" * 75)
                for u in usuarios:
                    print(f"{u['Numero']:<12} | {u['Nombre']:<15} | {u['Correo']:<25} | {u['Estado']:<10} | {u['Rol']:<10}")
            else:
                print("No hay usuarios registrados.")
            conn.close()
    except Exception as e:
        print(f"X Error al consultar usuarios: {e}")
    input("Presione Enter para continuar...")
    print ("                                       ")

def cambiar_rol_usuario():
    print("--- CAMBIAR ROL DE USUARIO ---")
    num = input("Ingrese el Numero del usuario: ")
    correo = input("Ingrese el Correo del usuario: ")
    print("Roles: 1. Cliente | 2. Repartidor | 3. Admin")
    nuevo_rol = input("Seleccione el nuevo ID de Rol (1-3): ")
    
    try:
        conn = db_conexion.obtener_conexion()
        if conn:
            cursor = conn.cursor()
            query = "UPDATE Usuario SET id_Rol = %s WHERE Numero = %s AND Correo = %s"
            cursor.execute(query, (nuevo_rol, num, correo))
            conn.commit()
            
            if cursor.rowcount > 0:
                print("Accion completada: Rol actualizado.")
            else:
                print("X No se encontro ningun usuario con esos datos.")
            conn.close()
    except Exception as e:
        print(f"X Error al cambiar el rol: {e}")
    input("Presione Enter para continuar...")
    print("                                          ")

def cambiar_estado_usuario():
    print("--- CAMBIAR ESTADO DE USUARIO ---")
    num = input("Ingrese el Numero del usuario: ")
    correo = input("Ingrese el Correo del usuario: ")
    nuevo_estado = input("Escriba el nuevo estado (Activo/Inactivo): ").strip().capitalize()
    
    try:
        conn = db_conexion.obtener_conexion()
        if conn:
            cursor = conn.cursor()
            query = "UPDATE Usuario SET Estado = %s WHERE Numero = %s AND Correo = %s"
            cursor.execute(query, (nuevo_estado, num, correo))
            conn.commit()
            
            if cursor.rowcount > 0:
                print(f"Accion completada: Estado cambiado a '{nuevo_estado}'.")
            else:
                print("X No se encontro ningun usuario con esos datos.")
            conn.close()
    except Exception as e:
        print(f"X Error al cambiar el estado: {e}")
    input("Presione Enter para continuar...")
    print("                                          ")

def eliminar_usuario_admin():
    print("--- ELIMINAR USUARIO DEL SISTEMA ---")
    num = input("Ingrese el Numero del usuario a borrar: ")
    confirmacion = input(f"Esta seguro de borrar al usuario {num}? Escriba 'SI' para confirmar: ")
    
    if confirmacion.upper() == "SI":
        try:
            conn = db_conexion.obtener_conexion()
            if conn:
                cursor = conn.cursor()
                
                # Modificamos el query directo para no depender de los 3 parametros del procedimiento viejo
                query = "DELETE FROM Usuario WHERE Numero = %s"
                cursor.execute(query, (num,))
                conn.commit()
                
                if cursor.rowcount > 0:
                    print("Usuario eliminado correctamente.")
                else:
                    print("X No se encontro ningun usuario con ese Numero.")
                conn.close()
        except Exception as e:
            print(f"X Error al eliminar usuario: {e}")
    else:
        print("Accion cancelada.")
    input("Presione Enter para continuar...")
    print("                                          ")

def panel_pedidos():
    print("--- GESTION DE PEDIDOS ---")
    print("1. Ver todas las Comandas")
    print("2. Cambiar estado de envio (Pendiente/Camino/Entregado)")
    print("0. Regresar")
    input("Presione Enter para continuar...")
    print("                                          ")
    
def panel_platos_menu():
    print("--- GESTION DE PLATOS Y MENU ---")
    print("1. Ver Platos Disponibles")
    print("2. Agregar Nuevo Plato")
    print("3. Modificar Plato Existente")
    print("4. Eliminar Plato")
    print("0. Regresar")
    input("Presione Enter para continuar...")
    print("                                          ")