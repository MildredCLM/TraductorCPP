/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package act2;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

/**
 *
 * @author DocentesUTJCCD
 */
public class AnalisisLexico {
     public static void main(String[] args) {
        System.out.println("LOPEZ MANCILLA MILDRED CRISTINA \n" + //
                        " SANCHEZ CARRILLO ALAN OSWALDO \n" + //
                        " SANDOVAL RAMIREZ OSCAR EMILIO\n");
         
         
        String test = "src/act2/prueba_palabras_reservadas.txt";

        try (Reader reader = new FileReader(test)) {
            // Crear la instancia del lexer directamente
            LexerPalabrasReservadasCPP lexer = new LexerPalabrasReservadasCPP(reader);

            // Leer tokens y procesarlos
           act2.Token token;
            while ((token = lexer.yylex()) != null) {
                System.out.println("Token: " + token);
                System.out.println("");
            }
        } catch (IOException e) {
            System.err.println("Error al leer el archivo de prueba.");
            e.printStackTrace();
        }
        
        
        System.out.println("\n LOPEZ MANCILLA MILDRED CRISTINA \n SANCHEZ CARRILLO ALAN OSWALDO \n SANDOVAL RAMIREZ OSCAR EMILIO");
    }

    
}