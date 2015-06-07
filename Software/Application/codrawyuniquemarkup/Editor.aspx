﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Editor.aspx.cs" Inherits="CoDrawYuniqueMarkup._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="history/history.css" />
		<title></title>
		<script src="AC_OETags.js" language="javascript"></script>
		<script src="history/history.js" language="javascript"></script>
		<style>
			body { margin: 0px; overflow:hidden }
			.TableHeader {
			    background-image: url("./img/younique/table_header.gif");
			    background-repeat: repeat-x;
			    font-family: Tahoma,Geneva,Arial,Helvetica,sans-serif;
			    font-size: 11px;
			    font-weight: bold;
			    padding: 2px;
			}
		</style>
		<script language="JavaScript" type="text/javascript">
		<!--
		// -----------------------------------------------------------------------------
		// Globals
		// Major version of Flash required
		var requiredMajorVersion = 10;
		// Minor version of Flash required
		var requiredMinorVersion = 2;
		// Minor version of Flash required
		var requiredRevision = 0;
		// -----------------------------------------------------------------------------
		// -->
		
		//get url variable value by name
		function gup(name)
		{
			name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");

			var regexS = "[\\?&]"+name+"=([^&#]*)";

			var regex = new RegExp( regexS );
			var results = regex.exec( window.location.href );

			if( results == null )
				return "";
			else
				return results[1];
		}
		
		function getApp(appName) 
		{
        	       	if (navigator.appName.indexOf ("Microsoft") != -1) 
            	return window.document[appName];
        	else
            	return document[appName];
    	}
			
		function refresh()
		{
			
			window.opener.location.href = window.opener.location.href.replace("POP=Markup&", "");
			window.opener.opener.location.href = window.opener.opener.location.href.replace("POP=Markup&", "");
		}
		
		function saveClick()
		{
			try 
			{ 
				getApp("CoDrawMarkup").Save();
			}
			catch(e)
			{
				alert("Editor is not ready yet");
			}
		}
		
		function saveCloseClick()
		{
			try 
			{ 
				getApp("CoDrawMarkup").SaveClose();
			}
			catch(e)
			{
				alert("Editor is not ready yet");
			}
		}
		
		function windowClose()
		{
			window.close();
			
			refresh();
		}
		
		function getDocHeight() {
		    var D = document;
		    return Math.max(
		        Math.max(D.body.scrollHeight, D.documentElement.scrollHeight),
		        Math.max(D.body.offsetHeight, D.documentElement.offsetHeight),
		        Math.max(D.body.clientHeight, D.documentElement.clientHeight)
		    );
		}
		
		function maxWindow() {
			window.moveTo(0, 0);

			if (document.all) {
				top.window.resizeTo(screen.availWidth, screen.availHeight);
			}

			else if (document.layers || document.getElementById) {
				if (top.window.outerHeight < screen.availHeight || top.window.outerWidth < screen.availWidth) {
					top.window.outerHeight = screen.availHeight;
					top.window.outerWidth = screen.availWidth;
				}
			}
		}
	</script>
</head>
<body scroll="no">
    <form id="form1" runat="server" onsubmit="return false">
        <!--Younique save sketch button-->
	<table width="100%" cellspacing="0" cellpadding="0" border="0" class="TableHeader" id="toolbar">
		<tbody>
			<tr valign="middle">
				<td width="10" valign="middle" align="center"><img width="3" height="15" src="./img/yunique/bbTbSCnr.gif"></td>
				<td>
					<input type="image" style="height:0px; width:0px;border-width:0px;" src="./img/yunique/1x1.gif">
					<input type="image" style="border-width:0px;" src="http://<%= Request.Url.Host %>/plmOnImageServer/ButtonStream.ashx?BN=btn_save.gif&PL=en-US" 
						   id="imgBtnNew" name="imgBtnNew" onclick="saveClick()">
					<input type="image" style="border-width:0px;" src="http://<%= Request.Url.Host %>/plmOnImageServer/ButtonStream.ashx?BN=btn_save_close.gif&PL=en-US" 
						   id="btnSaveClose" name="btnSaveClose" onclick="saveCloseClick()">
					<input type="image" style="border-width:0px;" src="http://<%= Request.Url.Host %>/plmOnImageServer/ButtonStream.ashx?BN=btn_close.gif&PL=en-US" 
						   id="btnClose" name="btnClose" onclick="window.close();">
				</td>
			</tr>
		</tbody>
	</table>
	
	<script language="JavaScript" type="text/javascript">
		maxWindow();
		
	    //determine height
	    var dHeight = getDocHeight() - 30;

	    //determine parameters

	    var userName = gup('User');
	    var imageId = gup('image');
	    var imageVersion = gup('version');
	    var imageVersionId = gup('versionId');
		var saveType = gup('saveType');
		var imageFrame = gup('frame');
		var x1 = gup('x1');
		var x2 = gup('x2');
		var y1 = gup('y1');
		var y2 = gup('y2');
		
		var cropX = x1;
		var cropY = y1;
		var cropWidth = parseInt(x2) - parseInt(x1);
		var cropHeight = parseInt(y2) - parseInt(y1);
		
		var serverHost = '<%= Request.ServerVariables["SERVER_NAME"] %>';
		
		//for logging
		var SRSID = gup('SRSID');
        var SRTID = gup('SRTID');
        var FDIM =  gup('FDIM');
        var TID = gup('TID');
        var TP = gup('TP');
		
		// for Sample Images
		var SID = gup('SID');
		var SN = gup('SN');
		var SWID = gup('SWID');
		var SRWID = gup('SRWID');
		var TB = gup('TB');
		
		if (navigator.userAgent.indexOf('iPad') != -1 || navigator.userAgent.indexOf('iPhone') != -1 || navigator.userAgent.indexOf('iPod') != -1) {
			if (saveType == "" || saveType == "basic") {
				saveType = "basic";
				document.location = "html5/Editor.html?user="+userName+"&image="+imageId+"&version="+imageVersion+"&versionId="+imageVersionId+"&saveType="+saveType;
			}
			if (saveType == "mamagi") {
				document.location = "html5/test/Editor.html?userName=" + userName + "&imageVersion=" + imageVersion + "&imageId=" + imageId + "&imageVersionId=" + imageVersionId + "&saveType=" + saveType + "&SRSID=" + SRSID + "&SRTID=" + SRTID + "&FDIM=" + FDIM + "&TID=" + TID + "&TP=" + TP + "&imageFrame=" + imageFrame + "&cropX=" + cropX + "&cropY=" + cropY + "&cropWidth=" + cropWidth + "&cropHeight=" + cropHeight + "&SID=" + SID + "&SN=" + SN + "&SWID=" + SWID + "&SRWID=" + SRWID + "&TB=" + TB;
			}
		}

	    // Version check for the Flash Player that has the ability to start Player Product Install (6.0r65)
	    var hasProductInstall = DetectFlashVer(6, 0, 65);

	    // Version check based upon the values defined in globals
	    var hasRequestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);

	    if (hasProductInstall && !hasRequestedVersion) {
	        // DO NOT MODIFY THE FOLLOWING FOUR LINES
	        // Location visited after installation is complete if installation is required
	        var MMPlayerType = (isIE == true) ? "ActiveX" : "PlugIn";
	        var MMredirectURL = window.location;
	        document.title = document.title.slice(0, 47) + " - Flash Player Installation";
	        var MMdoctitle = document.title;

	        AC_FL_RunContent(
				"src", "playerProductInstall",
				"FlashVars", "MMredirectURL=" + MMredirectURL + '&MMplayerType=' + MMPlayerType + '&MMdoctitle=' + MMdoctitle + "",
				"width", "100%",
				"height", "100%",
				"align", "middle",
				"id", "CoDrawMarkup",
				"quality", "high",
				"bgcolor", "#ffffff",
				"name", "CoDrawMarkup",
				"allowScriptAccess", "sameDomain",
				"type", "application/x-shockwave-flash",
				"pluginspage", "http://www.adobe.com/go/getflashplayer"
			);
	    } else if (hasRequestedVersion) {
	        // if we've detected an acceptable version
	        // embed the Flash Content SWF when all tests are passed
	        AC_FL_RunContent(
					"src", "CoDrawMarkup?userName=" + userName + "&imageVersion=" + imageVersion + "&imageId=" + imageId + "&imageVersionId=" + imageVersionId + "&saveType=" + saveType + "&SRSID=" + SRSID + "&SRTID=" + SRTID + "&FDIM=" + FDIM + "&TID=" + TID + "&TP=" + TP + "&imageFrame=" + imageFrame + "&cropX=" + cropX + "&cropY=" + cropY + "&cropWidth=" + cropWidth + "&cropHeight=" + cropHeight + "&SID=" + SID + "&SN=" + SN + "&SWID=" + SWID + "&SRWID=" + SRWID + "&TB=" + TB + "&serverHost=" + serverHost,
					"width", "100%",
					"height", dHeight,
					"align", "middle",
					"id", "CoDrawMarkup",
					"quality", "high",
					"bgcolor", "#ffffff",
					"name", "CoDrawMarkup",
					"allowScriptAccess", "sameDomain",
					"type", "application/x-shockwave-flash",
					"pluginspage", "http://www.adobe.com/go/getflashplayer"
			);
	    } else {  // flash is too old or we can't detect the plugin
	        var alternateContent = 'Alternate HTML content should be placed here. '
			+ 'This content requires the Adobe Flash Player. '
			+ '<a href=http://www.adobe.com/go/getflash/>Get Flash</a>';
	        document.write(alternateContent);  // insert non-flash content
	    }
	    // -->
	</script>
<noscript>
  	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
			id="CoDrawMarkup" width="100%" height="100%"
			codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
			<param name="movie" value="CoDrawMarkup.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#ffffff" />
			<param name="allowScriptAccess" value="sameDomain" />
			<embed src="CoDrawMarkup.swf" quality="high" bgcolor="#ffffff"
				width="100%" height="100%" name="CoDrawMarkup" align="middle"
				play="true"
				loop="false"
				quality="high"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.adobe.com/go/getflashplayer">
			</embed>
	</object>
</noscript>
    </form>
</body>
</html>
