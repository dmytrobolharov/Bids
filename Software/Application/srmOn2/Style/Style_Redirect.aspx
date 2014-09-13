<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Redirect.aspx.vb" Inherits="srmOnApp.Style_Redirect" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Redirect</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body onLoad="self.focus();">
		<script language="JavaScript">
		<!--
			top.window.moveTo(0,0);
			if (document.all) {
				top.window.resizeTo(screen.availWidth,screen.availHeight);
				}
			else if (document.layers||document.getElementById) {
				if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
					top.window.outerHeight = screen.availHeight;
					top.window.outerWidth = screen.availWidth;
				}
			}
			
			if (self != top) top.location.replace(self.location);	
			
			self.focus();
			window.location='<%= strPageRedirectUrl %>'			
			
		//-->
		</script>	
		<form id="Form1" method="post" runat="server">
		</form>
	</body>
</HTML>
