<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Help_Folder.aspx.vb" Inherits="plmOnApp.Help_Folder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head id="Head1" runat="server">
    <title runat="server" id="PageTitle"></title>
	<script language="JavaScript">
		<!--
	    var test = "a";
	    if (window.screen) {
	        var aw = screen.availWidth;
	        var ah = screen.availHeight;
	        window.moveTo(0, 0);
	        window.resizeTo(aw, ah);
	    }

	    if (self != top) top.location.replace(self.location);
	    //window.onbeforeunload = function() { return "You may choose the follow options."; }
	    function ClearEvent() {
	        window.onbeforeunload = null;
	    }
		//-->
	</script> 
</head>
<%--<FRAMESET cols="300,*" frameborder="yes" bordercolor="#dbd7d0">
    <frame name="menu" src="<%=URLMenu%>" scrolling="no" marginheight="0" marginwidth="0" >
    <frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight="0" marginwidth="0" >
</FRAMESET>--%>
<FRAMESET cols="*" frameborder="yes" bordercolor="#dbd7d0">
    <frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight="0" marginwidth="0" >
</FRAMESET>
