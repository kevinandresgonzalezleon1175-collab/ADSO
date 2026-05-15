import mysql.connector # Asegúrate de tener tu conexión lista
import JcPanels # Importamos el nuevo módulo de administración

def menu_principal(numero, nombre, rol):
    while True:
        print("========================================")
        print(f"   RESTAURANTE CASAS JC - {nombre}")
        print("========================================")
        print(f"Usuario: {numero} | Rol: {rol}") # Informativo para tus pruebas de ADSO
        print("1. Ver Menú del Día")
        print("2. Armar Pedido (Seco + Sopa)")
        print("3. Ver mis Comandas")
        
        # Opción oculta: Solo aparece si el rol es Repartidor (2) o Admin (3)
        if rol in [2, 3]:
            print("4. Paneles de Administración")
            
        print("0. Cerrar Sesión")
        print("----------------------------------------")
        
        opcion = input("Seleccione una opción: ")

        if opcion == "1":
            print("[Lógica en desarrollo] Mostrando platos disponibles...")
        elif opcion == "2":
            print("[Lógica en desarrollo] Iniciando selección de ingredientes...")
        elif opcion == "3":
            print("[Lógica en desarrollo] Consultando tus pedidos...")
        elif opcion == "4":
            # Verificación de seguridad antes de saltar al otro módulo
            if rol in [2, 3]:
                JcPanels.mostrar_opciones(rol, nombre)
            else:
                print("X Error: Acceso denegado. Opción no permitida para clientes.")
        elif opcion == "0":
            print(f"¡Hasta pronto {nombre}! Sesión cerrada.")
            break
        else:
            print("X Opción no válida. Intente de nuevo.")