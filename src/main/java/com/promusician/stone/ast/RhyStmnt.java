package com.promusician.stone.ast;

import com.promusician.stone.Exception.DeadLoopException;
import com.promusician.stone.env.Environment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class RhyStmnt extends ASTList {
    public static Logger logger= LoggerFactory.getLogger(RhyStmnt.class);
    ArrayList<String> arrayList=new ArrayList<>(Arrays.asList("cr","sn","fl","hi","bi","sm", "ki","hop"));
    public static int loop_time=0;
    public static final int MAX_LOOP=1000;

    public RhyStmnt(List<ASTree> lis) {
        super(lis);
    }

    public int length(){
        int j=0;
        for (int i = 0; i < real_length(); i++) {
            if (child(i) instanceof ASTList) {
                for (int k = 0; k < ((ASTList) child(i)).children.size(); k++) {
                    if (arrayList.contains(child(i).child(k).toString())) {
//                        System.out.print(child(i).child(k).toString()+" ");
                        j++;
                    }
                }
//                j++;//有子节点的必然是某乐器
            }else {
                if (arrayList.contains(child(i).toString())) {
//                    System.out.print(child(i).toString()+" ");
                    j++;
                }
            }
        }
//        System.out.println("");
        return j;
    }


    public int real_length(){
        return children.size();
    }

    public void getIntrument(ArrayList<String> strings){
        String s="";
        for (int i = 0; i < real_length(); i++) {
            if (child(i) instanceof ASTList) {
                for (int k = 0; k < ((ASTList) child(i)).children.size(); k++) {
                    if (arrayList.contains(child(i).child(k).toString())) {
//                        System.out.print(child(i).child(k).toString()+" ");
                        s=s+child(i).child(k).toString()+"|";
                    }
                }
//                j++;//有子节点的必然是某乐器
            }else {
                if (arrayList.contains(child(i).toString())) {
                    s=s+child(i).toString()+"|";
//                    System.out.print(child(i).toString()+" ");
                }
            }
        }
//        System.out.println("");
        //所有可能的乐器组合
//       譬如[cr|hi|ki|, sn|sm|fl|bi|]
        strings.add(s);
//        logger.debug(s);
    }

    public String toString(ArrayList<String> strings) {
        getIntrument(strings);
        return "(ryh {"+real_length()+" "+length()+"} )";
    }

    public String toString() {
        return "(ryh {"+real_length()+" "+length()+"} )";
    }

    @Override
    public Object eval(Environment env,ArrayList arrayList) {
        getIntrument(arrayList);
        loop_time++;
        if (loop_time>=this.MAX_LOOP) {
            throw new DeadLoopException();
        }
        return 0;
    }
}
