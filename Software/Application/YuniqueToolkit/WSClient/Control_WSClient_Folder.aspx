<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_WSClient_Folder.aspx.vb" Inherits="YuniFace.Control_WSClient_Folder" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle"><%#GetSystemText("Web Service Client")%></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</head>
	<frameset cols="200,*" frameborder="yes" bordercolor="#dbd7d0">
		<frame src="<%=URLMenu%>" name="wscmenu" scrolling="yes" marginheight="0" marginwidth="0" >
		<frame src="<%=URLMain%>" name="wscmain" scrolling="auto" marginheight="0" marginwidth="0" >
	</frameset>
</html>
