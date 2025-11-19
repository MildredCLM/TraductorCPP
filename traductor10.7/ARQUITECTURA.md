# 🏛️ Diagrama de Arquitectura: Integración Léxico + ParserHelper

## 📐 Diagrama General

```
┌─────────────────────────────────────────────────────────────────┐
│                     AnalizadorSintacticoJava                     │
│                          (Punto de Entrada)                      │
└────────────────────────┬────────────────────────────────────────┘
                         │
         ┌───────────────┼───────────────┐
         │               │               │
    ┌────▼────┐    ┌────▼────┐    ┌────▼────────────┐
    │   LEXER  │    │  PARSER  │    │ ParserHelper    │
    │(LexicoCPP)    │(Sintactico)   │ (Centralizado) │
    └────┬────┘    └────┬────┘    └────▲────────────┘
         │               │              │
         │ Enlace:       │              │
         │ scanner.      │              │
         │ helper =      │              │
         │ parser.       │              │
         │ helper  ──────┴──────────────┘
         │
    ┌────▼──────────────────────────┐
    │  Reglas de Error Léxico:       │
    │  - Identificador mal formado   │
    │  - Número incompleto           │
    │  - Cadena sin cierre           │
    │  - Carácter sin cierre         │
    │  - Token no reconocido         │
    │                                │
    │  Todas llaman:                 │
    │  helper.reportLexicalError()   │
    └────────────────────────────────┘
```

---

## 🔄 Flujo de Ejecución Completo

```
START
  │
  ├─► Leer archivo de entrada
  │    └─► Reader
  │
  ├─► Crear LexicoCPP(reader)
  │    └─► Scanner inicializado
  │        └─► helper = null (por defecto)
  │
  ├─► Crear Sintactico(scanner)
  │    └─► Parser inicializado
  │        └─► helper = new ParserHelper()
  │            └─► Ámbito global creado
  │
  ├─► ENLACE DINÁMICO
  │    └─► scanner.helper = parser.helper  ⭐ CLAVE
  │        └─► Ahora el lexer puede reportar a ParserHelper
  │
  ├─► parser.parse()
  │    │
  │    ├─► Mientras se analiza el código:
  │    │    │
  │    │    ├─► Si se encuentra token válido
  │    │    │    └─► LexicoCPP.next_token() → Symbol
  │    │    │
  │    │    ├─► Si se encuentra error léxico
  │    │    │    └─► if (helper != null)
  │    │    │        └─► helper.reportLexicalError(...)
  │    │    │            └─► Imprime: "ERROR LEXICO: ..."
  │    │    │
  │    │    ├─► Si se encuentra error sintáctico
  │    │    │    └─► parser.syntax_error(Symbol)
  │    │    │        └─► helper.reportSyntaxError(...)
  │    │    │            └─► Imprime: "ERROR SINTÁCTICO: ..."
  │    │    │
  │    │    └─► Durante análisis semántico
  │    │         └─► helper.reportSemanticError(...)
  │    │             └─► Imprime: "ERROR SEMANTICO: ..."
  │    │
  │    └─► parse() retorna
  │
  ├─► parser.helper.imprimirTablaSimbolos()
  │    └─► Imprime tabla unificada de símbolos
  │
  ├─► Mostrar resultados
  │    ├─► Errores semánticos: X
  │    ├─► Errores sintácticos: Y
  │    └─► Errores léxicos: Z (reportados durante parse)
  │
  └─► END

```

---

## 📊 Componentes Clave

### 1. LexicoCPP (Lexer)
```
┌─────────────────────────────┐
│      LexicoCPP              │
├─────────────────────────────┤
│ Atributos:                  │
│  • public ParserHelper      │
│    helper                   │
│                             │
│ Métodos:                    │
│  • LexicoCPP(Reader)        │ ← Antiguo
│  • LexicoCPP(Reader,        │ ← NUEVO
│    ParserHelper)            │
│  • next_token():Symbol      │
│                             │
│ Reglas de Error:            │
│  Cada una usa:              │
│  if (helper != null) {      │
│    helper.reportLexical     │
│    Error(...)               │
│  }                          │
└─────────────────────────────┘
```

### 2. ParserHelper (Centralizado)
```
┌────────────────────────────────────────┐
│         ParserHelper                   │
├────────────────────────────────────────┤
│ Gestión de Errores:                    │
│  • reportLexicalError(...) ← NUEVO     │
│  • reportSemanticError(...)            │
│  • reportSyntaxError(...)              │
│                                        │
│ Gestión de Símbolos:                   │
│  • insertarSimbolo(...)                │
│  • buscarSimboloInfo(...)              │
│  • registrarFuncion(...)               │
│                                        │
│ Validación:                            │
│  • validarOperacionAritmetica(...)     │
│  • validarComparacion(...)             │
│  • tiposCompatibles(...)               │
│                                        │
│ Impresión:                             │
│  • imprimirTablaSimbolos()             │
│                                        │
│ Contadores:                            │
│  • erroresSem, erroresSint             │
│  • tablaDeSimbolos (Stack)             │
│  • todosLosSimbolos (List)             │
└────────────────────────────────────────┘
```

### 3. AnalizadorSintacticoJava (Orquestador)
```
┌──────────────────────────────────────────┐
│   AnalizadorSintacticoJava               │
├──────────────────────────────────────────┤
│                                          │
│ main(String[] args)                      │
│  ├─ Reader lector = ...                 │
│  ├─ LexicoCPP scanner = new ...         │
│  ├─ Sintactico parser = new ...         │
│  │                                       │
│  ├─ ENLACE:                             │
│  │  scanner.helper = parser.helper   ⭐ │
│  │                                       │
│  ├─ parser.parse()                      │
│  ├─ parser.helper                       │
│  │  .imprimirTablaSimbolos()            │
│  │                                       │
│  └─ Mostrar resultados                  │
│                                          │
└──────────────────────────────────────────┘
```

---

## 🔗 Secuencia de Integración

```
Tiempo  │ Componente   │ Acción
────────┼──────────────┼─────────────────────────────────────
   1    │ Main         │ Crea LexicoCPP(reader)
        │              │ helper = null
────────┼──────────────┼─────────────────────────────────────
   2    │ Main         │ Crea Sintactico(scanner)
        │              │ Inicializa ParserHelper interno
────────┼──────────────┼─────────────────────────────────────
   3    │ Main         │ ENLACE: scanner.helper = 
        │              │         parser.helper  ⭐ CRÍTICO
────────┼──────────────┼─────────────────────────────────────
   4    │ Main         │ Llama parser.parse()
────────┼──────────────┼─────────────────────────────────────
   5    │ LexicoCPP    │ next_token() lee entrada
────────┼──────────────┼─────────────────────────────────────
   6    │ LexicoCPP    │ Si error léxico detectado:
        │              │ helper.reportLexicalError(...)
────────┼──────────────┼─────────────────────────────────────
   7    │ ParserHelper │ Imprime: "ERROR LEXICO: ..."
        │              │ (Formato consistente)
────────┼──────────────┼─────────────────────────────────────
   8    │ Sintactico   │ Procesa tokens y símbolos
────────┼──────────────┼─────────────────────────────────────
   9    │ ParserHelper │ Imprime tabla de símbolos
────────┼──────────────┼─────────────────────────────────────
   10   │ Main         │ Muestra resultados finales
────────┴──────────────┴─────────────────────────────────────
```

---

## 🎯 Puntos de Integración

### Punto 1: Inyección del Helper en LexicoCPP

**Código en LexicoCPP.flex:**
```jflex
%{
    public ParserHelper helper;  // ← Inyectable
    
    public LexicoCPP(java.io.Reader input, ParserHelper helper) {
        this(input);
        this.helper = helper;     // ← Se recibe aquí
    }
%}
```

### Punto 2: Llamada desde Reglas de Error

**Código en reglas léxicas:**
```jflex
[0-9]+[a-zA-Z_][a-zA-Z0-9_]* {
    if (helper != null) {
        helper.reportLexicalError(  // ← Se invoca aquí
            "identificador debe iniciar con letra o guion bajo",
            yytext(), 
            (yyline+1), 
            (yycolumn+1)
        );
    }
    return simbolo(sym.ERROR, yytext());
}
```

### Punto 3: Enlace Dinámico en Main

**Código en AnalizadorSintacticoJava:**
```java
LexicoCPP scanner = new LexicoCPP(lector);
Sintactico parser = new Sintactico(scanner);
scanner.helper = parser.helper;  // ← Se enlaza aquí
```

### Punto 4: Método de Reportes en ParserHelper

**Código en ParserHelper:**
```java
public void reportLexicalError(String msg, String token, 
                              int linea, int columna) {
    String m = "ERROR LEXICO: " + msg;
    if (token != null && !token.isEmpty()) 
        m += " '" + token + "'";
    if (linea > 0 && columna > 0) 
        m += " en línea " + linea + ", columna " + columna;
    System.err.println(m + ".");  // ← Salida centralizada
}
```

---

## 📈 Escalabilidad

```
Futuro: Agregar Nuevas Funcionalidades

┌─────────────────────────────────────────────┐
│     Contador de Errores Léxicos             │
│  private int erroresLex = 0;                │
│  erroresLex++ en reportLexicalError()       │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│  Diferentes Niveles de Severidad            │
│  - ERROR                                    │
│  - WARNING                                  │
│  - INFO                                     │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│  Logging a Archivo                          │
│  FileWriter para guardar errores            │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│  Recuperación Automática de Errores         │
│  Skip tokens hasta encontrar sincronización │
└─────────────────────────────────────────────┘
```

---

## ✅ Verificación de Integración

```
✓ Helper inyectable en LexicoCPP
✓ Reglas de error actualizado
✓ Enlace dinámico en main
✓ Método centralizado en ParserHelper
✓ Formato consistente de mensajes
✓ Fallback a System.err si helper es null
✓ Sin System.out.println en lexer
✓ Pruebas funcionales exitosas
```

---

## 🎓 Conclusión Visual

```
ANTES:
  Lexer ──► System.out.println(...) ─────┐
  Parser ─► System.err.println(...) ──────┼─► Salida Confusa
  Semántico► System.err.println(...) ────┘

DESPUÉS:
  Lexer ──┐
  Parser ─┼─► ParserHelper.reportXXX() ─► Salida Centralizada
  Semántico┘                              y Consistente
```

**Beneficio: Arquitectura más limpia, mantenible y escalable.** ✨
