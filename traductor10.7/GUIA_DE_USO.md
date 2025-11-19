# 📖 Guía de Uso: Integración Léxico + ParserHelper

## 🚀 Inicio Rápido

### Paso 1: Compilar el Proyecto

```bash
cd d:\Descargas\traductor9
javac -encoding UTF-8 -cp "lib/*;src" src/act2/*.java
```

### Paso 2: Ejecutar el Análisis

```bash
# Con archivo personalizado
java -cp "lib/*;src" act2.AnalizadorSintacticoJava src/act2/tu_archivo.txt

# Con archivo por defecto (TestLimpio.txt)
java -cp "lib/*;src" act2.AnalizadorSintacticoJava
```

### Paso 3: Ver Resultados

```
=== TABLA DE SIMBOLOS ===
[Tabla con símbolos detectados]

=== RESULTADOS ===
Errores semánticos: 0
Errores sintácticos: 0
Análisis realizado correctamente
```

---

## 📝 Crear un Archivo de Prueba

Crea `mi_prueba.txt`:

```cpp
// Variables globales
int x = 10;
float y = 3.14;

// Función con parámetros
int suma(int a, int b) {
    return a + b;
}

// Función con variables locales
void procesar() {
    int local_x = 5;
    if (local_x > 0) {
        int anidada = 1;
    }
}
```

Ejecuta:
```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava mi_prueba.txt
```

---

## 🔍 Interpretar Errores Léxicos

### Error 1: Identificador Mal Formado

**Entrada:**
```cpp
int 123abc = 10;
```

**Salida:**
```
ERROR LEXICO: identificador debe iniciar con letra o guion bajo '123abc' en línea 1, columna 5.
```

**Causa:** Los identificadores deben comenzar con letra o guion bajo.

**Solución:**
```cpp
int abc123 = 10;  // ✓ Correcto
```

---

### Error 2: Número Incompleto

**Entrada:**
```cpp
float pi = 3.;
```

**Salida:**
```
ERROR LEXICO: falta digito despues del punto '3.' en línea 1, columna 11.
```

**Causa:** Un número decimal debe tener dígitos después del punto.

**Solución:**
```cpp
float pi = 3.14;  // ✓ Correcto
```

---

### Error 3: Cadena Sin Cierre

**Entrada:**
```cpp
string msg = "Hola
```

**Salida:**
```
ERROR LEXICO: cadena sin cierre en línea 1, columna 13.
```

**Causa:** Las cadenas deben cerrarse con comillas.

**Solución:**
```cpp
string msg = "Hola";  // ✓ Correcto
```

---

### Error 4: Token No Reconocido

**Entrada:**
```cpp
int x @ y = 10;
```

**Salida:**
```
ERROR LEXICO: Token no reconocido '@' en línea 1, columna 7.
```

**Causa:** El símbolo `@` no es válido en este lenguaje.

**Solución:**
```cpp
int x_y = 10;  // ✓ Correcto
```

---

## 📊 Ejemplo Completo: Análisis Paso a Paso

### Entrada: `ejemplo.txt`

```cpp
int numero = 42;

void funcion(int param) {
    int local = 1;
}
```

### Ejecución

```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava ejemplo.txt
```

### Salida

```
=== TABLA DE SIMBOLOS ===
Símbolo         Tipo    Línea  Columna  Alcance              Valor
────────────────────────────────────────────────────────────────────
numero          int     1      5        Global               42
funcion         void    3      6        Global               -
param           int     3      20       Local(funcion)       null
local           int     4      11       Local(funcion)       1
────────────────────────────────────────────────────────────────────

=== RESULTADOS ===
Errores semánticos: 0
Errores sintácticos: 0
Análisis realizado correctamente
```

### Interpretación

- ✅ Variable global `numero` con valor 42
- ✅ Función `funcion` registrada
- ✅ Parámetro `param` en scope local de `funcion`
- ✅ Variable local `local` en scope local de `funcion`
- ✅ Sin errores

---

## 🔧 Modificar el Lexer

Si necesitas agregar nuevas reglas de error léxico:

### 1. Edita `LexicoCPP.flex`

```jflex
/* Nueva regla de error */
mi_patron {
    if (helper != null) {
        helper.reportLexicalError("Descripción del error", yytext(), 
                                 (yyline+1), (yycolumn+1));
    } else {
        System.err.println("ERROR: ...");
    }
    return simbolo(sym.ERROR, yytext());
}
```

### 2. Regenera el Lexer

```bash
javac -encoding UTF-8 -cp "lib/*;src" src/act2/GeneradorLexicoFlex.java
java -cp "lib/*;src" act2.GeneradorLexicoFlex
```

### 3. Recompila Todo

```bash
javac -encoding UTF-8 -cp "lib/*;src" src/act2/*.java
```

### 4. Prueba

```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava tu_archivo.txt
```

---

## 🐛 Troubleshooting

### Problema: "helper has private access in LexicoCPP"

**Causa:** El campo `helper` se generó como `private` en lugar de `public`.

**Solución:** Asegúrate de que en `LexicoCPP.flex` escribiste:
```jflex
%{
   public ParserHelper helper;  // ← "public" es NECESARIO
%}
```

Luego regenera:
```bash
java -cp "lib/*;src" act2.GeneradorLexicoFlex
```

---

### Problema: "Unresolved compilation error: reportLexicalError"

**Causa:** Las reglas en el lexer llaman a un método que no existe.

**Solución:** Asegúrate de que `ParserHelper.java` tiene:
```java
public void reportLexicalError(String msg, String token, int linea, int columna)
```

---

### Problema: NullPointerException en next_token()

**Causa:** El `helper` no fue enlazado (scanner.helper sigue siendo null).

**Solución:** En `AnalizadorSintacticoJava.main()`, verifica:
```java
scanner.helper = parser.helper;  // ← Esta línea DEBE estar
```

---

### Problema: "LexicoCPP.java uses unchecked or unsafe operations"

**Causa:** Advertencia normal de genéricos. NO es un error.

**Solución:** Ignora esta advertencia. El programa funciona correctamente.

```bash
# Si quieres suprimirla:
javac -encoding UTF-8 -cp "lib/*;src" -Xlint:unchecked src/act2/*.java
```

---

## 📈 Monitoreo de Errores

### Ver Solo Errores Léxicos

```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava archivo.txt 2>&1 | grep "ERROR LEXICO"
```

### Contar Errores

```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava archivo.txt 2>&1 | grep "ERROR" | wc -l
```

### Ver Resumen Final

```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava archivo.txt 2>&1 | grep "Errores"
```

---

## 🎯 Casos de Uso Comunes

### Caso 1: Validar Sintaxis de Archivo

```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava mi_codigo.txt
```

**Si ve "Análisis realizado correctamente" → ✅ Archivo válido**

---

### Caso 2: Depuración de Errores

```bash
# Ejecuta y guarda salida en archivo
java -cp "lib/*;src" act2.AnalizadorSintacticoJava archivo.txt > resultado.txt 2>&1

# Luego abre resultado.txt con tu editor
```

---

### Caso 3: Batch Processing

```bash
for %f in (*.txt) do (
    echo Analizando %f
    java -cp "lib/*;src" act2.AnalizadorSintacticoJava %f
    echo.
)
```

---

## 📚 Archivos de Referencia

| Archivo | Propósito |
|---------|-----------|
| `PROYECTO_COMPLETADO.md` | Resumen ejecutivo |
| `INTEGRACION_COMPLETADA.md` | Detalles técnicos completos |
| `REFERENCIA_RAPIDA.md` | Referencia rápida de sintaxis |
| `ARQUITECTURA.md` | Diagramas y arquitectura |
| `GUIA_DE_USO.md` | Esta guía (instrucciones) |

---

## 💡 Tips y Trucos

### Tip 1: Ver Solo Primeras Líneas

```bash
java -cp "lib/*;src" act2.AnalizadorSintacticoJava archivo.txt 2>&1 | Select-Object -First 30
```

### Tip 2: Crear Archivo de Prueba Rápida

```bash
echo int x = 10; > test_rapido.txt
java -cp "lib/*;src" act2.AnalizadorSintacticoJava test_rapido.txt
```

### Tip 3: Limpiar Compilación

```bash
# Eliminar .class generados (excepto archivos necesarios)
del src\act2\*.class
javac -encoding UTF-8 -cp "lib/*;src" src/act2/*.java  # Recompilar
```

### Tip 4: Comparar Salidas

```bash
# Guardar salida de dos análisis
java -cp "lib/*;src" act2.AnalizadorSintacticoJava archivo1.txt > salida1.txt 2>&1
java -cp "lib/*;src" act2.AnalizadorSintacticoJava archivo2.txt > salida2.txt 2>&1

# Comparar
diff salida1.txt salida2.txt
```

---

## ✅ Checklist de Verificación

Antes de usar en producción:

- [ ] ✅ Compilación sin errores
- [ ] ✅ Archivo `TestLimpio.txt` analiza correctamente
- [ ] ✅ Archivo con error léxico reporta error correctamente
- [ ] ✅ Tabla de símbolos se imprime completa
- [ ] ✅ Helper está enlazado (`scanner.helper != null`)
- [ ] ✅ No hay excepciones NullPointerException
- [ ] ✅ Mensaje de error tiene formato correcto

---

## 🎉 ¡Listo!

Ya estás preparado para usar la integración del léxico con ParserHelper. 

**Recomendación:** Comienza con los archivos de prueba proporcionados antes de crear los tuyos propios.

---

## 📞 Soporte Rápido

| Problema | Solución |
|----------|----------|
| No compila | Verifica encoding: `javac -encoding UTF-8` |
| helper es null | Agrega: `scanner.helper = parser.helper;` |
| Error no aparece | Regenera lexer con `GeneradorLexicoFlex` |
| Tabla vacía | Verifica que haya declaraciones en el archivo |
