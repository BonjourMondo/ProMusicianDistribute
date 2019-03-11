package com.promusician.stone.ast;

import com.promusician.stone.env.Environment;
import com.promusician.stone.token.NumToken;
import com.promusician.stone.token.Token;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;

public class NumberLiteral extends ASTLeaf {
    public NumberLiteral(Token t) {
        super(t);
    }

    public int value() {
        return ((NumToken) token()).getValue();
    }

    @Override
    public Object eval(Environment env,ArrayList arrayList) {
//        if (token().getText()=="bpm")
//            arrayList.add("bpm="+value());

        return value();
    }
}
