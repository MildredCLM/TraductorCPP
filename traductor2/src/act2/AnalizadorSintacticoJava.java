/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package act2;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java_cup.runtime.Symbol;

/**
 *
 * @author 7053
 */
public class AnalizadorSintacticoJava {
    public static void main(String[] args) throws IOException {
        Reader lector = new BufferedReader(new FileReader("src/act2/TestSintacticoCPP.txt"));
        Sintactico s = new Sintactico(new LexicoCPP(lector));
        
//        String contenido= "byte  numero1;";
//        JavaSintactico s = new JavaSintactico(new JavaLexico(new StringReader(contenido)));
        try {
            System.out.println(s.parse());
            System.out.println("Analisis realizado correctamente");
        } catch (Exception ex) {
            //Symbol sym = s.getS();
            //System.out.println("Error de sintaxis. Linea: " + (sym.right + 1) +
             // " Columna: " + (sym.left + 1) + ", Texto: \"" + sym.value + "\"");
        System.out.println(ex.getMessage());
        }
    }
}
