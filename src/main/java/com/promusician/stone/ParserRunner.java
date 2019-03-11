package com.promusician.stone;

import com.promusician.stone.Exception.ParseException;
import com.promusician.stone.ast.ASTree;
import com.promusician.stone.token.Token;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;

public class ParserRunner {
    public static void main(String[] args) throws ParseException, FileNotFoundException {
        Lexer lexer=new Lexer(new FileReader(new File("src/main/resources/data/lex.stone")));
        BasicParser bp=new BasicParser();
        while (lexer.peek(0)!= Token.EOF){
            ASTree ast=bp.parse(lexer);
            System.out.println("=> "+ast.toString());
        }

    }
}
