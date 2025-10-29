/*
    LOPEZ MANCILLA MILDRED CRISTINA
    SANCHEZ CARRILLO ALAN OSWALDO
    SANDOVAL RAMIREZ OSCAR EMILIO
    C++
*/

package act2;
import java_cup.runtime.*;
import java.io.*;

parser code {:

    protected Symbol lastErrorToken;
    public void report_fatal_error(String mensaje, Object informacion) { report_error(mensaje, informacion); }
    public void syntax_error(Symbol token_actual) {
        this.lastErrorToken = token_actual;
        String mensajeError = "Error de sintaxis. ";
        if (token_actual != null && token_actual.value != null) {
            mensajeError += "Token inesperado: '" + token_actual.value + "'.";
        }
        System.err.println(mensajeError + " En la línea: " + (token_actual.left + 1) + ", Columna: " + (token_actual.right + 1));
    }
    public void report_error(String mensaje, Object informacion) {
        if (informacion instanceof Symbol) {
            Symbol s = ((Symbol) informacion);
            if (s.left >= 0 && s.right >= 0) {
                System.err.println(mensaje + " Cerca de la línea: " + (s.left + 1) + ", Columna: " + (s.right + 1));
                return;
            }
        }
        System.err.println(mensaje);
    }
:};

/* === TERMINALES === */
// Tipos de dato primitivos
terminal INT, FLOAT, VOID, CHAR, BOOLEAN;

// Palabras reservadas
terminal CLASS;

// Símbolos y Operadores
terminal LLAVE_APERTURA, LLAVE_CIERRE;
terminal PARENTESIS_APERTURA, PARENTESIS_CIERRE;
terminal COMA, PUNTOYCOMA;

// Identificadores y Literales
terminal ID;

// Terminal de error (opcional pero recomendado)
terminal ERROR;


/* === NO TERMINALES === */
non terminal programa, declaracion;
non terminal clase, cuerpo_clase, declaracion_miembro;
non terminal declaracion_metodo, declaracion_variable;
non terminal parametros, lista_parametros;
non terminal parametro;
non terminal cuerpo_metodo, lista_sentencias, sentencia;
non terminal tipo;



/* === REGLAS GRAMATICALES === */
start with programa;

programa ::= declaracion;

declaracion ::= clase;

clase ::= CLASS ID LLAVE_APERTURA cuerpo_clase LLAVE_CIERRE
          {: System.out.println("-> Se reconoció una clase válida: " + valleft); :}
          ;

cuerpo_clase ::= cuerpo_clase declaracion_miembro
               | /* empty */
               ;

declaracion_miembro ::= declaracion_metodo
                      | declaracion_variable
                      ;

declaracion_metodo ::= tipo ID PARENTESIS_APERTURA parametros PARENTESIS_CIERRE LLAVE_APERTURA cuerpo_metodo LLAVE_CIERRE
                     {: System.out.println("-> Se reconoció un método: " + valleft); :}
                     ;

declaracion_variable ::= tipo ID PUNTOYCOMA
                       {: System.out.println("-> Se reconoció una variable de instancia: " + valleft); :}
                       ;

parametros ::= lista_parametros
             | /* empty */  // Permite métodos sin parámetros
             ;

lista_parametros ::= parametro
                   | lista_parametros COMA parametro
                   ;


parametro ::= tipo ID;

cuerpo_metodo ::= /* Acepta un cuerpo vacío o con sentencias */
                  ;

// Tipos de dato válidos
tipo ::= INT | FLOAT | VOID | CHAR | BOOLEAN | ID;