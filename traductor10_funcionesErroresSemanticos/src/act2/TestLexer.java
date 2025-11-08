package act2;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.Reader;
import java_cup.runtime.Symbol;

public class TestLexer {
    public static void main(String[] args) throws Exception {
        Reader r = new BufferedReader(new FileReader("src/act2/TestSintacticoCPP.txt"));
        LexicoCPP lex = new LexicoCPP(r);
        Symbol s;
        while ((s = lex.next_token()).sym != sym.EOF) {
            System.out.println("TOKEN: " + s.sym + " -> " + getName(s.sym) + " , text='" + s.value + "' (line " + (s.left+1) + ", col " + (s.right+1) + ")");
        }
        System.out.println("EOF");
    }
    static String getName(int symId) {
        try {
            java.lang.reflect.Field[] fs = act2.sym.class.getFields();
            for (java.lang.reflect.Field f : fs) {
                if (f.getType() == int.class) {
                    int val = f.getInt(null);
                    if (val == symId) return f.getName();
                }
            }
        } catch (Exception e) {
            // ignore
        }
        return Integer.toString(symId);
    }
}
