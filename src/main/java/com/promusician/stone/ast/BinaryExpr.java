package com.promusician.stone.ast;

import com.promusician.stone.Exception.StoneExcetion;
import com.promusician.stone.env.Environment;

import java.util.ArrayList;
import java.util.List;

public class BinaryExpr extends ASTList {

    public BinaryExpr(List<ASTree> lis) {
        super(lis);
    }

    public ASTree left() {
        return child(0);
    }

    public ASTree right() {
        return child(2);
    }

    public String operator() {
        return ((ASTLeaf) child(1)).token().getText();
    }

    //有两个操作数的表达式
    @Override
    public Object eval(Environment env,ArrayList arrayList) {
        String op = operator();
        if ("=".equals(op)) {
            //=
            Object right = right().eval(env,arrayList);

            return computeAssign(env, right);
        } else {
            Object left = left().eval(env,arrayList);
            Object right = right().eval(env,arrayList);
            return computeOP(left, right, op);

        }
    }

    //如果两边是数字 直接计算
    private Object computeOP(Object left, Object right, String op) {
        if (left instanceof Integer && right instanceof Integer) {
            return computeNumber((Integer) left, (Integer) right, op);
        } else if (op.equals("+")) {
            return String.valueOf(left) + String.valueOf(right);
        } else if (op.equals("==")) {
            if (left == null) {
                return right == null ? true : false;
            } else {
                return left.equals(right)?true:false;
            }
        } else {
            throw new StoneExcetion("无法应用 " + op, this);
        }


    }

    private Object computeNumber(Integer left, Integer right, String op) {
        int a = left.intValue();
        int b = right.intValue();
        switch (op) {
            case "+":
                return a + b;
            case "-":
                return a - b;
            case "*":
                return a * b;
            case "/":
                return a / b;
            case "%":
                return a % b;
            case "==":
                return a == b;
            case ">":
                return a > b;
            case "<":
                return a < b;
            default:
                throw new StoneExcetion("无法识别的符号 " + op, this);
        }
    }

    private Object computeAssign(Environment env, Object rvalue) {
        ASTree left = left();
        //如果左式是 PrimaryExpr 类似 a.b=2  左式 a.b
        if (left instanceof Name) {
            env.put(((Name) left).name(), rvalue);
            return rvalue;
        } else {
            throw new StoneExcetion("=号运用错误 ", this);
        }
    }
}
