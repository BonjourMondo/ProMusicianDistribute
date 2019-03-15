package com.promusician.controller;

import com.alibaba.fastjson.JSON;
import com.promusician.model.Code;
import com.promusician.service.*;
import com.promusician.stone.InterpreterRunner;
import com.promusician.util.Util;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/textarea")
public class TextareaController {
    public static Logger logger=LoggerFactory.getLogger(TextareaController.class);

    @Autowired
    @Qualifier("analyserservice")
    private AnalyserService analyserService;

    @Autowired
    @Qualifier("commitservice")
    private CommitService commitService;

    @Autowired
    @Qualifier("checkandrunservice")
    private RunnerService runnerService;


    @RequestMapping(method = RequestMethod.POST,produces = "text/html;charset=UTF-8")
    public void getText(HttpServletResponse response,HttpServletRequest request,
                        @RequestParam(value = "str") String code) throws IOException {
        //request
        String[] strings=code.split("\n");
        String analyse_text="";//为了处理空格，否则会报错
        for (String s:strings) {
           analyse_text=analyse_text+s.trim()+"\n";
        }
        String analyseCode = analyserService.analyseInputText(request.getContextPath(),analyse_text);
//        logger.debug("处理结果为：{}", analyseCode);
        //传值为json
        Map<String,String> map=new HashMap<>();
        map.put("code",analyseCode);
        String objJSON= JSON.toJSONString(map);
        Util.returnJson(response,objJSON);
    }

    @RequestMapping(value = "/commit")
    public String getCommitText(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String title=request.getParameter("title");
        String description=request.getParameter("description");
        String code=request.getParameter("code");
        if (StringUtils.isEmpty(code)){
            logger.debug("code为空");
        }

//        logger.debug(analyse_text); 
//        logger.debug(request.getSession().getServletContext().getRealPath(request.getRequestURI()));
//        logger.debug(TextareaController.class.getResource("/"));
        Util.saveFile(code,"/res/"+title+".stone");
        commitService.CheckandCommit(request.getContextPath(),description,title);
        return "success_commit";
    }

    @RequestMapping(value = "/debug")
    public void debug(HttpServletRequest request,HttpServletResponse response) throws Exception {
        String s=request.getParameter("str");
        if (StringUtils.isEmpty(s)){
            throw new Exception("传值空异常");
        }
        Code code=runnerService.CheckAndRun(s);
        return_ajax(code,response);
    }


    /*
    ajax传值
     */
    @RequestMapping(value = "/start",method = RequestMethod.POST)
    public void getRunnerText(HttpServletRequest request,HttpServletResponse response) throws Exception {
        String s=request.getParameter("str");
        logger.debug("试运行代码中...length:{}",s.length());
        if (StringUtils.isEmpty(s)){
            throw new Exception("传值空异常");
        }

        Code code=runnerService.CheckAndRun(s);
        return_ajax(code,response);
    }


    public void return_ajax(Code code,HttpServletResponse response){
        //传值为json
        Map<String,String> map=new HashMap<>();
        map.put("code",code.getStrings().toString());
        if (StringUtils.isEmpty(code.getError_code())){
            map.put("error_code", InterpreterRunner.SUCCESS);
//            map.put("error_mesg",code.getError_msg());
        }else {
            map.put("error_code", code.getError_code());
            map.put("error_msg", code.getError_msg());
        }
        map.put("bpm",code.getBpm());
        String objJSON= JSON.toJSONString(map);
        logger.debug(objJSON);
        Util.returnJson(response,objJSON);
    }

}
