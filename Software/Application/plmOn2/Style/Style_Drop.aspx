<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Drop.aspx.vb" Inherits="plmOnApp.Style_Drop"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<TITLE id="htmlHeader" runat =server ></TITLE>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
				<tr>
					<td width="10"></td>
					<td width="50" height="50"><IMG src="../System/Icons/icon_critical32.gif"></td>
					<td>
						<asp:Label id="lblHeader" runat="server" CssClass="fontHead">You are about to drop this style</asp:Label></td>
				</tr>
			</table>
			<HR>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td width="50"></td>
					<td>
						<asp:Label id="lblWarning" runat="server" CssClass="font"></asp:Label>
						<asp:DropDownList id="ddlSize" runat="server"></asp:DropDownList></td>
					<td></td>
				</tr>
				<tr>
					<td width="50"></td>
					<td>
						<asp:Label id="lblMessage" runat="server" CssClass="font"></asp:Label></td>
					<td></td>
				</tr>
				<tr>
					<td width="50"></td>
					<td>&nbsp;</td>
					<td></td>
				</tr>
				<tr>
					<td width="50"></td>
					<td>
						<cc1:confirmedimagebutton id="btnDelete" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="ntnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
		</form>
	</body>
</html>
