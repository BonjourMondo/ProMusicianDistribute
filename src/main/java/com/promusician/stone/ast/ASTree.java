package com.promusician.stone.ast;

import com.promusician.stone.env.Environment;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * 所有ast节点的父类，ASTLeaf和ASTTree是它的直接子类
 */
public abstract class ASTree implements Iterable<ASTree>{
    public abstract ASTree child(int i);//返回第i个子节点
    public abstract int numChildren();//返回子节点的个数（叶子节点返回0）

    /**
     * 在这个Iterator能够用于识别乐器类，并且存储于二维数组中（或一维字符串中）
     * @return
     */
    public abstract Iterator<ASTree> children();//（子节点iterator）用于遍历子节点
    public abstract String location();//返回AST节点在程序内所处位置的字符串
    public Iterator<ASTree> iterator(){//适配器，把ASTree类转为Iterable类型
        return children();
    }
    public abstract Object eval(Environment env,ArrayList arrayList);
    public abstract String toString(ArrayList<String> strings);
    public abstract String toString();
}
