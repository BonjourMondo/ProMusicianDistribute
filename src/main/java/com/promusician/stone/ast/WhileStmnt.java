package com.promusician.stone.ast;

import com.promusician.stone.Exception.StoneExcetion;
import com.promusician.stone.env.Environment;

import java.util.ArrayList;
import java.util.List;

public class WhileStmnt extends ASTList {

    public WhileStmnt(List<ASTree> lis) {
        super(lis);
    }

    public ASTree condition() {
        return child(0);
    }

    public ASTree body() {
        return child(1);
    }

    public String toString() {
        return "(while " + condition() + " " + body() + ")";
    }

    @Override
    public Object eval(Environment env, ArrayList arrayList) {
//        arrayList.add("while");
        Object result = 0;
        int times=1;
        while (checkCondition(env,arrayList)) {
            times++;
            if (times>=RhyStmnt.MAX_LOOP)
                arrayList.add("loops");
//            System.out.println(body().toString());
            result = body().eval(env,arrayList);
        }
        //后期需要修改循环次数
        return result;
    }

    private boolean checkCondition(Environment env,ArrayList arrayList) {
        Object conditon=condition().eval(env,arrayList);
        boolean con;
        if (conditon instanceof Boolean) {
            con = ((Boolean) conditon).booleanValue();
        } else if (conditon instanceof Integer) {
            int intval = ((Integer) conditon).intValue();
            con = intval != 0 ? true : false;//非0为真
        } else {
            throw new StoneExcetion("无法判断while 语句中的条件的正确性 ", this);
        }
        return con;
    }
}
