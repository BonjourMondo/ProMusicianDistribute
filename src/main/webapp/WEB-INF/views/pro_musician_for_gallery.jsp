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

    <!--评论相关-->
    <script src="<%=request.getContextPath()%>/assets/comment_js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/comment_js/data.js"></script>
    <script src="<%=request.getContextPath()%>/assets/comment_js/index.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/comment_js/comment_css.css"/>
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
            width: 600px; height: 375px; border:3px solid #453cad; margin: 10px auto; padding: 0; overflow: auto;
        }
        .box1 {
            padding: 20px;
            overflow: auto;
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
                                <li>
                                    <a   href="<pro:url value="/musician"/>">Musician</a>
                                </li>
                                <li class="active">
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
<iframe src="<pro:url value="/drums"/>" id="drums_page"
        style="position: absolute;margin-top: 300px;margin-left: 800px;z-index: 1000;"
        frameborder="0" width="400" scrolling="No"
        height="250" leftmargin="0" topmargin="1000"></iframe>
<div class="contact-area bg_dark ptb--100" style="background: url(<%=request.getContextPath()%>/assets/images/slider/mohu_bpm.jpg) center/cover no-repeat;">
    <div class="container" >
        <div class="msc-title section-title">
            <span style="font-size: 20px;">${title}</span> LeesangHyuk  Created at:${datetime}
        </div>
        <div class="row" >
            <div class="col-md-6">
                <div class='box box1'>
                    <div class="scroll textHint span_all"
                         id="scrollOne"
                    >
                        ${analyseCode}
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <form>
                    <textarea
                            id="codeTextarea" rows="13" cols="46" spellcheck="false"
                            class="textbox" style="visibility: hidden"
                    >${template_promusician}</textarea>
                </form>
            </div>
            <div class="probutton col-md-4" >
                <div class="row">
                    <div class="col-md-4">
                        <%--pro_close();CheckAndRun()--%>
                            <%--<a href="/user/test/xxxx.txt" download="文件名.txt">点击下载</a>--%>
                        <a href="<%=request.getContextPath()%>/data/lex.stone" download="lex.stone" style="background: #fecc2f;; height: 50px;width: 100px">

                            Download
                        </a>
                    </div>
                    <div class="col-md-4">
                        <%--pro_close();CheckAndRun()--%>
                        <a href="javascript:void(0)" onclick="barrage_click();" style="background: #feb52f; height: 50px;width: 100px" id="comment_manage">

                            Barraget/Off
                        </a>
                    </div>
                    <script type="text/javascript">

                        // 数据初始化
                        var Obj = $('body').barrage({
                            data : data, //数据列表
                            row : 5,   //显示行数
                            time : 2500, //间隔时间
                            gap : 20,    //每一个的间隙
                            position : 'fixed', //绝对定位
                            direction : 'bottom right', //方向
                            ismoseoverclose : true, //悬浮是否停止
                            height : 30, //设置单个div的高度
                        })
                        Obj.start();

                        //添加评论
                        function submit_barraget(){
                            var val = $("#barrage_content").val();
                            //此格式与dataa.js的数据格式必须一致
                            var addVal = {
                                href : '',
                                text : val
                            }
                            //添加进数组
                            Obj.data.unshift(addVal);
                            alert('评论成功');
                        }

                        // $("").click(function(){
                        //     Obj.start();
                        // })
                        let boolean_comment=true;
                        function barrage_click() {
                            if(boolean_comment) {
                                Obj.close();
                                // document.getElementById("comment_manage").innerText
                                $("#comment_manage").text("Barraget/On");
                                boolean_comment=false;
                            }
                            else{
                                Obj.start();
                                $("#comment_manage").text("Barraget/Off");
                                boolean_comment=true;
                            }
                        }

                    </script>
                    <div class="col-md-4">
                        <%--pro_close();CheckAndRun()--%>
                        <a href="javascript:void(0)" style="background: #feab2f; height: 50px;width: 100px" onclick="CheckAndRun();">

                            Start
                        </a>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px">
                    <div class="col-md-10">
                    <input type="text" style="width: 100%" class="form-control" name="" id="barrage_content" placeholder="Add barraget content...">
                    </div>
                    <div class="col-md-2" style="margin-left: 0px;margin-top:0px;padding-left: 0px; padding-top: 0px;">
                        <a href="javascript:void(0)" onclick="submit_barraget();" style="background: #fe942f; height: 35px;width: 60px; margin-left: 0px;margin-top:0px;padding-left: 0px; padding-top: 0px;" id="submit_barraget">

                            Send
                        </a>
                    </div>

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
<script src="<%=request.getContextPath()%>/assets/js/commit/js/jquery.hDialog.js"></script>
</body>

</html>
