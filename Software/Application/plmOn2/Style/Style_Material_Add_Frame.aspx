<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Material_Add_Frame.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_Frame" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD runat="server">
		<TITLE>Material Add</TITLE>
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

			//if (self != top) top.location.replace(self.location);	

			//-->
		</script>
		


	</HEAD>
	<FRAMESET cols="150,*" framespacing="1" frameborder="no" bordercolor="#ebebeb" onload="self.focus()" onunload="reloadPage('<%=Request.QueryString("SDID")%>','<%=Request.QueryString("SID")%>','<%=Request.QueryString("SN")%>' , '<%=Request.QueryString("STP")%>', '<%=Request.QueryString("WFID")%>','<%=Request.QueryString("WFIID")%>')">
		<FRAME name="menu" SRC="<%=URLMenu%>" SCROLLING="yes" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
