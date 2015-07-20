<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitRedirect.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitRedirect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Please Wait...</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
	<SCRIPT language="JavaScript" type="text/javascript">
	<!--
	    function DoPageLoad() {

	        var Timer = setTimeout('self.focus();', 1000);
	    }
	// -->
	</SCRIPT>
</head>
<body onbeforeunload="busyBox.Show();" onload="DoPageLoad();">
<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
    <form id="form1" runat="server">
    <div id="BusyBoxDiv" style="BORDER-RIGHT: gainsboro 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: gainsboro 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: gainsboro 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: gainsboro 0px solid; POSITION: absolute; BACKGROUND-COLOR: transparent; TEXT-ALIGN: center">
	    <p style="WIDTH: 220px; TEXT-ALIGN: center">
	    <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
		    <TR>
			    <TD height="32" width="50"><img id="BusyBoxImg" src="../system/images/busy_Layer_0.gif" width="32" height="32"></TD>
			    <TD class="fontHead"><asp:Label ID="lblWait" runat="server" Text="Please Wait..."></asp:Label><br><asp:Label ID="lblLoad" runat="server" Text="Page Loading"></asp:Label></TD>
		    </TR>
	    </TABLE>
	    </p>
    </div>
    <script language="javascript" type="text/javascript">
	    // Instantiate our BusyBox object
	    var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);
    </script>
    </form>
</body>
</html>
