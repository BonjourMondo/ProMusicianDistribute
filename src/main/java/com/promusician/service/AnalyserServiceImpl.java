package com.promusician.service;

import com.promusician.stone.Lexer;
import com.promusician.stone.token.Token;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;

@Service("analyserservice")
public class AnalyserServiceImpl implements AnalyserService {
    ArrayList<String> instruments=new ArrayList<>(Arrays.asList("sn","fl","hi","bi","sm","ki","cr","hop"));

    @Override
    public String analyseInputText(String servletpath,String str) {
        Lexer lexer = new Lexer(str);
        String responseText="";

        int i=0;//表明行号
        int add_space=0;//表明加空格个数
        boolean toEnterLine=true;//表明后括号是否加空格，默认需要加

        boolean first_bpm=true;
        for (Token t; (t = lexer.read()) != Token.EOF; ) {
            if (t.getLineNumber() > i) {
                i = t.getLineNumber();
                responseText += "<span class=\"span_lineNo\" id=\"" + i + "\">" + i + "&nbsp;&nbsp;&nbsp;&nbsp;</span>";
                if (toEnterLine && t.getText().equalsIgnoreCase("}")) {
                    add_space--;
                }
                for (int j = add_space; j > 0; j--) {
                    responseText += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                }
            }
            if (t.getText().equalsIgnoreCase("\\n"))
                responseText += "<br/>";
            else if (t.getText().equalsIgnoreCase("bpm")) {
                if (first_bpm) {
                    first_bpm = false;
                    responseText += " <button class=\"bpm_btn bpm_btn-tooltip btn-sequencer\" id=\"sequencer-visible-btn\" aria-label=\"BPM\"><i class=\"fa fa-th\"></i></button>&nbsp;";
                }
                responseText += "<span class=\"span_KeyofBPM span_hover\">BPM&nbsp;</span>";
            } else if (t.getText().equalsIgnoreCase("rhy")) {
                responseText += "<span class=\"span_KeyofRHY span_hover\">RHY&nbsp;</span>";
                toEnterLine = false;//后括号不需要空格
            } else if (t.getText().equalsIgnoreCase("while"))
                responseText += "<span class=\"span_KeyofWhile span_hover\">WHILE&nbsp;</span>";
            else if (t.getText().equalsIgnoreCase("times"))
                responseText += "<span class=\"span_KeyofTimes span_hover\">TIMES&nbsp;</span>";
            else if (t.getText().equalsIgnoreCase("{")) {
                responseText += "<span class=\"span_KeyofSymbol\">{&nbsp;</span>";
                if (toEnterLine)
                    add_space++;
            } else if (t.getText().equalsIgnoreCase("}")) {
                if (!toEnterLine) {
                    toEnterLine = true;
                    responseText += "&nbsp;";
                }
                responseText += "<span class=\"span_KeyofSymbol\">}</span>";
            } else if (t.getText().equalsIgnoreCase("if"))
                responseText += "<span class=\"span_KeyofIFELSE span_hover\">IF&nbsp;</span>";
            else if (t.getText().equalsIgnoreCase("else"))
                responseText += "<span class=\"span_KeyofIFELSE span_hover\">ELSE&nbsp;</span>";
            else if (instruments.contains(t.getText().toLowerCase().trim())) {
                responseText += judgeInstrument(servletpath,t.getText());
            } else {
                responseText += t.getText();
            }
        }
        return  responseText;
    }

    public String judgeInstrument(String p,String s){
        //"sn"|"fl"|"hi"|"bi"|"sm"|"ki"|"cr"|"hop"
        switch (s){
            case "hop":
                return "<img class=\"\" style=\"height: 30px;width: 30px\" src=\""+p+"/assets/images/proimage/hop.png\" \">";
            case "cr":
                return "<img class=\"\" style=\"height: 30px;width: 30px\" src=\""+p+"/assets/images/proimage/crash.png\" onclick=\"img_crash();\">";/*<span class="span_KeyofIntrument">&nbsp;&nbsp;Crash-Cymbol</span>*/
            case "hi":
                return "<img class=\"\" style=\"height: 30px;width: 30px\" src=\""+p+"/assets/images/proimage/hi_hat.png\" onclick=\"img_hihat();\">";/*<span class="span_KeyofIntrument">&nbsp;&nbsp;Hi-Hat</span>*/
            case "ki":
                return "<img class=\"\" style=\"height: 30px;width: 30px\" src=\""+p+"/assets/images/proimage/kick.png\" onclick=\"img_kick();\">";/*<span class="span_KeyofIntrument">&nbsp;&nbsp;Kick-Drum</span>*/
            case "fl":
                return "<img class=\"\" style=\"height: 30px;width: 30px\" src=\""+p+"/assets/images/proimage/floor_tom.png\" onclick=\"img_floorTom();\">";/*<span class="span_KeyofIntrument">&nbsp;&nbsp;Floor-Tom</span>*/
            case "sn":
                return "<img class=\"\" style=\"height: 30px;width: 30px\" src=\""+p+"/assets/images/proimage/snare.png\" onclick=\"img_snare();\">";/*<span class="span_KeyofIntrument">&nbsp;&nbsp;Snare-Drum</span>*/
            case"sm":
                return "<img class=\"\" style=\"height: 30px;width: 30px\" src=\""+p+"/assets/images/proimage/right_tom.png\" onclick=\"img_rightTom();\">";/*<span class="span_KeyofIntrument">&nbsp;&nbsp;Small-Rack</span>*/
            case "bi":
                return "<img class=\"\" style=\"height: 30px;width: 30px\" src=\""+p+"/assets/images/proimage/left_tom.png\" onclick=\"img_leftTom();\">";/*<span class="span_KeyofIntrument">&nbsp;&nbsp;Big-Rack</span>*/
            default:
                return "";
        }
    }

}
