# 📋 REFERENCIA RÁPIDA: Integración Léxico + ParserHelper

## 🔗 Enlace del Lexer con el Parser

**Antes (Sin Integración):**
```java
LexicoCPP scanner = new LexicoCPP(lector);
Sintactico parser = new Sintactico(scanner);
// El lexer no tenía acceso al helper del parser
```

**Ahora (Integrado):**
```java
LexicoCPP scanner = new LexicoCPP(lector);
Sintactico parser = new Sintactico(scanner);
scanner.helper = parser.helper;  // ✅ ENLACE DINÁMICO
```

## 🛠️ Cambios en el Lexer (LexicoCPP.flex)

### Declaración del Helper
```jflex
%{
   public ParserHelper helper;  // ✅ Campo público
   
   public LexicoCPP(java.io.Reader input, ParserHelper helper) {
       this(input);
       this.helper = helper;    // ✅ Constructor con inyección
   }
%}
```

### Reportar Error Léxico
**Antes:**
```jflex
[0-9]+[a-zA-Z_][a-zA-Z0-9_]* {
    System.out.print("Linea:"+(yyline+1)+", Columna:"+(yycolumn+1)+"\t");
    System.out.println(yytext()+" ->ERROR identificador debe iniciar...");
    return simbolo(sym.ERROR, yytext());
}
```

**Ahora:**
```jflex
[0-9]+[a-zA-Z_][a-zA-Z0-9_]* {
    if (helper != null) {
        helper.reportLexicalError("identificador debe iniciar con letra o guion bajo", 
                                 yytext(), (yyline+1), (yycolumn+1));
    } else {
        System.err.println("..."); // Fallback
    }
    return simbolo(sym.ERROR, yytext());
}
```

## 📝 Método en ParserHelper

```java
public void reportLexicalError(String msg, String token, int linea, int columna) {
    String m = "ERROR LEXICO: " + msg;
    if (token != null && !token.isEmpty()) 
        m += " '" + token + "'";
    if (linea > 0 && columna > 0) 
        m += " en línea " + linea + ", columna " + columna;
    System.err.println(m + ".");
}
```

## 🎬 Flujo Completo

```
main()
  ├─ Leer archivo
  ├─ Crear LexicoCPP(reader)
  ├─ Crear Sintactico(scanner)
  ├─ scanner.helper = parser.helper  ← ENLACE
  ├─ parse()
  │   └─ Si hay error léxico:
  │       └─ helper.reportLexicalError(...)
  └─ imprimirTablaSimbolos()
```

## ✅ Reglas Actualizadas (5 total)

| Regla | Descripción |
|-------|-------------|
| `[0-9]+[a-zA-Z_][a-zA-Z0-9_]*` | Identificador mal formado |
| `[0-9]+[.]` | Número sin dígitos después del punto |
| `\"([^\"\\\n]..)*[\n]` | Cadena sin cierre |
| `\'([^\\'\n]..)*[\n]` | Carácter sin cierre |
| `.` | Token no reconocido |

## 🔄 Regeneración del Lexer

Después de modificar `LexicoCPP.flex`:

```bash
# Compilar el generador
javac -encoding UTF-8 -cp "lib/*;src" src/act2/GeneradorLexicoFlex.java

# Ejecutar para regenerar LexicoCPP.java
java -cp "lib/*;src" act2.GeneradorLexicoFlex
```

**Resultado:**
- `src/act2/LexicoCPP.java` regenerado
- `src/act2/LexicoCPP.java~` backup del archivo anterior

## 🧪 Verificación de Funcionamiento

### Test 1: Sin errores
```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava src/act2/TestLimpio.txt
# Resultado: Tabla de símbolos limpia, 0 errores
```

### Test 2: Con error léxico
```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava src/act2/TestSintacticoCPP.txt
# Resultado: ERROR LEXICO: identificador debe iniciar... '9abc' en línea 19...
```

## 🎯 Ventajas

- ✅ **Un único punto de entrada** para todos los errores
- ✅ **Formato consistente** en todos los mensajes
- ✅ **Fácil de mantener** - cambios en un solo lugar
- ✅ **Inyección de dependencias** dinámica
- ✅ **Fallback automático** si helper es null

## 📚 Archivos Clave

- `ParserHelper.java` - Helper con método `reportLexicalError`
- `LexicoCPP.flex` - Especificación del lexer con reglas de error
- `LexicoCPP.java` - Lexer generado (regenerar si cambias .flex)
- `AnalizadorSintacticoJava.java` - Punto de entrada que enlaza lexer-parser
