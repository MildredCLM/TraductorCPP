package act2;

import java.io.File;
import java.io.IOException;

public class GeneradorCupSintactico {
    public static void main(String[] args) throws IOException, Exception {
        //String pathFlex="C:\\Users\\7053\\Documents\\NetBeansProjects\\UEDL_COMPILADORES\\src\\sintactico\\java_lexico_sintactico.jflex";

//        String pathFlex="src\\sintactico\\lexico.jflex";
        //File file=new File(pathFlex);
        //jflex.Main.generate(file);
//        String[] parametrosLex = {pathFlex};
//        jflex.Main.generate(parametrosLex);
        
      

        //String[] parametros = {"-parser", "Sintactico", "C:\\Users\\7053\\Documents\\NetBeansProjects\\UEDL_COMPILADORES\\src\\sintactico\\sintactico.cup"};
        String[] parametros = {"-destdir", "src\\act2","-parser", "Sintactico", 
            "-progress", "src\\act2\\sintacticoCPP.cup"};
        java_cup.Main.main(parametros);
        
    }
    
   
}
