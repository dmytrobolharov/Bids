function calendar(sTxtBoxName) {
	windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
	windowDatePicker.focus();
}


function customwindow(strWindowUrl) {
	windowCustom = window.open("../System/Control/" + strWindowUrl + "","Custom","toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=50,top=50");
	windowCustom.focus();
}

function BeforeUnloadMsg() {
    Msg = "You may choose the follow options."
    return Msg;
}

var isChanged = null;
var sClassName = null;
var sBGColor = null;
var sFontColor = null;
function ChangeSelectedColor(obj) {
    sBGColor = obj.style.backgroundColor;
    sFontColor = obj.style.color;
    sClassName = obj.className;
    obj.className = "";
    obj.style.backgroundColor = "#508FE2";
    obj.style.color = "#FFFFFF";
    if (isChanged != null) {
//        var iStart = sClassName.indexOf(' ');
//        sClassName = sClassName.substring(0, iStart);
//        isChanged.className = "";
//        //alert(sClassName);
//        isChanged.className = sClassName;
        //alert(isChanged.className);
        isChanged.style.backgroundColor = sBGColor;
        isChanged.style.color = sFontColor;
    }

    isChanged = obj;
}