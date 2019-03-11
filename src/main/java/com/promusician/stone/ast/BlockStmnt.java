package com.promusician.stone.ast;

import com.promusician.stone.env.Environment;

import java.util.ArrayList;
import java.util.List;

public class BlockStmnt extends ASTList {
    public BlockStmnt(List<ASTree> lis) {
        super(lis);
    }

    @Override
    public Object eval(Environment env,ArrayList arrayList) {
        Object result = 0;
        for (ASTree ast : this) {
            if (!(ast instanceof NULLStmnt)) {
                result = ast.eval(env,arrayList);
            }
        }
        return result;
    }
}
