package com.promusician.stone.ast;

import com.promusician.stone.Exception.StoneExcetion;
import com.promusician.stone.env.Environment;
import com.promusician.stone.token.Token;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * astleaf是叶节点的类
 */
public class ASTLeaf extends ASTree {
    private static ArrayList<ASTree> empty=new ArrayList<>();
    private Token token;
    public ASTLeaf(Token t){
        token=t;
    }

    @Override
    public ASTree child(int i) {
        throw new IndexOutOfBoundsException();
    }

    @Override
    public int numChildren() {
        return 0;
    }

    @Override
    public Iterator<ASTree> children() {
        return empty.iterator();
    }

    @Override
    public String location() {
        return "第"+token.getLineNumber()+"行";
    }


    public Token token(){return token;}

    @Override
    public String toString(ArrayList<String> strings) {
        return token.getText();
    }
    @Override
    public String toString() {
        return token.getText();
    }
    @Override
    public Object eval(Environment env,ArrayList arrayList) {
        throw  new StoneExcetion("无法执行 eval "+toString(),this);
    }
}
