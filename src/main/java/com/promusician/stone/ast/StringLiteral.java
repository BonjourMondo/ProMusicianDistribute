package com.promusician.stone.ast;

import com.promusician.stone.env.Environment;
import com.promusician.stone.token.Token;

import java.util.ArrayList;

public class StringLiteral extends ASTLeaf {
    public StringLiteral(Token t) {
        super(t);
    }

    public String value() {
        return token().getText();
    }

    @Override
    public Object eval(Environment env,ArrayList arrayList) {
        return value();
    }
}
