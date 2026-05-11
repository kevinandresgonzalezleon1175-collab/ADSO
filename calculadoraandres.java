import java.util.Scanner;

class Calculadora {
    double num1;
    double num2;

    public void resultado() {
        System.out.println("Procesando operación...");
    }
}

class Suma extends Calculadora {
    public void sumar() {
        System.out.println(" > Resultado Suma: " + (num1 + num2));
    }
}

class Resta extends Calculadora {
    public void resta() {
        System.out.println(" > Resultado Resta: " + (num1 - num2));
    }
}

class Multiplicacion extends Calculadora {
    public void multiplicacion() {
        System.out.println(" > Resultado Multiplicación: " + (num1 * num2));
    }
}

class Division extends Calculadora {
    public void division() {
        if (num2 != 0) {
            System.out.println(" > Resultado División: " + (num1 / num2));
        } else {
            System.out.println(" > Error: No se puede dividir entre cero.");
        }
    }
}


public class Main {
    public static void main(String[] args) {
        Scanner teclado = new Scanner(System.in);
        
        System.out.println("--- CALCULADORA ---");
        
        System.out.print("Digite el primer número: ");
        double n1 = teclado.nextDouble();
        
        System.out.print("Digite el segundo número: ");
        double n2 = teclado.nextDouble();

        // Paso B: Pedir la operación como texto
        System.out.print("Operacion a realizar (Suma, Resta, Mult, Div): ");
        String op = teclado.next(); 

        System.out.println("-----------------------");

        // Paso C: Decidir qué "juguete" fabricar según lo que escribió el usuario
        
        // Si eligió Suma o 's'
        if (op.equalsIgnoreCase("Suma") || op.equalsIgnoreCase("s")) {
            Suma miSuma = new Suma(); // Fabricamos el objeto
            miSuma.num1 = n1;         // Le pasamos los datos
            miSuma.num2 = n2;
            miSuma.sumar();           // Ejecutamos la acción
        } 
        
        // Si eligió Resta o 'r'
        else if (op.equalsIgnoreCase("Resta") || op.equalsIgnoreCase("r")) {
            Resta miResta = new Resta();
            miResta.num1 = n1;
            miResta.num2 = n2;
            miResta.resta();
        }

        // Si eligió Multiplicación o 'm'
        else if (op.equalsIgnoreCase("Mult") || op.equalsIgnoreCase("m")) {
            Multiplicacion miMult = new Multiplicacion();
            miMult.num1 = n1;
            miMult.num2 = n2;
            miMult.multiplicacion();
        }

        // Si eligió División o 'd'
        else if (op.equalsIgnoreCase("Div") || op.equalsIgnoreCase("d")) {
            Division miDiv = new Division();
            miDiv.num1 = n1;
            miDiv.num2 = n2;
            miDiv.division();
        }

        // Si escribió cualquier otra cosa
        else {
            System.out.println("Operación no reconocida.");
        }

        System.out.println("-----------------------");
        
        teclado.close();
    }
}
