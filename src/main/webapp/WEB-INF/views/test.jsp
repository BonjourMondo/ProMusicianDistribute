<!DOCTYPE html>
<%@page isELIgnored="false" pageEncoding="utf-8"%>
<html>
<head>
    <title>弹幕</title>
    <meta charset="utf-8">
    <meta id="scale" content="initial-scale=1, maximum-scale=1, user-scalable=0" name="viewport">
    <script src="<%=request.getContextPath()%>/assets/comment_js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/assets/comment_js/data.js"></script>
    <script src="<%=request.getContextPath()%>/assets/comment_js/index.js"></script>
    <style type="text/css" src="<%=request.getContextPath()%>/assets/comment_js/comment_css.css"></style>
</head>
<body>
<button id="stop" class="btn btn-primary">停止</button>
<button id="open" class="btn btn-primary">弹</button>
<input type="text" class="form-control" name="" id="barrage_content" placeholder="添加弹幕内容"><button class="btn btn-primary" id="submit_barraget">Send</button>
</body>
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
    $("#submit_barraget").click(function(){

        var val = $("#barrage_content").val();
        //此格式与dataa.js的数据格式必须一致
        var addVal = {
            href : '',
            text : val
        }
        //添加进数组
        Obj.data.unshift(addVal);
        alert('评论成功');

    })

    $("#open").click(function(){
        Obj.start();
    })
    $("#stop").click(function(){
        Obj.close();
    })
</script>
</html>