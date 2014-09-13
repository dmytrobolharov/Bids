<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlanning.aspx.vb" Inherits="plmOnApp.LinePlanning" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="htmlHeader" runat="server"></title>
    <script type="text/javascript" src="../System/Jscript/Frameset.js"></script>
	<script language="JavaScript">
		<!--

		if (window.screen) {
			var aw = screen.availWidth;
			var ah = screen.availHeight;
			window.moveTo(0, 0);
			window.resizeTo(aw, ah);
		}

		if (self != top) top.location.replace(self.location);	

		self.focus();

		//-->
	</script>    
</head>


	<FRAMESET cols="150,*" bordercolor="#ebebeb">
		<FRAME NAME="menu" SRC="<%=URLMenu%>" SCROLLING="yes" marginheight="0" marginwidth="0" >
		<frame name="main" src="<%=URLMain%>" SCROLLING="auto" marginheight="0" marginwidth="0" >
	</FRAMESET>
</html>
