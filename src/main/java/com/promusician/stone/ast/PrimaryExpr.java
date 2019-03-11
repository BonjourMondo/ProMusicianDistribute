package com.promusician.stone.ast;

import java.util.List;

public class PrimaryExpr extends ASTList {
    public PrimaryExpr(List<ASTree> lis) {
        super(lis);
    }

    //擦这是何等的卧槽 这个函数的作用就是避免只有一个还被包裹的情况
    public static ASTree create(List<ASTree> lis) {
        //如何只有一个 那么就直接返回这个 而不是包裹一层 如果不是则包裹
        return lis.size() == 1 ? lis.get(0) : new PrimaryExpr(lis);
    }

}
