package com.promusician.stone.Exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Author: LeesangHyuk
 * Date: 2018/12/27 14:52
 * Description:
 */
public class DeadLoopException extends RuntimeException {
    private static final long serialVersionUID = -828282886645672626L;
    public static Logger logger= LoggerFactory.getLogger(DeadLoopException.class);

    public DeadLoopException(String msg){
        super("an undying loop，error code："+msg);
    }
    public DeadLoopException(){
        super("a dead loop, considered as undying loop");
    }
}
