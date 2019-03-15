<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pro" uri="http://www.springframework.org/tags" %>
<%@page isELIgnored="false"%>
<!doctype html>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<html class="no-js" lang="en" >

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>ProMusician--Start here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- all css here -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/slicknav.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/swiper.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/zoomslider.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/typography.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/default-css.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/responsive.css">
    <!-- modernizr css -->
    <script src="<%=request.getContextPath()%>/assets/js/vendor/modernizr-2.8.3.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- all css here -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/slicknav.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/swiper.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/zoomslider.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/typography.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/default-css.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/responsive.css">

    <!--行号-->
    <script src="<%=request.getContextPath()%>/assets/js/myjs/protextarea.js"></script>
    <!--不可滚动-->
    <script src="<%=request.getContextPath()%>/assets/js/myjs/dont_move.js"></script>
    <!--text相关Js-->
    <script src="<%=request.getContextPath()%>/assets/js/myjs/show_get_text.js"></script>
    <!--alt表示tab键来-->
    <script src="<%=request.getContextPath()%>/assets/js/myjs/tap.js"></script>
    <!--左侧跳到指定位置-->
    <script src="<%=request.getContextPath()%>/assets/js/myjs/my_scrollbar.js"></script>
    <!--自定义的Css-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/procss/proCss.css">
    <!--打击乐器的js-->
    <%--<script src="<%=request.getContextPath()%>/assets/js/myjs/drumbeat.js"></script>--%>
    <!--弹窗的alert-->
    <script src="<%=request.getContextPath()%>/assets/js/myjs/alert.js"></script>
    <script>
        //    ajax传数据
        function getAndShow(code) {
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/textarea",
                data: {str:code},
                dataType: "json",
                success: function(data){
                    document.getElementById("scrollOne").innerHTML=data.code;
                },
                error:function(data){
                    //donothing
                }
            });
        }
    </script>
    <script>
        //        /textarea/start
        function CheckAndRun(){
//            alert("!!!");
            var v=document.getElementById("codeTextarea");
            var code=v.value;
            $.ajax({
                type: "POST",
                //ajax路径需要修改
                url: "<%=request.getContextPath()%>/textarea/start",
                data: {str:code},
                dataType: "json",
                success: function(data){
                    //调用乐器打击代码
//                    alert("s");
                    var instruments=data.code.split(",");
                    var bpm=60000/data.bpm;
                    if(data.error_code=="success"){
                        //成功场景
                        //处理字符串，并映射为Instrument
                        success_time=0;//每次调用必须归零
                        instru_success(instruments,bpm);
                    }else if (data.error_code=="loops"){
                        //循环场景
                        loops_time=0;
                        instr_loops(instruments,bpm);
                    }else if(data.error_code=="parser_error"){
//                      alert(data.error_msg);
                        showToast({
                            title:data.error_msg,
                            icon:'meh',
                            duration:3000,
                            mask:true,
                            success:function (res) {
                                console.warn(JSON.stringify(res))
                            }
                        });
//                        alert(data.error_msg);
                    }else if(data.error_code=="stone_error"){
                        showToast({
                            title:data.error_msg,
                            icon:'frown',
                            duration:3000,
                            mask:true,
                            success:function (res) {
                                console.warn(JSON.stringify(res))
                            }
                        });
                    }else{
                        showToast({
                            title:data.error_msg,
                            icon:'smile',
                            duration:3000,
                            mask:true,
                            success:function (res) {
                                console.warn(JSON.stringify(res))
                            }
                        });
                    }
                },
                error:function(data){
                    //donothing
                    showToast({
                        title:"后台发生处理错误",
                        icon:'meh',
                        duration:3000,
                        mask:true,
                        success:function (res) {
                            console.warn(JSON.stringify(res))
                        }
                    });
                }
            });
            return false;
        }

        var success_time=0;//success场景循环
        var success_continue=true;//success场景是否停止打击乐
        var loops_time=0;//loops场景循环
        var loops_continue=true;//loops场景是否停止打击乐
        function instr_loops(instruments,bpm) {
            var beat_instruments = instruments[loops_time].split("|");
            instru_sequence(beat_instruments,bpm);
            if(loops_time<instruments.length&&loops_continue){
                loops_time++;
                sleep(this,bpm);
                this.NextStep=function(){
                    instru_success(instruments,bpm);
                }
            }
            if(loops_time>1000)
                loops_time=0;
        }
        function instru_success(instruments,bpm) {
            var beat_instruments = instruments[success_time].split("|");
            instru_sequence(beat_instruments,bpm);
            if(success_time<instruments.length&&success_continue){
                success_time++;
                sleep(this,bpm);
                this.NextStep=function(){
                    instru_success(instruments,bpm);
                }
            }
        }
        function instru_sequence(beat_instruments,bpm) {
            for (var j = 0; j < beat_instruments.length; j++) {
                if(beat_instruments[j].indexOf("hop") != -1){
                    setInterval(function () {
                        //跳过该符号
                    },bpm);
                    break;
                }
                //  music:"sn"|"fl"|"hi"|"bi"|"sm"|"ki"|"cr"
                if (beat_instruments[j].indexOf("cr") != -1) {
                    document.getElementById("drums_page").contentWindow.crash();
                } else if (beat_instruments[j].indexOf("ki") != -1) {
                    document.getElementById("drums_page").contentWindow.kick();
                } else if (beat_instruments[j].indexOf("sm") != -1) {
                    document.getElementById("drums_page").contentWindow.rightTom();
                } else if (beat_instruments[j].indexOf("bi") != -1) {
                    document.getElementById("drums_page").contentWindow.leftTom();
                } else if (beat_instruments[j].indexOf("hi") != -1) {
                    document.getElementById("drums_page").contentWindow.hiHat();
                } else if (beat_instruments[j].indexOf("fl") != -1) {
                    document.getElementById("drums_page").contentWindow.floorTom();
                } else if (beat_instruments[j].indexOf("sn") != -1) {
                    document.getElementById("drums_page").contentWindow.snare();
                }
            }
        }

        function sleep(obj,iMinSecond){
            if (window.eventList==null) window.eventList=new Array();
            var ind=-1;
            for (var i=0;i<window.eventList.length;i++){
                if (window.eventList[i]==null) {
                    window.eventList[i]=obj;
                    ind=i;
                    break;
                }
            }

            if (ind==-1){
                ind=window.eventList.length;
                window.eventList[ind]=obj;
            }
            setTimeout("GoOn(" + ind + ")",iMinSecond);
        }

        function GoOn(ind){
            var obj=window.eventList[ind];
            window.eventList[ind]=null;
            if (obj.NextStep) obj.NextStep();
            else obj();
        }
    </script>

    <style type="text/css">
        /*text*/
        .box {
            width: 500px; height: 375px; border:3px solid #453cad; margin: 10px auto; padding: 0; overflow: hidden;
        }
        .box1 {
            padding: 20px;
            /*overflow: auto;*/
        }
        .textbox{
            border:3px solid #453cad;
            background-color:transparent;
            color: #ffcb2a;
            padding-left: 10px;
            /*margin-left: 10px;*/
            height: auto;
            resize:none;
            overflow-y: scroll;
            font-size: 15px ;
            line-height: 2;
        }
        .textbox::-webkit-scrollbar {
            width: 5px;
            height: 10px;
            background-color: #b5b1b1;
        }
        .textbox::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
            border-radius: 10px;
            background-color: black;

        }
        .textbox::-webkit-scrollbar-thumb {
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
            background-color: #b5b1b1;
        }

        .span_lineNo{
            font-size: 14px;
            letter-spacing: 0.09em;
            color: #ffcb2a;
        }
        .span_hover:hover{
            text-shadow:-1px 0 #fff938,
            0 1px #fff938,
            1px 0 #fff938,
            0 -1px #fff938;
        }
        .span_text_hover{
            text-shadow:-1px 0 #fff938,
            0 1px #fff938,
            1px 0 #fff938,
            0 -1px #fff938;
        }
        .span_KeyofWhile{
        }
        .span_KeyofRHY{
        }
        .span_KeyofBPM{
        }
        .span_KeyofTimes{
        }
        .span_KeyofSymbol{
        }
        .span_KeyofIFELSE{

        }
        .span_all{
            color: #ffcb2a;
        }

        .bpm_btn {
            font-size: 1.65em;
            font-weight: bold;
            line-height: 1;
            width: auto;
            padding: 0.5rem;
            vertical-align: middle;
            text-decoration: none;
            color: #89939B;
            border: 0;
            border-radius: 2px;
            background: #ffcb2a;
        }

        .bpm_btn:hover {
            color: #2d2e36;
            border-color: #2d2e36;
            outline: none;
        }

        .bpm_btn .fa {
            vertical-align: middle;
        }
    </style>
    <script>
        function Debug(){
//            alert("!!!");
            var v=document.getElementById("codeTextarea");
            var code=v.value;
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/textarea/debug",
                data: {str:code},
                dataType: "json",
                success: function(data){
                    //调用乐器打击代码
//                    alert("s");
                    if(data.error_code=="success"){
                        showToast({
                            title:"代码正确运行",
                            icon:'smile',
                            duration:3000,
                            mask:true,
                            success:function (res) {
                                console.warn(JSON.stringify(res))
                            }
                        });
                    }else if (data.error_code=="loops"){
                        showToast({
                            title:"代码正确运行,loops ∞",
                            icon:'smile',
                            duration:3000,
                            mask:true,
                            success:function (res) {
                                console.warn(JSON.stringify(res))
                            }
                        });
                    }else if(data.error_code=="parser_error"){
//                      alert(data.error_msg);
                        showToast({
                            title:data.error_msg,
                            icon:'meh',
                            duration:3000,
                            mask:true,
                            success:function (res) {
                                console.warn(JSON.stringify(res))
                            }
                        });
//                        alert(data.error_msg);
                    }else if(data.error_code=="stone_error"){
                        showToast({
                            title:data.error_msg,
                            icon:'frown',
                            duration:3000,
                            mask:true,
                            success:function (res) {
                                console.warn(JSON.stringify(res))
                            }
                        });
                    }else{
                        showToast({
                            title:data.error_msg,
                            icon:'smile',
                            duration:3000,
                            mask:true,
                            success:function (res) {
                                console.warn(JSON.stringify(res))
                            }
                        });
                    }
                },
                error:function(data){
                    //donothing
                    showToast({
                        title:"后台发生处理错误",
                        icon:'meh',
                        duration:3000,
                        mask:true,
                        success:function (res) {
                            console.warn(JSON.stringify(res))
                        }
                    });
                }
            });
            return false;
        }

        function Hints() {
            var v=document.getElementById("scrollOne");
            v.innerHTML="<span class=\"span_lineNo\" id=\"1\">1&nbsp;&nbsp;&nbsp;&nbsp;</span>bpm:Express rhythmic speed.&nbsp;&nbsp; <button class=\"bpm_btn bpm_btn-tooltip btn-sequencer\" id=\"sequencer-visible-btn\" aria-label=\"BPM\"><i class=\"fa fa-th\"></i></button>&nbsp;<span class=\"span_KeyofBPM span_text_hover\">BPM&nbsp;</span>;<br>\n" +
                "                            <span class=\"span_lineNo\" id=\"2\">2&nbsp;&nbsp;&nbsp;&nbsp;</span>times:Represents the number of hits.(you could never end it)&nbsp;&nbsp;<span class=\"span_KeyofTimes span_text_hover\">TIMES&nbsp;</span>;<br>\n" +
                "                            <span class=\"span_lineNo\" id=\"3\">3&nbsp;&nbsp;&nbsp;&nbsp;</span>if/elese,while:Same as java or other language can do&nbsp;&nbsp;<span class=\"span_KeyofIFELSE span_text_hover\">IF&nbsp;</span>;<span class=\"span_KeyofIFELSE span_text_hover\">ELSE&nbsp;</span>;<span class=\"span_KeyofWhile span_text_hover\">WHILE&nbsp;</span>;<br>\n" +
                "                            <span class=\"span_lineNo\" id=\"4\">4&nbsp;&nbsp;&nbsp;&nbsp;</span>rhy:Represent a beat.(short for rhythm)&nbsp;&nbsp;<span class=\"span_KeyofRHY span_text_hover\">RHY&nbsp;</span><br/>\n" +
                "                            <span class=\"span_lineNo\" id=\"5\">5&nbsp;&nbsp;&nbsp;&nbsp;</span>sn:<img class=\"\" style=\"height: 30px;width: 30px\" src=\"<%=request.getContextPath()%>/assets/images/proimage/snare.png\" onclick=\"img_snare();\">;&nbsp;fl:<img class=\"\" style=\"height: 30px;width: 30px\" src=\"<%=request.getContextPath()%>/assets/images/proimage/floor_tom.png\" onclick=\"img_floorTom();\">;&nbsp;hi:<img class=\"\" style=\"height: 30px;width: 30px\" src=\"<%=request.getContextPath()%>/assets/images/proimage/hi_hat.png\" onclick=\"img_hihat();\">;&nbsp;bi:<img class=\"\" style=\"height: 30px;width: 30px\" src=\"<%=request.getContextPath()%>/assets/images/proimage/left_tom.png\" onclick=\"img_leftTom();\">;&nbsp;sm:<img class=\"\" style=\"height: 30px;width: 30px\" src=\"<%=request.getContextPath()%>/assets/images/proimage/right_tom.png\" onclick=\"img_rightTom();\">;&nbsp;ki:<img class=\"\" style=\"height: 30px;width: 30px\" src=\"<%=request.getContextPath()%>/assets/images/proimage/kick.png\" onclick=\"img_kick();\">;&nbsp;cr:<img class=\"\" style=\"height: 30px;width: 30px\" src=\"<%=request.getContextPath()%>/assets/images/proimage/crash.png\" onclick=\"img_crash();\"><br>\n" +
                "                      <span class=\"span_lineNo\" id=\"6\">6&nbsp;&nbsp;&nbsp;&nbsp;</span>also you can use the word \"hop\" to skip a beat.&nbsp;&nbsp; the symbol just like<img class=\"\" style=\"height: 30px;width: 30px\" src=\"<%=request.getContextPath()%>/assets/images/proimage/hop.png\"><br/>";
        }
    </script>
</head>


<body>
<!--[if lt IE 8]>
<p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
<![endif]-->
<!-- preloader area start -->
<!---<div id="preloader">
	<div class="loader"></div>
</div>--->
<!-- prealoader area end -->
<!-- header area start -->
<header>
    <div class="header-area">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-3">
                    <div class="logo">
                        <a href="<pro:url value="/"/>">
                            <img src="<%=request.getContextPath()%>/assets/images/icon/logo.png" alt="logo">
                        </a>
                    </div>
                </div>
                <div class="col-lg-9 d-none d-lg-block">
                    <div class="main-menu">
                        <nav id="nav_mobile_menu">
                            <ul id="navigation">
                                <li>
                                    <a   href="<pro:url value="/"/>">Home</a>
                                </li>
                                <li>
                                    <a   href="<pro:url value="/programmer"/>">Programmer</a>
                                </li>
                                <li class="active">
                                    <a   href="<pro:url value="/musician"/>">Musician</a>
                                </li>
                                <li>
                                    <a   href="<pro:url value="/gallery"/>">Gallery</a>
                                </li>
                                <li>
                                    <a href="#blog">blog</a>
                                </li>
                                <li>
                                    <a href="#contact">Contact Us</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="col-12 d-block d-lg-none">
                    <div id="mobile_menu"></div>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- header area end -->
<!-- contact area start -->
<iframe src="<pro:url value="/drums"/>" id="drums_page" style="position: absolute;margin-top: 10px;margin-left: 200px;z-index: 1000;"
        frameborder="0" width="220" scrolling="No"
        height="200" leftmargin="0" topmargin="0"></iframe>
<div class="contact-area bg_dark ptb--100" style="
        background: url(<%=request.getContextPath()%>/assets/images/slider/mohu_bpm.jpg) center/cover no-repeat;"
        padding="0px"
        margin="0px"
>
    <div class="container" >
        <div class="msc-title section-title">
            <span style="margin-right: 100px">Create Your own Music</span>
        </div>
        <div class="row" >
            <div class="col-md-7">
                <div class='box box1' id='wrapper1'>
                    <div class="scroll textHint span_all" id="scrollOne">
                            <span class="span_lineNo" id="1">1&nbsp;&nbsp;&nbsp;&nbsp;</span>bpm:Express rhythmic speed.&nbsp;&nbsp; <button class="bpm_btn bpm_btn-tooltip btn-sequencer" id="sequencer-visible-btn" aria-label="BPM"><i class="fa fa-th"></i></button>&nbsp;<span class="span_KeyofBPM span_text_hover">BPM&nbsp;</span>;<br>
                            <span class="span_lineNo" id="2">2&nbsp;&nbsp;&nbsp;&nbsp;</span>times:Represents the number of hits.(you could never end it)&nbsp;&nbsp;<span class="span_KeyofTimes span_text_hover">TIMES&nbsp;</span>;<br>
                            <span class="span_lineNo" id="3">3&nbsp;&nbsp;&nbsp;&nbsp;</span>if/elese,while:Same as java or other language can do&nbsp;&nbsp;<span class="span_KeyofIFELSE span_text_hover">IF&nbsp;</span>;<span class="span_KeyofIFELSE span_text_hover">ELSE&nbsp;</span>;<span class="span_KeyofWhile span_text_hover">WHILE&nbsp;</span>;<br>
                            <span class="span_lineNo" id="4">4&nbsp;&nbsp;&nbsp;&nbsp;</span>rhy:Represent a beat.(short for rhythm)&nbsp;&nbsp;<span class="span_KeyofRHY span_text_hover">RHY&nbsp;</span><br/>
                            <span class="span_lineNo" id="5">5&nbsp;&nbsp;&nbsp;&nbsp;</span>sn:<img class="" style="height: 30px;width: 30px" src="<%=request.getContextPath()%>/assets/images/proimage/snare.png" onclick="img_snare();">;&nbsp;fl:<img class="" style="height: 30px;width: 30px" src="<%=request.getContextPath()%>/assets/images/proimage/floor_tom.png" onclick="img_floorTom();">;&nbsp;hi:<img class="" style="height: 30px;width: 30px" src="<%=request.getContextPath()%>/assets/images/proimage/hi_hat.png" onclick="img_hihat();">;&nbsp;bi:<img class="" style="height: 30px;width: 30px" src="<%=request.getContextPath()%>/assets/images/proimage/left_tom.png" onclick="img_leftTom();">;&nbsp;sm:<img class="" style="height: 30px;width: 30px" src="<%=request.getContextPath()%>/assets/images/proimage/right_tom.png" onclick="img_rightTom();">;&nbsp;ki:<img class="" style="height: 30px;width: 30px" src="<%=request.getContextPath()%>/assets/images/proimage/kick.png" onclick="img_kick();">;&nbsp;cr:<img class="" style="height: 30px;width: 30px" src="<%=request.getContextPath()%>/assets/images/proimage/crash.png" onclick="img_crash();"><br>
                            <span class="span_lineNo" id="6">6&nbsp;&nbsp;&nbsp;&nbsp;</span>also you can use the word "hop" to skip a beat.&nbsp;&nbsp; the symbol just like<img class="" style="height: 30px;width: 30px" src="<%=request.getContextPath()%>/assets/images/proimage/hop.png"><br/>
                       </div>
                </div>
            </div>
            <div class="col-md-4">
                <form>
                    <textarea
                            id="codeTextarea" rows="13" cols="46" spellcheck="false"
                            class="textbox"
                            onkeyup="getAndShow(this.value);tap();barOnKeyUp()"
                            <%--onclick=""--%>
                            >${template_promusician}</textarea>
                </form>
                <script type="text/javascript">
                    createTextAreaWithLines('codeTextarea');
                </script>
            </div>
            <div class="probutton col-md-1" >
                <div class="row">
                    <div class="col-md-12">
                        <a href="javascript:void(0)" onclick="Hints();" style="background: #fecc2f;">

                            Hints
                        </a>
                    </div>
                    <div class="col-md-12">
                        <a href="https://blog.csdn.net/No_Game_No_Life_/article/details/84398985"   style="background: #feb52f;">

                            Forum
                        </a>
                    </div>
                    <div class="col-md-12">
                        <a href="javascript:void(0)" onclick="Debug();" style="background: #feab2f;">

                            Debug
                        </a>
                    </div>
                    <div class="col-md-12">
                        <%--pro_close();CheckAndRun()--%>
                        <a href="javascript:void(0)" style="background: #fe942f;" onclick="CheckAndRun();">

                            Start
                        </a>
                    </div>
                    <div class="col-md-12">
                        <%--<a href="<pro:url value="/textarea/commit"/>" style="background: #fe832f;">--%>
                        <a href="javascript:void(0)" class="demo0 wobble" style="background: #fe832f;" onclick="showCommit();">
                            Submit
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<div class="footer-area ptb--50">
    <div class="container">
        <div class="footer-content">
            <p>Bounjour Monde</p>
        </div>
    </div>
</div>
<!-- contact area end -->

<!-- jquery latest version -->
<script src="<%=request.getContextPath()%>/assets/js/vendor/jquery-2.2.4.min.js"></script>
<!-- bootstrap 4 js -->
<script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script>
<!-- others plugins -->
<script src="<%=request.getContextPath()%>/assets/js/jquery.slicknav.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/counterup.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/waypoints.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/imagesloaded.pkgd.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/isotope.pkgd.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/jquery.magnific-popup.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/countdown.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/swiper.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/plugins.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/jquery.zoomslider.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/js/jquery.firefly.js"></script>
<!-- google map -->
<!---<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBO_5h890WNShs_YLGivCBfs2U89qXR-7Y&callback=initMap"></script>--->
<script src="<%=request.getContextPath()%>/assets/js/scripts.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/js/commit/css/animate.css"/> <!-- 动画效果 -->
<%--<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/js/commit/css/common.css"/><!-- 页面基本样式 -->--%>

<div id="HBox" style="visibility: hidden">
    <form id="form1" action="<pro:url value="/textarea/commit"/>" method="post" onsubmit="return false;" style="background-image: url('<%=request.getContextPath()%>/assets/images/slider/music-bg3.jpg')">
        <ul class="prolist">
            <li>
                <div class="logo">
                    <img src="<%=request.getContextPath()%>/assets/images/icon/logo.png" alt="logo">
                </div>
            </li>
            <li>
                <strong style="color: #0b0b0b">  <font color="#ffcb2a">Title</font></strong>
                <div class="fl"><input type="text" name="title" value="" class="title"/></div>
            </li>
            <li>
                <strong style="color: #0b0b0b"> <font color="#ffcb2a">&nbsp;Description</font></strong>
                <div class="fl"><input type="text" name="description" value="" class="description"/></div>
            </li>
            <li>
                <strong style="color: #0b0b0b"> <font color="#ffcb2a">&nbsp;Author</font></strong>
                <div class="fl"><input type="text" name="auther" value="anonymity" class="auther"/></div>
            </li>
            <li style="display: none"><textarea name="code" id="code"></textarea></li>
            <li><input type="submit" value="Submit" class="submitBtn"/></li>
        </ul>
    </form>
</div><!-- HBox end -->
<script src="<%=request.getContextPath()%>/assets/js/commit/js/jquery.hDialog.js" charset="UTF-8"></script>
<script>
    function showCommit(){
        var s=document.getElementById("HBox");
        s.style.visibility="visible";
    }
    $(function(){
        var $el = $('.dialog');
        $el.hDialog(); //默认调用

        $('.submitBtn').click(function () {
            var $title = $('.title');
            var $description = $('.description');
            if($title.val() == ''){
                $.tooltip('Please enter the title...'); $title.focus();
            }else if($description.val()==''){
                $.tooltip('Please enter the description...'); $description.focus();
            }else{
                document.getElementById('code').value=document.getElementById('codeTextarea').value;
//                alert( document.getElementById('code').value+"");
                document.getElementById('form1').submit();
            }

        });

        //页面加载完成后自动执行
        // $('#autoShow').hDialog({title:'????',autoShow: true});

        //带标题的
        $('.demo0').hDialog({title: 'Submit',height: 300,closeHide:false});


    });
</script>
</body>

</html>
