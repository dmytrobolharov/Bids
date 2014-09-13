<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Group_Folder.aspx.vb" Inherits="plmOnApp.Control_Group_Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"><%#GetsystemText("Control Panel") %></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<FRAMESET cols="200,*" bordercolor="#dbd7d0">
		<frame SRC="<%=URLMenu%>" name="menu" scrolling="yes" marginheight="0" marginwidth="0"></frame>
		<frame src="<%=URLMain%>" name="main" scrolling="auto" marginheight="0" marginwidth="0"></frame>
	</FRAMESET>
</HTML>
