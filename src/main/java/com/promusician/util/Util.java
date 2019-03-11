package com.promusician.util;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Author: LeesangHyuk
 * Date: 2018/12/19 15:58
 * Description:
 */
public class Util {

    //打log用
    private final static Logger logger = LoggerFactory.getLogger(Util.class);
    /**
     * 通过反射的方式遍历对象的属性和属性值，方便调试
     *
     * @param o 要遍历的对象
     * @throws Exception
     */
    public static void reflect(Object o) throws Exception {
        Class cls = o.getClass();
        Field[] fields = cls.getDeclaredFields();
        for (int i = 0; i < fields.length; i++) {
            Field f = fields[i];
            f.setAccessible(true);
            logger.info(f.getName() + " -> " + f.get(o));
        }
    }

    public static byte[] readInput(InputStream in) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int len = 0;
        byte[] buffer = new byte[1024];
        while ((len = in.read(buffer)) > 0) {
            out.write(buffer, 0, len);
        }
        out.close();
        in.close();
        return out.toByteArray();
    }

    public static String inputStreamToString(InputStream is) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        int i;
        while ((i = is.read()) != -1) {
            baos.write(i);
        }
        return baos.toString();
    }


    public static InputStream getStringStream(String sInputString) {
        ByteArrayInputStream tInputStringStream = null;
        if (sInputString != null && !sInputString.trim().equals("")) {
            tInputStringStream = new ByteArrayInputStream(sInputString.getBytes());
        }
        return tInputStringStream;
    }



    public static String getStringFromMap(Map<String, Object> map, String key, String defaultValue) {
        if (key == "" || key == null) {
            return defaultValue;
        }
        String result = (String) map.get(key);
        if (result == null) {
            return defaultValue;
        } else {
            return result;
        }
    }

    public static int getIntFromMap(Map<String, Object> map, String key) {
        if (key == "" || key == null) {
            return 0;
        }
        if (map.get(key) == null) {
            return 0;
        }
        return Integer.parseInt((String) map.get(key));
    }

    public static void returnJson(HttpServletResponse response, String result) {
        returnResult(response,result,"application/json;charset=UTF-8");
    }
    public static void returnHtml(HttpServletResponse response, String result) {
        returnResult(response,result,"text/html;charset=UTF-8");
    }
    public static void returnXML(HttpServletResponse response,String result){
        returnResult(response,result,"text/xml;charset=UTF-8");
    }
    public static void returnResult(HttpServletResponse response, String result,String contentType) {
        response.setContentType(contentType);
        try {
            response.getWriter().write(result);//直接将完整的表单html输出到页面
            response.getWriter().flush();
            response.getWriter().close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    /**
     * 读取请求体xml格式的信息
     *
     * @param request
     * @return
     */
    public static String getXMLStrFromRequest(HttpServletRequest request) {
        InputStream inStream = null;
        String result = null;
        try {
            inStream = request.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        try {
            while ((len = inStream.read(buffer)) != -1) {
                outSteam.write(buffer, 0, len);
            }
            outSteam.close();
            inStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        /** 获取微信调用notify_url的返回XML信息 */
        try {
            result = new String(outSteam.toByteArray(), "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return result;
    }

    /***
     * map转换成对象
     */
    public static Object mapToObject(Map<String, Object> map, Class<?> beanClass)
            throws Exception {
        if (map == null)
            return null;

        Object obj = beanClass.newInstance();

        BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
        PropertyDescriptor[] propertyDescriptors = beanInfo
                .getPropertyDescriptors();
        for (PropertyDescriptor property : propertyDescriptors) {
            Method setter = property.getWriteMethod();
            if (setter != null) {
                setter.invoke(obj, map.get(property.getName()));
            }
        }

        return obj;
    }
    /***
     * mapList转换成对象List
     */
    public static List<Object> mapListToObjectList(
            List<Map<String, Object>> mapList, Class<?> beanClass)
            throws Exception {
        if (mapList == null)
            return null;

        List<Object> objList = new ArrayList<Object>();
        for (Map<String, Object> map : mapList) {
            Object obj = beanClass.newInstance();
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo
                    .getPropertyDescriptors();
            for (PropertyDescriptor property : propertyDescriptors) {
                Method setter = property.getWriteMethod();
                if (setter != null) {
                    setter.invoke(obj, map.get(property.getName()));
                }
            }
            objList.add(obj);
        }

        return objList;
    }
    /***
     *对象 转换成 map
     */
    public static Map<String, Object> objectToMap(Object obj) throws Exception {
        if (obj == null)
            return null;

        Map<String, Object> map = new HashMap<String, Object>();

        BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
        PropertyDescriptor[] propertyDescriptors = beanInfo
                .getPropertyDescriptors();
        for (PropertyDescriptor property : propertyDescriptors) {
            String key = property.getName();
            if (key.compareToIgnoreCase("class") == 0) {
                continue;
            }
            Method getter = property.getReadMethod();
            Object value = getter != null ? getter.invoke(obj) : null;
            map.put(key, value);
        }

        return map;
    }


    public static void saveFile(String content,String path) {
//        logger.debug(String.valueOf(Util.class.getResource("/")));
//        logger.debug(System.getProperty("user.dir"));
        FileWriter fwriter = null;
        try {
            fwriter = new FileWriter(System.getProperty("user.dir")+path);
            fwriter.write(content);
        } catch (IOException ex) {
            ex.printStackTrace();
        } finally {
            try {
                fwriter.flush();
                fwriter.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }

    }

}
