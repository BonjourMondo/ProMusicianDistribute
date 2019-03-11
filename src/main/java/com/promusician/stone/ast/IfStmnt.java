package com.promusician.stone.ast;

import com.promusician.stone.Exception.StoneExcetion;
import com.promusician.stone.env.Environment;

import java.util.ArrayList;
import java.util.List;

public class IfStmnt extends ASTList {

    public IfStmnt(List<ASTree> lis) {
        super(lis);
    }

    public ASTree condition() {
        return child(0);
    }

    public ASTree thenBlock() {
        return child(1);
    }

    public ASTree elseBlock() {
        return numChildren() > 2 ? child(2) : null;
    }

    @Override
    public String toString() {
        return "if " + condition() + " " + thenBlock() + " else " + elseBlock() + ")";
    }

    @Override
    public Object eval(Environment env,ArrayList arrayList) {
        if (checkCondition(env,arrayList)) {
            return thenBlock().eval(env,arrayList);
        } else {
            ASTree els = elseBlock();
            if (els != null) {
                return els.eval(env,arrayList);
            }
            //没有else 语句 条件为 false
            //return null;
            return 0;
        }
    }

    private boolean checkCondition(Environment env,ArrayList arrayList) {
        Object conditon = condition().eval(env,arrayList);
        boolean con;
        if (conditon instanceof Boolean) {
            con = ((Boolean) conditon).booleanValue();
        } else if (conditon instanceof Integer) {
            int intval = ((Integer) conditon).intValue();
            con = intval != 0 ? true : false;//非0为真
        } else {
            throw new StoneExcetion("无法判断if 语句中的条件的正确性 ", this);
        }
        return con;
    }
}

