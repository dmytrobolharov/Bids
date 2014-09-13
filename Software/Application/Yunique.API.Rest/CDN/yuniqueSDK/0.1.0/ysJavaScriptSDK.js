
// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//    Dependencies....
//        <script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/hmac-md5.js"></script>
//        <script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/components/enc-base64-min.js"></script>
//        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
//    Eventually I wil write a loader for these.  Till then, include in your HTML.
// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

// Our Top Level 'NameSpace'
var yunique = yunique || {};

// Might be prudent to check to see if certain objects exist and are infact already included..
// and raise alerts if not
// if (jquery.blah == null)
//      alert("Dood!  You forgot to source JQuery!");
// if (ajax.blah == null)
//      alert("Dood!  You forgot to source AJax!");

// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//      Authentication 
// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
yunique.Authentication = yunique.Authentication || {};

yunique.Authentication.GetKeyID = function () {
    // This is my wsClientID from uWebServiceClient
    return "40000000-0000-0000-0000-000000000011";
};

yunique.Authentication.GetClearTextSharedClientSecret = function () {
    // Clear text 'password' in uWebServiceClient (the encrypted == 'CO6I80aLnwoAz7SMQ2kxOw==') 
    return "plmon1234@";
};

yunique.Authentication.GetUserName = function () {
    // This is my UserName from Users
    return "Administrator";
};

yunique.Authentication.GetClearTextSharedUserSecret = function () {
    // Clear text 'password' in Users (the encrypted == 'CO6I80aLnwoAz7SMQ2kxOw==') 
    return "plmon1234@";
};

yunique.Authentication.GetUtcNow = function () {
    // Produce a timestamp in UTC with format of 'YYYY-MM-DDThh:mm.ssZ'
    var d = new Date();
    var n = d.toISOString();

    return n;
};

yunique.Authentication.GetSignature = function (clearTextSharedClientSecret, clearTextSharedUserSecret, stringToSign, timeStamp) {
    //ByVal WSClientSecret As String, ByVal UserSecret As String, ByVal ToSign As String, ByVal TimeStamp As String, Optional ByVal Salt As String = "Yunique.API"
    // Produce an MD5 hash of our currently agreed upon string.
    //    NB: this IS different than the REST/Soap agreed upon string.  There is resons for this.
    var salt = "Yunique.API;";
    var fullStringToSign = salt + "GET" + ";" + stringToSign + ";" + timeStamp;
    var hashedString = CryptoJS.HmacMD5(fullStringToSign, clearTextSharedClientSecret + "&" + clearTextSharedUserSecret).toString(CryptoJS.enc.Base64);

    return hashedString;
};

yunique.Authentication.GetSignatureURISafe = function (clearTextSharedClientSecret, clearTextSharedUserSecret, stringToSign, timeStamp) {

    return encodeURIComponent(this.GetSignature(clearTextSharedClientSecret, clearTextSharedUserSecret, stringToSign, timeStamp));

};

yunique.Authentication.AppendAuth2QString = function (origString) {

    var qs = new String();
    var utcNow = this.GetUtcNow();
    var keyId = this.GetKeyID();
    var clearTextClientSecret = this.GetClearTextSharedClientSecret();
    var username = this.GetUserName();
    var clearTextUserSecret = this.GetClearTextSharedUserSecret();
    var signature = this.GetSignatureURISafe(clearTextClientSecret, clearTextUserSecret, keyId, utcNow);

    if (origString.indexOf("?") == -1) {
        qs = origString + "?";
    } else {
        qs = origString + "&";
    }
    qs += "KeyID=" + keyId +
                    "&PLMUsername=" + username +
                    "&TS=" + utcNow +
                    "&Signature=" + signature;

    // Uncomment below to "Omit HMAC" checks...
    //qs = origString + "?KeyID=xyzzy-OmitHMAC";

    return qs;
};

yunique.Authentication.AppendAuth2QString2 = function (origString) {

    var qs = new String();
    var utcNow = this.GetUtcNow();
    var keyId = this.GetKeyID();
    var clearTextClientSecret = this.GetClearTextSharedClientSecret();
    var username = this.GetUserName();
    var clearTextUserSecret = this.GetClearTextSharedUserSecret();
    var signature = this.GetSignatureURISafe(clearTextClientSecret, clearTextUserSecret, origString, utcNow);

    if (origString.indexOf("?") == -1) {
        qs = origString + "?";
    } else {
        qs = origString + "&";
    }

    qs += "WSClientID=" + keyId +
                    "&PLMUsername=" + username +
                    "&TS=" + utcNow +
                    "&Signature=" + signature;

    // Uncomment below to "Omit HMAC" checks...
    //qs = origString + "?KeyID=xyzzy-OmitHMAC";

    return qs;
};

////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
////      RESTful Code
////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
yunique.RESTClient = yunique.RESTClient || {};

yunique.RESTClient.RESTCall = function (url) {
    var xmlhttp = null;
    if (window.XMLHttpRequest) {
        xmlhttp = new XMLHttpRequest();
        if (typeof xmlhttp.overrideMimeType != 'undefined') {
            xmlhttp.overrideMimeType('text/xml');
        }
    } else if (window.ActiveXObject) {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        alert('Perhaps your browser does not support xmlhttprequests?');
    }

    xmlhttp.open('GET', url, true);
    xmlhttp.send(null);
};

////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
////      Debug Console
////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
yunique.Debug = yunique.Debug || {};

yunique.Debug.Enabled = false;
yunique.Debug.Console = null;

yunique.Debug.Print = function (msg) {
    if (this.Enabled) {

        var ts = new Date().toISOString();
        var newMsg = String();
        newMsg += msg + "<br id=\"" + ts + "\">";

        if (this.Console == null || this.Console.closed == true) {
            this.Console = this.ConsoleCreate(document.title);
        }
        this.Console.document.getElementById("DebugDiv").innerHTML += newMsg;
        this.Console.document.getElementById(ts).scrollIntoView(true);
    }

    return msg;
};

yunique.Debug.ConsoleCreate = function (parentTitle) {
    if (this.Enabled) {

        var disp_setting = "toolbar=no,location=no,directories=no,menubar=no,";
        disp_setting += "scrollbars=yes,width=1000, height=600, left=100, top=25";

        var newWindow = window.open("", "Yunique_Debug_Console", disp_setting, false);
        newWindow.document.open();
        newWindow.document.write('<html><head><title>Debug Console for ' + parentTitle + '</title>');
        newWindow.document.write('</head><body bgcolor=\"white\">');
        newWindow.document.write('    <div id=\"DebugDiv\" style=\"border : solid 2px #ff0000; width : 100%; height : 500px; overflow : auto;\" >');
        newWindow.document.write('    </div>');
        newWindow.document.write('</body></html>');
        newWindow.document.close();
        newWindow.focus();

        return newWindow;

    }
    else {
        return null;
    }
};

////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
////      Form Handler
////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
yunique.WebComponents = yunique.WebComponents || {};
yunique.WebComponents.FormHandler = yunique.WebComponents.FormHandler || {};

yunique.WebComponents.FormHandler.ID = "newGrid";


////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
////      Grid Handler
////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
yunique.WebComponents.Grid = yunique.WebComponents.Grid || {};

yunique.WebComponents.Grid.ID = "newGrid";


////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
////      Tab Handler
////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
yunique.WebComponents.Tab = yunique.WebComponents.Tab || {};

yunique.WebComponents.Tab.ID = "newGrid";

////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
////      Tree Handler
////   =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
yunique.WebComponents.Tree = yunique.WebComponents.Tree || {};

yunique.WebComponents.Tree.ID = "newGrid";
