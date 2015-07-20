<%@ Page Language="vb" AutoEventWireup="false" Codebehind="error.aspx.vb" Inherits="plmOn2Report._error" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
	 <title runat="server" id="PageTitle"></title>
		
		<% Response.CacheControl = "no-cache" %>
		<% Response.Expires = -1 %>
		<meta name="GENERATOR" content="Microsoft Visual Studio.NET 7.0">
		<meta name="CODE_LANGUAGE" content="Visual Basic 7.0">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<link href="System/CSS/Style.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" height="50">
				<tr>
					<td width="10">&nbsp;</td>
					<td width="50">
						<div align="center"><img src="../System/Icons/icon_warning_32.gif" width="38" height="38" border="0"></div>
					</td>
					<td class="fontHead">
                        <asp:Label ID="lblHeader1" runat="server"></asp:Label>
						</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="10" height="25">&nbsp;</td>
					<td width="60" height="25">&nbsp;</td>
					<td class="fontHead" height="25">
                        <asp:Label ID="lblHeader2" runat="server" ></asp:Label>
						&nbsp;&nbsp; 
                        <asp:Label ID="lblHeader3" runat="server" ></asp:Label>
						<asp:Label id="lblErrorNo" runat="server"></asp:Label>)</td>
				</tr>
				<tr>
					<td width="10" height="25">&nbsp;</td>
					<td width="60" height="25">&nbsp;</td>
					<td class="font" height="25">
                        <asp:Label ID="lblHeader4" runat="server"></asp:Label>
						
					</td>
				</tr>
				<tr>
					<td width="10">&nbsp;</td>
					<td width="60">&nbsp;</td>
					<td>
						<textarea name="ErrorText" cols="50" rows="5" id="TEXTAREA1" runat="server"></textarea>
					</td>
				</tr>
				<tr>
					<td width="10" height="50">&nbsp;</td>
					<td width="60" height="50">&nbsp;</td>
					<td height="50">&nbsp;
						<asp:Button id="Button1" runat="server" ></asp:Button>
						<asp:Label id="lblMessage" runat="server"></asp:Label>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
