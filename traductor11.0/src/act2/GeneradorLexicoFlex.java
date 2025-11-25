package act2;

import java.io.File;

public class GeneradorLexicoFlex {
    public static void main(String[] args) throws Exception {
        String[] jflexArgs = {
            "-d", "src/act2",
            "src/act2/LexicoCPP.flex"
        };
        jflex.Main.main(jflexArgs);
        System.out.println("Lexer regenerado exitosamente.");
    }
}
