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