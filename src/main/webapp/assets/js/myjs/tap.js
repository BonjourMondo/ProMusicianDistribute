var str="";
var myInput = document.getElementById("codeTextarea");
function tap() {
    myInput = document.getElementById("codeTextarea");
    str = "        ";
    if(myInput.addEventListener ) {
        myInput.addEventListener('keydown',this.keyHandler,false);
    } else if(myInput.attachEvent ) {
        myInput.attachEvent('onkeydown',this.keyHandler); /* damn IE hack */
    }
}

function keyHandler(e) {
    var TABKEY = 18;
    if(e.keyCode == TABKEY) {
        insertText(myInput,str);
        if(e.preventDefault) {
            e.preventDefault();
        }
    }

}
function insertText(obj,str) {
    if (document.selection) {
        var sel = document.selection.createRange();
        sel.text = str;
    } else if (typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number') {
        var startPos = obj.selectionStart,
            endPos = obj.selectionEnd,
            cursorPos = startPos,
            tmpStr = obj.value;
        obj.value = tmpStr.substring(0, startPos) + str + tmpStr.substring(endPos, tmpStr.length);
        cursorPos += str.length;
        obj.selectionStart = obj.selectionEnd = cursorPos;
    } else {
        obj.value += str;
    }
}



//img点击
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