package com.promusician.stone;


import com.promusician.stone.token.Token;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;

public class LexerRunner {
    public static void main(String[] args) throws FileNotFoundException {
        File code = new File("src/main/resources/data/lex.stone");
        Lexer lexer;

        lexer = new Lexer(new FileReader(code));

        for (Token t; (t = lexer.read()) != Token.EOF; ) {
            System.out.println(t.getLineNumber()+"=> " + t.getText()/*+" "+t.isIdentifier()+" "+t.isNumber()+" "+t.isString()*/);
        }
    }
}
