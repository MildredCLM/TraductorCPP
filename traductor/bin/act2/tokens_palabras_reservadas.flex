/*
    LOPEZ MANCILLA MILDRED CRISTINA
    SANCHEZ CARRILLO ALAN OSWALDO
    SANDOVAL RAMIREZ OSCAR EMILIO
    C++
*/

package act2;
import static act2.Token.Type.*;



%%

%public
%class LexerPalabrasReservadasCPP
%unicode
%line
%column
%type Token

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
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Cadena ");
                return new Token(STRING, yytext(), (yyline+1), (yycolumn+1));
          }

{CARACTER}    {
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Carácter ");
                return new Token(CHAR, yytext(), (yyline+1), (yycolumn+1));
          }

{BOOLEAN}    {
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Booleano ");
                return new Token(BOOLEAN, yytext(), (yyline+1), (yycolumn+1));
          }

{DECIMAL} {
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Número decimal ");
                return new Token(DECIMAL, yytext(), (yyline+1), (yycolumn+1));
          }

{ENTERO}  {
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Número entero ");
                return new Token(ENTERO, yytext(), (yyline+1), (yycolumn+1));
           }


/* ========= PALABRAS RESERVADAS ======== */
/* TIPOS DE DATOS */
int        { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Tipo de dato entero ");
                return new Token(INT, yytext(),(yyline+1),(yycolumn+1)); 
            }
long        { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Tipo de dato long ");                
                return new Token(LONG, yytext(),(yyline+1),(yycolumn+1));
            }
float      { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Tipo de dato float ");                
                return new Token(FLOAT, yytext(),(yyline+1),(yycolumn+1)); 
            }
double     { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Tipo de dato double ");                
                return new Token(DOUBLE, yytext(),(yyline+1),(yycolumn+1)); 
            }
char       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Tipo de dato char ");
                return new Token(CHAR, yytext(),(yyline+1),(yycolumn+1)); 
            }
bool       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Tipo de dato boolean ");                
                return new Token(BOOL, yytext(),(yyline+1),(yycolumn+1)); 
            }
void       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Tipo de dato void ");                
                return new Token(VOID, yytext(),(yyline+1),(yycolumn+1)); 
            }
string      { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Tipo de dato string ");                
                return new Token(STRING, yytext(),(yyline+1),(yycolumn+1)); 
            }            

/* BUCLES */            
if          { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> If ");                
                return new Token(IF, yytext(),(yyline+1),(yycolumn+1)); 
            }
else        { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Else ");                
                return new Token(ELSE, yytext(),(yyline+1),(yycolumn+1)); 
            }
switch      { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> switch ");                
                return new Token(SWITCH, yytext(),(yyline+1),(yycolumn+1)); 
            }
for       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> ciclo for ");                
                return new Token(FOR, yytext(),(yyline+1),(yycolumn+1)); 
            }            
while       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> ciclo while ");                
                return new Token(VOID, yytext(),(yyline+1),(yycolumn+1)); 
            }
do          { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> do ");                
                return new Token(VOID, yytext(),(yyline+1),(yycolumn+1)); 
            }
break       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> break ");                
                return new Token(VOID, yytext(),(yyline+1),(yycolumn+1)); 
            }
continue       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> break ");                
                return new Token(CONTINUE, yytext(),(yyline+1),(yycolumn+1)); 
            }            
return       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> return ");                
                return new Token(RETURN, yytext(),(yyline+1),(yycolumn+1)); 
            }
try       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> try ");                
                return new Token(TRY, yytext(),(yyline+1),(yycolumn+1)); 
            }            
catch       { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> catch ");                
                return new Token(CATCH, yytext(),(yyline+1),(yycolumn+1)); 
            }

/* ========= REGLAS LÉXICAS IDENTIFICADOR ========= */

{ID} {
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Identificador ");
                return new Token(ID, yytext(), (yyline+1), (yycolumn+1));
          }

/* ========= SIMBOLOS ========= */
/* DELIMITADORES */
"{"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Llave de apertura ");                
                /*return TokensTL24B.LLAVE_APERTURA;*/
            }

"}"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" -> Llave de cierre");                
               /* return TokensTL24B.LLAVE_CIERRE; */
            }
"("         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Parentesis de apertura ");                
               /* return TokensTL24B.PARENTESIS_APERTURA; */
            }            
")"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Parentesis de cierre ");                
               /* return TokensTL24B.PARENTESIS_CIERRE; */
            }
"["         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Corchete de apertura");                
               /* return TokensTL24B.CORCHETE_APERTURA; */
            }            
"]"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Corchete de cierre ");                
               /* return TokensTL24B.CORCHETE_CIERRE; */
            }
\"([^\\\"]|\\.)*\"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Literales de cadena ");                
                /* return TokensTL24B.LITERAL_CADENA; */
            }
'([^\\']|\\.)'          { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Literales de caracter ");                
               /* return TokensTL24B.LITERAL_CARACTER; */
            }

/* OPERADORES ARITMETICOS */
"+"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Suma ");                
               /* return TokensTL24B.SUMA; */
            }
"-"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Resta ");                
               /* return TokensTL24B.RESTA; */
            }
"*"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Multiplicación ");                
               /* return TokensTL24B.MULTIPLICACION; */
            }
"/"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Division ");                
               /* return TokensTL24B.DIVISION; */
            }
"%"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Modulo ");                
               /* return TokensTL24B.MODULO; */
            }
/* OPERADORES DE ASIGNACION */
"="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Asignacion ");                
               /* return TokensTL24B.ASIGNACION; */
            }
"+="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Asignacion con suma ");                
               /* return TokensTL24B.A_SUMA; */
            }
"-="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Asignacion con resta ");                
               /* return TokensTL24B.A_RESTA; */
            }
"*="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Asignacion con Multiplicación ");                
               /* return TokensTL24B.A_MULTIPLICACION; */
            }
"/="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Asignacion con Division");                
               /* return TokensTL24B.A_DIVISION; */
            }
"%="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Asignacion con modulo ");                
               /* return TokensTL24B.A_MODULO; */
            }
/* OPERADORES DE INCREMENTO Y DECREMENTO */
"++"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Incremento en 1 ");                
               /* return TokensTL24B.INCREMENTO; */
            }
"--"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Decremento ");                
               /* return TokensTL24B.DECREMENTO; */
            }
/* OPERADORES RELACIONALES */
"=="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Igual a ");                
               /* return TokensTL24B.IGUAL; */
            }
"!="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Diferente de ");                
               /* return TokensTL24B.DIFERENCIA; */
            }
">"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Mayor que ");                
               /* return TokensTL24B.MAYOR; */
            }
"<"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Menor que ");                
               /* return TokensTL24B.MENOR; */
            }
">="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Mayor o igual que ");                
               /* return TokensTL24B.MAYOR_IGUAL; */
            }           
"<="         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Menor o igual que ");                
               /* return TokensTL24B.MENOR_IGUAL; */
            }    
/* OPERADORES LOGICOS */
"&&"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->AND logico ");                
               /* return TokensTL24B.AND; */
            }
"||"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->OR logico ");                
               /* return TokensTL24B.OR; */
            }            
"!"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->NOT logico ");                
               /* return TokensTL24B.NOT; */
            }
/* CONTROL DE FLUJO */
";"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Fin de instruccion ");                
               /* return TokensTL24B.PUNTOYCOMA; */
            }
","         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Separador de expresiones o argumentos ");                
               /* return TokensTL24B.COMA; */
            }            
/* COMENTARIOS */

"//".*         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Comentario de una linea");                
               /* return TokensTL24B.COMENTARIO_LINEA; */
            }            
"/*"([^*]|[\r\n]|"*"[^/])*"*/"         { 
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->Comentario varias lineas ");                
               /* return TokensTL24B.COMENTARIO_LINEAS; */
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

[0-9]+[a-zA-Z_][a-zA-Z0-9_]* {
                System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
                System.out.println(yytext()+" ->ERROR numeros con letras ");      
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


