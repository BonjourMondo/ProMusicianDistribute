package com.promusician.stone.Exception;

import com.promusician.stone.token.Token;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class ParseException extends RuntimeException {
    public static Logger logger= LoggerFactory.getLogger(ParseException.class);
    private static final long serialVersionUID = 8076082103334818137L;

    public ParseException(String msg, Token t){
        super("in line "+location(t)+" has a syntax error "+msg);
        logger.debug("in line "+location(t)+" has a syntax error "+msg);
    }

    private static String location(Token t) {
        if (t==Token.EOF){
            return "last line";
        }
        return "in line"+t.getLineNumber()+", "+t.getText();
    }

    public ParseException(Token t){
        this("",t);
    }

    public ParseException(IOException e){
        super(e);
    }
    public ParseException(String msg){
        super(msg);
    }
}
