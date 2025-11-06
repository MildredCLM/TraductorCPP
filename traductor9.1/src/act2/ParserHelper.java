package act2;

import java_cup.runtime.Symbol;
import java.util.HashMap;
import java.util.Stack;

/**
 * Clase auxiliar para el análisis semántico.
 * VERSIÓN CORREGIDA: Métodos usan int linea, int columna en lugar de Symbol
 */
public class ParserHelper {
    
    // === CONSTANTES DE TIPOS ===
    public static final String T_INT = "int";
    public static final String T_FLOAT = "float";
    public static final String T_CHAR = "char";
    public static final String T_STRING = "string";
    public static final String T_BOOL = "bool";
    public static final String T_VOID = "void";
    public static final String T_ERROR = "error_tipo";

    // === CLASE PARA RESULTADOS DE EXPRESIONES ===
    public static class ExprResult {
        public String tipo;
        public Object valor;
        public ExprResult(String tipo, Object valor) {
            this.tipo = tipo;
            this.valor = valor;
        }
    }

    // === CLASE PARA INFORMACIÓN DE SÍMBOLOS ===
    public static class SymbolInfo {
        public String tipo, alcance;
        public Object valor;
        public int linea, columna;

        public SymbolInfo(String tipo, String alcance, int linea, int columna, Object valor) {
            this.tipo = tipo;
            this.alcance = alcance;
            this.linea = linea;
            this.columna = columna;
            this.valor = valor;
        }
    }

    // === VARIABLES DE INSTANCIA ===
    public Stack<HashMap<String, SymbolInfo>> tablaDeSimbolos;
    public String alcanceActual = "global";
    public String tipoActualDecl = null;
    public String tipoFuncionActual = null;
    public int erroresSem = 0;
    public int erroresSint = 0;

    // === CONSTRUCTOR ===
    public ParserHelper() {
        tablaDeSimbolos = new Stack<>();
        iniciarAmbito();
    }

    // === GESTIÓN DE ÁMBITOS ===
    public void iniciarAmbito() {
        if (tablaDeSimbolos == null) {
            tablaDeSimbolos = new Stack<>();
        }
        tablaDeSimbolos.push(new HashMap<>());
    }

    public void finalizarAmbito() {
        if (!tablaDeSimbolos.isEmpty()) {
            tablaDeSimbolos.pop();
        }
    }

    // === GESTIÓN DE SÍMBOLOS ===
    /**
     * Inserta un símbolo en la tabla
     * @param id Identificador de la variable
     * @param tipo Tipo de dato (T_INT, T_FLOAT, etc.)
     * @param linea Número de línea (1-based)
     * @param columna Número de columna (1-based)
     * @param valor El valor inicial (ej. 10, "hola", true)
     */
    public void insertarSimbolo(String id, String tipo, int linea, int columna, Object valor) {
    SymbolInfo info = new SymbolInfo(tipo, alcanceActual, linea, columna, valor);
    if (tablaDeSimbolos.peek().containsKey(id)) {
        reportSemanticError(
            "Identificador '" + id + "' ya declarado en este ámbito",
            linea, columna
        );
    } else {
        tablaDeSimbolos.peek().put(id, info);
    }
}

    public SymbolInfo buscarSimboloInfo(String id) {
        if (tablaDeSimbolos == null) return null;
        
        for (int i = tablaDeSimbolos.size() - 1; i >= 0; i--) {
            HashMap<String, SymbolInfo> amb = tablaDeSimbolos.get(i);
            if (amb.containsKey(id)) {
                return amb.get(id);
            }
        }
        return null;
    }

    public String tipoDe(String id) {
        SymbolInfo info = buscarSimboloInfo(id);
        return (info == null) ? null : info.tipo;
    }

    // === VALIDACIÓN DE TIPOS ===
    public boolean esNumerico(String tipo) {
        return tipo != null && (tipo.equals(T_INT) || tipo.equals(T_FLOAT));
    }

    public boolean esBooleano(String tipo) {
        return tipo != null && tipo.equals(T_BOOL);
    }

    public boolean tiposCompatibles(String destino, String fuente) {
        if (destino == null || fuente == null ||
            destino.equals(T_ERROR) || fuente.equals(T_ERROR)) {
            return false;
        }

        // Mismo tipo
        if (destino.equals(fuente)) return true;

        // Promoción implícita: int a float
        if (destino.equals(T_FLOAT) && fuente.equals(T_INT)) return true;

        return false;
    }

    // Determina el tipo resultante de una operación aritmética
    public String tipoResultanteAritmetico(String tipo1, String tipo2) {
        if (tipo1.equals(T_FLOAT) || tipo2.equals(T_FLOAT)) return T_FLOAT;
        if (tipo1.equals(T_INT) && tipo2.equals(T_INT)) return T_INT;
        return T_ERROR;
    }

    // === VALIDACIÓN DE OPERACIONES ===
    /**
     * Valida una operación aritmética (+, -, *, /, %)
     * @param tipo1 Tipo del operando izquierdo
     * @param tipo2 Tipo del operando derecho
     * @param operador Operador (+, -, *, etc.)
     * @param linea Línea del operador
     * @param columna Columna del operador
     * @return Tipo resultante o T_ERROR
     */
    public String validarOperacionAritmetica(String tipo1, String tipo2, String operador, int linea, int columna) {
        // Ignorar si algún operando ya es error
        if (tipo1.equals(T_ERROR) || tipo2.equals(T_ERROR)) return T_ERROR;

        if (esNumerico(tipo1) && esNumerico(tipo2)) {
            return tipoResultanteAritmetico(tipo1, tipo2);
        } else {
            reportSemanticError(
                "Operador '" + operador + "' no aplicable a tipos '" + tipo1 + "' y '" + tipo2 + "'",
                linea, columna
            );
            return T_ERROR;
        }
    }

    /**
     * Valida una operación lógica (&&, ||)
     * @param tipo1 Tipo del operando izquierdo
     * @param tipo2 Tipo del operando derecho
     * @param operador Operador (&&, ||)
     * @param linea Línea del operador
     * @param columna Columna del operador
     * @return T_BOOL o T_ERROR
     */
    public String validarOperacionLogica(String tipo1, String tipo2, String operador, int linea, int columna) {
        if (tipo1.equals(T_ERROR) || tipo2.equals(T_ERROR)) return T_ERROR;

        if (esBooleano(tipo1) && esBooleano(tipo2)) {
            return T_BOOL;
        } else {
            reportSemanticError(
                "Operador '" + operador + "' solo aplicable a tipos booleanos, no a '" + tipo1 + "' y '" + tipo2 + "'",
                linea, columna
            );
            return T_ERROR;
        }
    }

    /**
     * Valida una operación de comparación (==, !=, <, >, <=, >=)
     * @param tipo1 Tipo del operando izquierdo
     * @param tipo2 Tipo del operando derecho
     * @param operador Operador (==, !=, etc.)
     * @param linea Línea del operador
     * @param columna Columna del operador
     * @return T_BOOL o T_ERROR
     */
    public String validarComparacion(String tipo1, String tipo2, String operador, int linea, int columna) {
        if (tipo1.equals(T_ERROR) || tipo2.equals(T_ERROR)) return T_ERROR;

        // Comparación numérica
        if (esNumerico(tipo1) && esNumerico(tipo2)) {
            return T_BOOL;
        }

        // Igualdad/desigualdad permite mismo tipo
        if ((operador.equals("==") || operador.equals("!=")) && tipo1.equals(tipo2)) {
            return T_BOOL;
        }

        reportSemanticError(
            "Operador '" + operador + "' no aplicable a tipos '" + tipo1 + "' y '" + tipo2 + "'",
            linea, columna
        );
        return T_ERROR;
    }

    // === MANEJO DE ERRORES ===
    /**
     * Reporta un error semántico
     * @param msg Mensaje de error
     * @param linea Número de línea (1-based)
     * @param columna Número de columna (1-based)
     */
    public void reportSemanticError(String msg, int linea, int columna) {
        erroresSem++;
        if (linea > 0 && columna > 0) {
            System.err.println("ERROR SEMÁNTICO: " + msg +
                             " en línea " + linea +
                             ", columna " + columna + ".");
        } else {
            System.err.println("ERROR SEMÁNTICO: " + msg + ".");
        }
    }

    /**
     * Reporta un error sintáctico
     * Mantiene Symbol para compatibilidad con CUP
     * @param msg Mensaje de error
     * @param tok Token donde ocurrió el error
     */
    public void reportSyntaxError(String msg, Symbol tok) {
        erroresSint++;
        String m = "ERROR SINTÁCTICO: " + msg;
        if (tok != null && tok.value != null) m += " '" + tok.value + "'";
        if (tok != null) m += " en línea " + (tok.left + 1) + ", columna " + (tok.right + 1);
        System.err.println(m + ".");
    }
    
    /**
     * Imprime la tabla de símbolos (útil para debugging)
     */
    public void imprimirTablaSimbolos() {
        System.out.println("\n=== TABLA DE SÍMBOLOS ===");
        int nivel = 0;
        for (HashMap<String, SymbolInfo> ambito : tablaDeSimbolos) {
            System.out.println("Ámbito nivel " + nivel + ":");
            for (String key : ambito.keySet()) {
                SymbolInfo info = ambito.get(key);
                System.out.println("  " + key + " -> Tipo: " + info.tipo + 
                                 ", Alcance: " + info.alcance + 
                                 ", Línea: " + info.linea + 
                                 ", Columna: " + info.columna +
                                 ", Valor: " + info.valor);
                                // ", Valor: " + (info.valor != null ? info.valor.toString() : "null"));
            }
            nivel++;
        }
    }
}
