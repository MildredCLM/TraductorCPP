# Integración del Léxico con ParserHelper

## Resumen de Cambios

Se ha realizado la integración completa del léxico (LexicoCPP) con el ParserHelper para centralizar el manejo de errores léxicos.

### 1. **ParserHelper.java** ✅
   - ✅ Agregado nuevo método `reportLexicalError(String msg, String token, int linea, int columna)`
   - ✅ Reporta errores léxicos en formato consistente con otros errores
   - Ubicación: línea ~316

### 2. **LexicoCPP.flex** ✅
   - ✅ Agregado campo público `helper` de tipo `ParserHelper`
   - ✅ Agregado constructor que recibe el helper: `public LexicoCPP(java.io.Reader input, ParserHelper helper)`
   - ✅ Modificadas todas las reglas de error léxico para usar `helper.reportLexicalError(...)`
   - ✅ Con fallback a `System.err.println()` si helper es null (compatibilidad)
   - Cambios en 5 reglas de error:
     - Identificadores mal formados
     - Literales numéricos incorrectos
     - Cadenas mal formadas
     - Caracteres mal formados
     - Caracteres no reconocidos

### 3. **LexicoCPP.java** (Regenerado) ✅
   - ✅ Regenerado desde LexicoCPP.flex usando JFlex
   - ✅ Incluye el campo `helper` público
   - ✅ Incluye el constructor con parámetro helper
   - ✅ Todas las reglas de error llaman a `helper.reportLexicalError(...)`

### 4. **AnalizadorSintacticoJava.java** ✅
   - ✅ Modificado para enlazar el helper del parser con el lexer
   - ✅ Línea clave: `scanner.helper = parser.helper;`
   - Flujo:
     1. Crear LexicoCPP (scanner)
     2. Crear Sintactico (parser) que inicializa su propio helper
     3. Asignar `scanner.helper = parser.helper;` para compartir la misma instancia

## Ventajas de esta Integración

1. **Centralización de errores**: Todos los errores (léxicos, sintácticos, semánticos) se reportan a través del mismo ParserHelper
2. **Consistencia**: Formato uniforme para todos los tipos de errores
3. **Rastreabilidad**: Los errores léxicos ahora se pueden contar/registrar junto con otros errores
4. **Flexibilidad**: El lexer puede llamar a métodos adicionales del helper si es necesario
5. **Dinámica**: El helper se inyecta en tiempo de ejecución, permitiendo diferentes configuraciones

## Ejecución de Prueba

```bash
# Compilar
javac -encoding UTF-8 -cp "lib/*;src" src/act2/ParserHelper.java src/act2/LexicoCPP.java src/act2/AnalizadorSintacticoJava.java

# Ejecutar
java -cp "lib/*;src" act2.AnalizadorSintacticoJava src/act2/TestLimpio.txt
```

## Resultado

Cuando hay un error léxico (ej: identificador `9abc`):
```
ERROR LEXICO: identificador debe iniciar con letra o guion bajo '9abc' en línea 19, columna 5.
```

Cuando todo es correcto:
```
=== TABLA DE SIMBOLOS ===
[tabla con todos los símbolos globales y locales]

=== RESULTADOS ===
Errores semánticos: 0
Errores sintácticos: 0
Análisis realizado correctamente
```

## Archivos Modificados

1. `src/act2/ParserHelper.java` - Nuevo método `reportLexicalError`
2. `src/act2/LexicoCPP.flex` - Campo helper y reglas de error actualizadas
3. `src/act2/LexicoCPP.java` - Regenerado automáticamente
4. `src/act2/AnalizadorSintacticoJava.java` - Enlace del helper con el lexer

## Archivos de Prueba

- `src/act2/TestLimpio.txt` - Sin errores léxicos
- `src/act2/TestSintacticoCPP.txt` - Con error léxico de identificador (`9abc`)
