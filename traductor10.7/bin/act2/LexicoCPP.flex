/*
    LOPEZ MANCILLA MILDRED CRISTINA
    SANCHEZ CARRILLO ALAN OSWALDO
    SANDOVAL RAMIREZ OSCAR EMILIO
    C++
*/

package act2;
import java_cup.runtime.Symbol;
import act2.ParserHelper;

%%

%public
%class LexicoCPP
%unicode
%line
%column
%cup
%function next_token
%type java_cup.runtime.Symbol
%state STRING_STATE
%state CHAR_STATE

%{
   // Referencia al helper para reportar errores
   private ParserHelper helper;
   
   // Buffer para acumular contenido de strings y caracteres
   private StringBuilder stringBuilder = new StringBuilder();
   private int stringStartLine = 0;
   private int stringStartColumn = 0;
   
   // Constructor que recibe el helper
   public void setHelper(ParserHelper helper){
    this.helper = helper;
   }
   
   private Symbol simbolo(int type, Object value)
   {
      return new Symbol(type, (yyline+1), (yycolumn+1), value);
   }

   private void error(String mensaje) {
       if (helper != null) {

           helper.reportLexicalError("Error Léxico: " + mensaje, yyline+1, yycolumn+1);
       } else {
           // Fallback por si no se ha configurado el helper
           System.err.println("Error Léxico: " + mensaje + " en línea " + (yyline+1));
       }
   } 

%}


/* ========= REGEX ======== */
DECIMAL = -?[0-9]+[.][0-9]+
ENTERO = -?[0-9]+
BOOLEAN = (true|false)
ID = [a-zA-Z_][a-zA-Z0-9_]*
%state STRING_STATE
%state CHAR_STATE
%%

<YYINITIAL> {
[ \t\n\r]+  { /* Ignorar espacios en blanco */ }

/* ========= REGLAS LÉXICAS LITERALES ========= */

{BOOLEAN}    {
                return simbolo(sym.BOOLEAN, yytext());
          }

{DECIMAL} {
                return simbolo(sym.DECIMAL, yytext());
          }

{ENTERO}  {
                return simbolo(sym.ENTERO, yytext());
           }


/* ========= PALABRAS RESERVADAS ======== */

class      { 
                return simbolo(sym.CLASS, yytext());
            } 
private     { 
                return simbolo(sym.PRIVATE, yytext());
            } 
public      { 
                return simbolo(sym.PUBLIC, yytext());
            } 
protected    { 
                return simbolo(sym.PROTECTED, yytext());
            }             
static     { 
                return simbolo(sym.STATIC, yytext());
            } 

/* TIPOS DE DATOS */
int        { 
                return simbolo(sym.INT, yytext());
            }
long        { 
                return simbolo(sym.LONG, yytext());
            }
float      { 
                return simbolo(sym.FLOAT, yytext());
            }
double     { 
                return simbolo(sym.DOUBLE, yytext());
            }
char       { 
                return simbolo(sym.CHAR, yytext());
            }
bool       { 
                return simbolo(sym.BOOL, yytext());
            }
void       { 
                return simbolo(sym.VOID, yytext());
            }
string      { 
                return simbolo(sym.STRING, yytext());
            }                        

/* BUCLES */            
if          { 
                return simbolo(sym.IF, yytext());
            }
else        { 
                return simbolo(sym.ELSE, yytext());
            }
switch      { 
                return simbolo(sym.SWITCH, yytext());
            }
for       { 
                return simbolo(sym.FOR, yytext());
            }            
while       { 
                return simbolo(sym.WHILE, yytext());
            }
do          { 
                return simbolo(sym.DO, yytext());
            }
break       { 
                return simbolo(sym.BREAK, yytext());
            }
continue       { 
                return simbolo(sym.CONTINUE, yytext());
            }            
return       { 
                return simbolo(sym.RETURN, yytext());
            }
try       { 
                return simbolo(sym.TRY, yytext());
            }            
catch       { 
                return simbolo(sym.CATCH, yytext());
            }
case      { 
                return simbolo(sym.CASE, yytext());
            }   
default       { 
                return simbolo(sym.DEFAULT, yytext());
            }         

/* ========= REGLAS LÉXICAS IDENTIFICADOR ========= */

{ID} {
                return simbolo(sym.ID, yytext());
          }

/* ========= SIMBOLOS ========= */
/* DELIMITADORES */
"{"         { 
               return simbolo(sym.LLAVE_APERTURA, yytext());
            }

"}"         { 
                return simbolo(sym.LLAVE_CIERRE, yytext());
            }
"("         { 
                return simbolo(sym.PARENTESIS_APERTURA, yytext());
            }            
")"         { 
                return simbolo(sym.PARENTESIS_CIERRE, yytext());
            }
"["         { 
                return simbolo(sym.CORCHETE_APERTURA, yytext());
            }            
"]"         { 
                return simbolo(sym.CORCHETE_CIERRE, yytext());
            }
\"         { 
             stringBuilder = new StringBuilder();
             stringBuilder.append("\"");
                stringStartLine = yyline + 1;
                stringStartColumn = yycolumn + 1;
                yybegin(STRING_STATE);
            }
\'         { 
             stringBuilder = new StringBuilder();
             stringBuilder.append("'");
                stringStartLine = yyline + 1;
                stringStartColumn = yycolumn + 1;
                yybegin(CHAR_STATE);
            }
/* CONTROL DE FLUJO */
";"         { 
                return simbolo(sym.PUNTOYCOMA, yytext());
            }
","         { 
                return simbolo(sym.COMA, yytext());
            }   
":"      { 
                return simbolo(sym.DOS_PUNTOS, yytext());
            }  

/* OPERADORES ARITMETICOS */
"+"         { 
                return simbolo(sym.SUMA, yytext());
            }
"-"         { 
                return simbolo(sym.RESTA, yytext());
            }
"*"         { 
                return simbolo(sym.MULTIPLICACION, yytext());
            }
"/"         { 
                return simbolo(sym.DIVISION, yytext());
            }
"%"         { 
                return simbolo(sym.MODULO, yytext());
            }
/* OPERADORES DE ASIGNACION */
"="         { 
                return simbolo(sym.ASIGNACION, yytext());
            }
"+="         { 
                return simbolo(sym.A_SUMA, yytext());
            }
"-="         { 
                return simbolo(sym.A_RESTA, yytext());
            }
"*="         { 
                return simbolo(sym.A_MULTIPLICACION, yytext());
            }
"/="         { 
                return simbolo(sym.A_DIVISION, yytext());
            }
"%="         { 
                return simbolo(sym.A_MODULO, yytext());
            }
/* OPERADORES DE INCREMENTO Y DECREMENTO */
"++"         { 
                return simbolo(sym.INCREMENTO, yytext());
            }
"--"         { 
                return simbolo(sym.DECREMENTO, yytext());
            }
/* OPERADORES RELACIONALES */
"=="         { 
                return simbolo(sym.IGUAL, yytext());
            }
"!="         { 
                return simbolo(sym.DIFERENCIA, yytext());
            }
">"         { 
                return simbolo(sym.MAYOR, yytext());
            }
"<"         { 
                return simbolo(sym.MENOR, yytext());
            }
">="         { 
                return simbolo(sym.MAYOR_IGUAL, yytext());
            }           
"<="         { 
                return simbolo(sym.MENOR_IGUAL, yytext());
            }    
/* OPERADORES LOGICOS */
"&&"         { 
                return simbolo(sym.AND, yytext());
            }
"||"         { 
                return simbolo(sym.OR, yytext());
            }            
"!"         { 
                return simbolo(sym.NOT, yytext());
            }
                  
/* COMENTARIOS */

"//".*         { 
                return simbolo(sym.COMENTARIO_LINEA, yytext());
            }            
"/*"([^*]|[\r\n]|"*"[^/])*"*/"         { 
                return simbolo(sym.COMENTARIO_LINEAS, yytext());
            }
/* REGLAS TRANSICION */
\"  \" { 
        stringBuilder.setLength(0); 
        yybegin(STRING_STATE);
    }
 '   { 
        yybegin(CHAR_STATE); 
    }


/* ========= ERRORES LEXICOS ========= */
/*IDENTIFICADORES MAL FORMADOS */
[0-9]+[a-zA-Z_][a-zA-Z0-9_]* {
    error("identificador debe iniciar con letra o guion bajo (" + yytext() + ")");
    return simbolo(sym.LEXICAL_ERROR, yytext());
            }

/* LITERALES NUMERICOS INCORRECTOS */
[0-9]+[.] {
                error("falta digito despues del punto (" + yytext() + ")");
                return simbolo(sym.LEXICAL_ERROR, yytext());
            }

/* CARACTERES NO RECONOCIDOS */

.           { 
               error("Token no reconocido (" + yytext() + ")");
                return simbolo(sym.LEXICAL_ERROR, yytext());
            }
}

/* 4. REGLAS PARA EL ESTADO STRING */
<STRING_STATE> {
    \" {
        yybegin(YYINITIAL);
        return simbolo(sym.LITERAL_CADENA, stringBuilder.toString());
    }
    
    // Contenido válido del string (cualquier cosa menos ", \, o saltos de línea)
    ([^\"\\\n\r] | \\.)+ {
        stringBuilder.append(yytext());
    }

    // Salto de línea cierra el string con error
    [\n\r] {
        error("Cadena sin cierre en línea " + stringStartLine);
        yybegin(YYINITIAL);
        return simbolo(sym.LEXICAL_ERROR, stringBuilder.toString());
    }
    
    // Punto y coma cierra el string con error
    ";" {
        error("Cadena sin cierre en línea " + stringStartLine);
        yybegin(YYINITIAL);
        // Retorna el string y re-procesa el punto y coma
        yytext();
        yypushback(1);
        return simbolo(sym.LEXICAL_ERROR, stringBuilder.toString());
    }
    
    <<EOF>> {
        error("Cadena sin cierre al final del archivo en línea " + stringStartLine);
        yybegin(YYINITIAL);
        return simbolo(sym.LEXICAL_ERROR, stringBuilder.toString());
    }
}

/* 5. REGLAS PARA EL ESTADO CHAR */
<CHAR_STATE> {
    // Comilla de cierre: finaliza el char
    \' {
        yybegin(YYINITIAL);
        return simbolo(sym.LITERAL_CARACTER, stringBuilder.toString());
    }
    
    // Contenido válido del char (un solo carácter)
    [^\\'\n\r] {
        stringBuilder.append(yytext());
    }
    
    // Escape sequences (e.g., \n, \t, \')
    \\[\\\'ntrfb0] {
        stringBuilder.append(yytext());
    }

    // Salto de línea cierra el char con error
    [\n\r] {
        error("Caracter sin cierre en línea " + stringStartLine);
        yybegin(YYINITIAL);
        return simbolo(sym.LEXICAL_ERROR, stringBuilder.toString());
    }
    
    // Punto y coma cierra el char con error
    ";" {
        error("Caracter sin cierre en línea " + stringStartLine);
        yybegin(YYINITIAL);
        yypushback(1);
        return simbolo(sym.LEXICAL_ERROR, stringBuilder.toString());
    }
    
    <<EOF>> {
        error("Caracter sin cierre al final del archivo en línea " + stringStartLine);
        yybegin(YYINITIAL);
        return simbolo(sym.LEXICAL_ERROR, stringBuilder.toString());
    }
}


