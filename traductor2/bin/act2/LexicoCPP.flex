/*
    LOPEZ MANCILLA MILDRED CRISTINA
    SANCHEZ CARRILLO ALAN OSWALDO
    SANDOVAL RAMIREZ OSCAR EMILIO
    C++
*/

package act2;
import java_cup.runtime.Symbol;




%%

%public
%class LexicoCPP
%unicode
%line
%column
%cup

%{
   private Symbol simbolo(int type, Object value)
   {
      return new Symbol(type, (yyline+1), (yycolumn+1), value);
   }
%}


/* ========= REGEX ======== */
DECIMAL = -?[0-9]+[.][0-9]+
ENTERO = -?[0-9]+
CADENA   = \".*\"    // cadena entre comillas dobles
CARACTER = '.'     // carácter entre comillas simples
BOOLEAN = (true|false)
ID = [a-zA-Z_][a-zA-Z0-9_]*
%%
/* ========= REGLAS LÉXICAS LITERALES ========= */
{CADENA}  {
                return simbolo(sym.CADENA, yytext());
          }

{CARACTER}    {
                return simbolo(sym.CARACTER, yytext());
          }

{BOOLEAN}    {
                return simbolo(sym.BOOLEAN, yytext());
          }

{DECIMAL} {
                Sreturn simbolo(sym.DECIMAL, yytext());
          }

{ENTERO}  {
                return simbolo(sym.ENTERO, yytext());
           }


/* ========= PALABRAS RESERVADAS ======== */
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
\"([^\\\"]|\\.)*\"         { 
                return simbolo(sym.LITERAL_CADENA, yytext());
            }
'([^\\']|\\.)'          { 
                return simbolo(sym.LITERAL_CARACTER, yytext());
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
/* CONTROL DE FLUJO */
";"         { 
                return simbolo(sym.PUNTOYCOMA, yytext());
            }
","         { 
                return simbolo(sym.COMA, yytext());
            }            
/* COMENTARIOS */

"//".*         { 
                return simbolo(sym.COMENTARIO_LINEA, yytext());
            }            
"/*"([^*]|[\r\n]|"*"[^/])*"*/"         { 
                return simbolo(sym.COMENTARIO_LINEAS, yytext());
            }

/* ========= ERRORES LEXICOS ========= */
/*IDENTIFICADORES MAL FORMADOS */
[0-9]+[a-zA-Z_][a-zA-Z0-9_]* {
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->ERROR identificador debe iniciar con letra o guion bajo ");      
}

/* LITERALES NUMERICOS INCORRECTOS */
[0-9]+[.] {
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->ERROR falta digito despues del punto");      
}

/* CADENAS MAL FORMADAS */
\"([^\"\\\n]|\\.)*[\n] { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->ERROR cadena sin cierre");                         
}

\'([^\\'\n]|\\.)*[\n] { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->ERROR caracter sin cierre");                         
}

/* CARACTERES NO RECONOCIDOS */

[ \t\n\r]+  { /* Ignorar espacios en blanco */ }
.           { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> ERROR Token no reconocido");                 
            }


