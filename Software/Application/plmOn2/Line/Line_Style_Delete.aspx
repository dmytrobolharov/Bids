<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_Style_Delete.aspx.vb" Inherits="plmOnApp.Line_Style_Delete"%>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<TITLE id="htmlHeader" runat=server ></TITLE>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
				<tr>
					<td width="10"></td>
					<td width="50" height="50"><IMG src="../System/Icons/icon_warning_32.gif"></td>
					<td>
						<asp:Label id="lblHeader" runat="server" CssClass="fontHead">Style(s) deleting information:</asp:Label></td>
				</tr>
			</table>
			<HR>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td width="50"></td>
					<td><asp:Label id="lblWarning" runat="server" CssClass="font"></asp:Label></td>
					<td width="50"></td>
				</tr>
				<tr>
					<td width="50"></td>
					<td>&nbsp;</td>
					<td width="50"></td>
				</tr>
				<tr>
					<td width="50"></td>
					<td align="center">
				    	<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td width="50"></td>
				</tr>
			</table>
		</form>
        <script language="javascript">document.getElementById('lblWarning').innerHTML = window.opener.strMsg;</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
