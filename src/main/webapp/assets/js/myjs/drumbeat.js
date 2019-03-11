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