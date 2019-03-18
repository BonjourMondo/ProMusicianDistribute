package com.promusician.controller;

import com.promusician.model.GalleryDTO;
import com.promusician.service.AnalyserService;
import com.promusician.service.GalleryService;
import com.promusician.util.Util;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.List;

@Controller
@RequestMapping(value={"/","/homepage"})
public class HomeController {
    public static Logger logger= LoggerFactory.getLogger(HomeController.class);

    @Autowired
    @Qualifier("analyserservice")
    private AnalyserService analyserService;

    @Autowired
    @Qualifier("galleryservice")
    private GalleryService galleryService;

    @RequestMapping(method = RequestMethod.GET)
    public String home(Model model){
        model.addAttribute("message","Bounjour Mondo!");
        return "index";
    }

    @RequestMapping("/musician")
    public String pro_musician(Model model) throws IOException {
        String path="data/lex.stone";
        //相对路径
        String text="";
        InputStream in = HomeController.class.getClassLoader().getResourceAsStream(path);
        text= Util.inputStreamToString(in);
        model.addAttribute("template_promusician",text.trim());
        logger.debug("成功载入lex.stone");
        return "pro_musician";
    }

    @RequestMapping("/drums")
    public String drums(Model model){
        return "pro_drums";
    }

    @RequestMapping("/programmer")
    public String pro_programmer(Model model){
        return "pro_programmer";
    }

    @RequestMapping("/gallery")
    public String gallery(Model model){
        List<GalleryDTO> galleryDTOList=galleryService.showGallery();
        model.addAttribute("gallery",galleryDTOList);
        return "gallery";
    }

    @RequestMapping("/visitor")
    public String visitor(HttpServletRequest request, Model model, @RequestParam(value = "path",defaultValue = "data/lex.stone") String path){
        //相对路径
        String text="";
        try {
            //fix file not found exception
            File file=new File(path);
            InputStream in=new FileInputStream(file);
//            InputStream in = HomeController.class.getClassLoader().getResourceAsStream(path);
//            logger.debug(in.toString());
            text= Util.inputStreamToString(in);
        }catch (Exception e){
            logger.debug("资源未准备好！");
            return "fail_commit";
        }

        model.addAttribute("template_promusician",text.trim());
        logger.debug("成功载入"+path);

        //直接分析
        String[] strings=text.split("\n");
        String analyse_text="";//为了处理空格，否则会报错
        for (String s:strings) {
            analyse_text=analyse_text+s.trim()+"\n";
        }
        String analyseCode = analyserService.analyseInputText(request.getContextPath(),analyse_text);
        model.addAttribute("analyseCode",analyseCode);
        return "pro_musician_for_gallery";
    }

    @RequestMapping("/test")
    public void test(ModelAndView modelAndView){
        modelAndView.setViewName("test");
    }
}
