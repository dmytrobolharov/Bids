<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Add_Frame.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Add_Frame" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Style</TITLE>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<FRAMESET rows="27,*,*" framespacing="1" frameborder="no" bordercolor="#ebebeb">
		<FRAME NAME="Toolbar" SRC="<%=URLToolbar%>" SCROLLING="no" marginheight=0 marginwidth=0 >
		<FRAME NAME="Select" SRC="<%=URLSelect%>" SCROLLING="yes" marginheight=0 marginwidth=0 >
		<frame name="Selected" src="<%=URLSelected%>" scrolling="yes" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
