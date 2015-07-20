
if (typeof(Page_ConfirmationVer) == "undefined")
    alert("Unable to find script library. Try placing it file manually.");
else if (Page_ConfirmationVer != "1.7")
    alert("This page uses an incorrect version of WebUIConfirmation.js. The page expects version 1.7. The script library is " + Page_ConfirmationVer + ".");
else
    ConfirmationOnLoad();
