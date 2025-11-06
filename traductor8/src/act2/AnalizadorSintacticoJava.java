package act2;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.io.InputStreamReader;

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

            System.out.println("Errores semanticos: " + parser.erroresSem);
            System.out.println("Errores sintacticos: " + parser.erroresSint);
            if (parser.erroresSem == 0 && parser.erroresSint == 0) {
                System.out.println("Analisis realizado correctamente");
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
