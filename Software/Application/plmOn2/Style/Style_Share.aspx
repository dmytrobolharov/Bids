<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Share.aspx.vb" Inherits="plmOnApp.Style_Share"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="5" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="300">
						<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr valign="middle">
								<td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="FontHead">&nbsp;
									<asp:Label id="lblTeam" runat="server">Team</asp:Label></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<asp:DataGrid id="dgTeam" runat="server"></asp:DataGrid></td>
					<td valign="top"><table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr valign="middle">
								<td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="FontHead">&nbsp;
									<asp:Label id="lblTradePartner" runat="server">Trade Partner</asp:Label></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<asp:DataGrid id="dgTradePartner" runat="server"></asp:DataGrid></td>
				</tr>
			</table>
		</form>
	</body>
</html>
