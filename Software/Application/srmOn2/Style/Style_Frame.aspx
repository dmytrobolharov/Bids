<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Frame.aspx.vb" Inherits="srmOnApp.Style_Frame" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE id="htmlHeader" runat="server">Style</TITLE>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="JavaScript"><!--
		    function reloadPage() {
		        //parent.opener.location = parent.opener.location.href;
		    }
		//--></script> 
	</HEAD>
	<FRAMESET cols="270,*" frameborder="yes" bordercolor="#dbd7d0" onload="self.focus()" onunload="reloadPage()">
		<FRAME SRC="<%=URLMenu%>" NAME="menu" SCROLLING="yes" marginheight=0 marginwidth=0 >
		<frame name="main" src="<%=URLMain%>" scrolling="auto" marginheight=0 marginwidth=0 >
	</FRAMESET>
</HTML>
