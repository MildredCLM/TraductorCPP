package act2;

public class Token {
    public enum Type{
        //palabras reservadas
        INT, LONG, FLOAT, DOUBLE, CHAR, BOOL, VOID,STRING, IF, ELSE, SWITCH,FOR, WHILE, DO, BREAK, CONTINUE, RETURN, TRY, CATCH,
        //Lexicas
        ID, ENTERO, DECIMAL, BOOLEAN, CADENA, CARACTER

    }

    private final Type type;
    private final String value;
    private final int line;
    private final int column;

    public Token(Type type, String value,int line,int column){
        this.type = type;
        this.value = value;
        this.line = line;
        this.column = column; 
    }

    @Override
    public String toString() {
    return "Token{Type=" + type + ", value=" + value + ", line=" + line + ", column=" + column + "}";
}
}
