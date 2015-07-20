var frameType = "";
var defaultsetting = "";

function getCurrentSetting() {
    if (document.body)
        return (document.body.cols) ? document.body.cols : document.body.rows;
}

function setframevalue(coltype, settingvalue) {
    if (coltype == "rows") {
        document.body.rows = settingvalue;
    }
    else if (coltype == "cols") {
        document.body.cols = settingvalue;
    }
}

function resizeFrame(contractsetting, objImg, iStayOpen) {

    if (iStayOpen == 1) {
        setframevalue(frameType, defaultsetting);
    }
    else {

        if (objImg != null) {
            if ((objImg.src.indexOf('FrameClose.png')) > 0) {
                setframevalue(frameType, contractsetting);
                objImg.parentNode.style.textAlign = 'right';
                objImg.src = '../System/Icons/FrameOpen.png';

            }
            else {
                setframevalue(frameType, defaultsetting);
                objImg.parentNode.style.textAlign = 'left';
                objImg.src = '../System/Icons/FrameClose.png';

            }
        }

        else {
            setframevalue(frameType, contractsetting);
        }
    }
}

function init() {
    if (!document.all && !document.getElementById) return
    if (document.body != null) {
        frameType = (document.body.cols) ? "cols" : "rows";
        defaultsetting = (document.body.cols) ? document.body.cols : document.body.rows;
    }
    else {
        setTimeout("init()", 100);
    }
}

setTimeout("init()", 100);
