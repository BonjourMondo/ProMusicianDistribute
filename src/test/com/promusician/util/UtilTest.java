package com.promusician.util;

import org.junit.Test;

import java.io.File;

import static org.junit.Assert.*;

public class UtilTest {

    @Test
    public void saveFile() {
//        String virtPath = request.getServletPath();//虚拟路径
//    　　String realPath = request.getRealPath(virtPath);//物理路径
//        String path = getServletContext().getRealPath("/");
        System.out.println(Thread.currentThread().getContextClassLoader().getResource(""));
        System.out.println(UtilTest.class.getClassLoader().getResource(""));
        System.out.println(ClassLoader.getSystemResource(""));
        System.out.println(UtilTest.class.getResource(""));
        System.out.println(UtilTest.class.getResource("/")); //Class文件所在路径 
        System.out.println(new File("/").getAbsolutePath());//       

        System.out.println(System.getProperty("user.dir"));//   

    }
}