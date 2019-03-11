//    ajax传数据
// function getAndShow(code) {
//     $.ajax({
//         type: "POST",
//         url: "/textarea",
//         data: {str:code},
//         dataType: "json",
//         success: function(data){
//             document.getElementById("scrollOne").innerHTML=data.code;
//         },
//         error:function(data){
//             //donothing
//         }
//     });
// }

var oMyBar1;
window.onload = function () {
    oMyBar1 = new MyScrollBar({
        selId: 'wrapper1',
        bgColor: 'rgba(50, 50, 50, 0.2)',
        barColor: '#2E8EEA',
        enterColor: '#056FD8',
        enterShow: false,
        borderRadius: 2
    });
    var t = document.getElementById('codeTextarea');
    t.onclick = function () {
        oMyBar1.setSize();
        var v = t.value;
        // 开始到光标位置的内容
        var cv = '';
        if ('selectionStart' in t) {
            cv = v.substr(0, t.selectionStart);
        } else {
            var oSel = document.selection.createRange();
            oSel.moveStart('character', -t.value.length);
            cv = oSel.text;
        }
        // 获取当前是几行
        var cl = cv.split('\n').length-4;
        if(cl<0)
            cl=1;
        var s={
            id:cl,
            time: 400
        };
        oMyBar1.jump(s);
    }
}
function barOnKeyUp() {
    oMyBar1.setSize();
//        alert("barOnKeyUp")
    var t = document.getElementById('codeTextarea');
    var v = t.value;
    // 开始到光标位置的内容
    var cv = '';
    if ('selectionStart' in t) {
        cv = v.substr(0, t.selectionStart);
    } else {
        var oSel = document.selection.createRange();
        oSel.moveStart('character', -t.value.length);
        cv = oSel.text;
    }
    // 获取当前是几行
    var cl = cv.split('\n').length-4;
    if(cl<0)
        cl=1;
//        alert(cl);
    var s={
        id:cl,
        time: 400
    };
    oMyBar1.jump(s);
}

function img_crash() {
    var iframe = document.getElementById('drums_page').contentWindow;
    iframe.crash();
}
function img_hihat() {
    var iframe = document.getElementById('drums_page').contentWindow;
    iframe.hiHat();
}
function img_snare() {
    var iframe = document.getElementById('drums_page').contentWindow;
    iframe.snare();
}
function img_kick() {
    var iframe = document.getElementById('drums_page').contentWindow;
    iframe.kick();
}
function img_floorTom() {
    var iframe = document.getElementById('drums_page').contentWindow;
    iframe.floorTom();
}
function img_leftTom() {
    var iframe = document.getElementById('drums_page').contentWindow;
    iframe.leftTom();
}
function img_rightTom() {
    var iframe = document.getElementById('drums_page').contentWindow;
    iframe.rightTom();
}







