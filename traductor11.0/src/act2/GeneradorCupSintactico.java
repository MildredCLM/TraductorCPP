package act2;

import java.io.File;
import java.io.IOException;

public class GeneradorCupSintactico {
    public static void main(String[] args) throws IOException, Exception {

        String pathFlex = "src\\act2\\LexicoCPP.flex";
        File fileLex = new File(pathFlex);
        if (!fileLex.exists()) {
            pathFlex = "act2\\LexicoCPP.flex";
            fileLex = new File(pathFlex);
        }

        jflex.Main.generate(fileLex);

        String pathCup = "src\\act2\\sintacticoCPP.cup";
        String destDir = "src\\act2";
        if (!new File(pathCup).exists()) {
            pathCup = "act2\\sintacticoCPP.cup";
            destDir = "act2";
        }

        String[] parametros = { "-destdir", destDir, "-parser", "Sintactico",
                "-progress", pathCup };
        java_cup.Main.main(parametros);

        System.out.println("Lexer (LexicoCPP.java) y Parser (Sintactico.java) generados correctamente");
    }

}
