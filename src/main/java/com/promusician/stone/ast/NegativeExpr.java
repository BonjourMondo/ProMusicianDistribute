package com.promusician.stone.ast;

import com.promusician.stone.Exception.StoneExcetion;
import com.promusician.stone.env.Environment;

import java.util.ArrayList;
import java.util.List;

public class NegativeExpr extends ASTList {

    public NegativeExpr(List<ASTree> lis) {
        super(lis);
    }

    public  ASTree operand(){
        return child(0);
    }

    @Override
    public String toString() {
        return "-"+operand();
    }

    @Override
    public Object eval(Environment env,ArrayList arrayList) {
        Object v=operand().eval(env,arrayList);
        if (v instanceof Integer){
            return new Integer(-((Integer) v).intValue());
        }
        else
            throw new StoneExcetion("无法对此类型使用-号",this);
    }
}
