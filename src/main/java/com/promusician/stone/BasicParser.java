package com.promusician.stone;

import com.promusician.stone.Parser.Operators;
import com.promusician.stone.ast.*;
import com.promusician.stone.token.Token;

import java.util.HashSet;

import static com.promusician.stone.Parser.rule;

public class BasicParser {
     /*
    primary: "("expr")"|NUMBER|IDENTIFIER|STRING
    factor:"-"primary|primary
    expr:factor{OP factor}
    block:"{"[statement]{(";"|EOL)[statement]}"}"
    simple:expr
    statement:"if" expr block["else" block]
	    |"while" expr block
	    |simple
	    |"rhy" problock
    problock:"{"[music]{(";"|EOL)music}"}"
    music:"sn"|"fl"|"hi"|"bi"|"sm"|"ki"|"cr"|"hop"
    program:[statement](";"|EOL)
     */

    /*
     *首先定义了大量Parser类型的字段，他们是将代码的BNF规则转换为java语言的结果。
     */

    protected HashSet<String> reserved=new HashSet<>();
    Operators operators=new Operators();
    Parser expr0=rule();

    //  primary: "("expr")"|NUMBER|IDENTIFIER|STRING
    Parser primary=rule(PrimaryExpr.class)
            .or(rule().sep("(").ast(expr0).sep(")"),
                    rule().number(NumberLiteral.class),
                    rule().identifier(Name.class,reserved),
                    rule().string(StringLiteral.class));

    //factor:"-"primary|primary
    Parser factor =rule().or(rule(NegativeExpr.class).sep("-").ast(primary),primary);

    //expr:factor{OP factor}
    protected Parser expr=expr0.expression(BinaryExpr.class,factor,operators);

    Parser statement0=rule();

    // block:"{"[statement]{(";"|EOL)[statement]}"}"
    protected Parser block=rule(BlockStmnt.class)
            .sep("{").option(statement0)
            .repeat(rule().sep(";", Token.EOL).option(statement0))
            .sep("}");

    // simple:expr
    Parser simple=rule(PrimaryExpr.class).ast(expr);

    // music:"sn"|"fl"|"hi"|"bi"|"sm"|"ki"|"cr"
    Parser music=rule().or(
            rule().token("cr"),
            rule().token("sn"),
            rule().token("fl"),
            rule().token("hi"),
            rule().token("bi"),
            rule().token("sm"),
            rule().token("ki"),
            rule().token("hop"));


    // problock:"{"{[music](";"|EOL)}"}"
    //Parser problock=rule(ProblockStmnt.class).sep("{").repeat(rule().option(music).sep(";", Token.EOL)).sep("}");


    /*
    statement:"if" expr block["else" block]
	    |"while" expr block
        |simple
	    |"rhy" problock
     */
    protected Parser statement=statement0.or(
            rule(IfStmnt.class).sep("if").ast(expr).ast(block)
                    .option(rule().sep("else").ast(block)),
            rule(WhileStmnt.class).sep("while").ast(expr).ast(block),
            rule(RhyStmnt.class).sep("rhy")
                    .token("{").option(rule().token(Token.EOL))
                    .ast(music)
                    .repeat(rule().token(";", Token.EOL)
                    .option(music))
                    .option(rule().token(";",Token.EOL)).token("}"),
            simple
    );

    Parser program=rule().or(statement,rule(NULLStmnt.class)).sep(";",Token.EOL);


    public BasicParser(){
        reserved.add(";");
        reserved.add("}");
        reserved.add(Token.EOL);

        operators.add("=",1,Operators.RIGHT);
        operators.add("==",2,Operators.LEFT);
        operators.add(">",2,Operators.LEFT);
        operators.add("<",2,Operators.LEFT);
        operators.add("+",2,Operators.LEFT);
        operators.add("-",2,Operators.LEFT);
        operators.add("*",2,Operators.LEFT);
        operators.add("/",2,Operators.LEFT);
        operators.add("%",2,Operators.LEFT);
    }

    public ASTree parse(Lexer lexer){
        return program.parse(lexer);
    }
}
