package com.promusician.stone.Exception;

import com.promusician.stone.ast.ASTree;

public class StoneExcetion extends RuntimeException{
    private static final long serialVersionUID = 1084085301778563591L;

    public StoneExcetion(String s) {
        super(s);
    }
    public StoneExcetion(String msg,ASTree t){
        super(msg+" "+t.location());
    }
}
