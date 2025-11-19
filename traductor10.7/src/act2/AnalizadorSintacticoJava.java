package act2;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.Reader;

public class AnalizadorSintacticoJava {
    public static void main(String[] args) {
        try {
            Reader lector;
            if (args.length > 0) {
                lector = new BufferedReader(new FileReader(args[0]));
            } else {
                lector = new BufferedReader(new FileReader("src/act2/TestSintacticoCPP.txt"));
            }

            // Crear una instancia del parser primero para obtener el helper
            LexicoCPP scanner = new LexicoCPP(lector);
            Sintactico parser = new Sintactico(scanner);
            
            // Enlazar el helper del parser con el lexer
            scanner.setHelper(parser.helper);

            parser.parse();
            parser.helper.imprimirTablaSimbolos();

            // Acceder a los errores desde el helper
            System.out.println("\n=== RESULTADOS ===");
            System.out.println("Errores semanticos: " + parser.helper.erroresSem);
            System.out.println("Errores sintacticos: " + parser.helper.erroresSint);
            System.out.println("Errores lexicos: " + parser.helper.erroresLex);
            
            if (parser.helper.erroresSem == 0 && parser.helper.erroresSint == 0) {
                System.out.println("Analisis realizado correctamente");
            } else {
                System.out.println("Se encontraron errores en el analisis");
            }
        } catch (Exception ex) {
            System.err.println("Error fatal: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}