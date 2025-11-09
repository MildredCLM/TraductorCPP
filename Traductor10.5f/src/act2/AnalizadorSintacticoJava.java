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

            LexicoCPP scanner = new LexicoCPP(lector);
            Sintactico parser = new Sintactico(scanner);

            parser.parse();
            parser.helper.imprimirTablaSimbolos();

            // Acceder a los errores desde el helper
            System.out.println("\n=== RESULTADOS ===");
            System.out.println("Errores semánticos: " + parser.helper.erroresSem);
            System.out.println("Errores sintácticos: " + parser.helper.erroresSint);
            
            if (parser.helper.erroresSem == 0 && parser.helper.erroresSint == 0) {
                System.out.println("Análisis realizado correctamente");
            } else {
                System.out.println("Se encontraron errores en el análisis");
            }
        } catch (Exception ex) {
            System.err.println("Error fatal: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}