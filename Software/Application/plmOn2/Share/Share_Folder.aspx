<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Share_Folder.aspx.vb" Inherits="plmOnApp.Share_Folder"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE runat="server" id="PageTitle">Administrator Panel</TITLE>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="JavaScript">
		<!--
			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}
			
			if (self != top) top.location.replace(self.location);				
			
		//-->
		</script>
	</HEAD>
	<FRAMESET cols="150,*" frameborder="yes" bordercolor="#dbd7d0">
		<FRAME NAME="adminmenu" SRC="<%=URLMenu%>" SCROLLING=yes marginheight=0 marginwidth=0 >
		<frame name="adminmain" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
