<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Commitment_Change_Message.aspx.vb" Inherits="plmOn2Report.Sourcing_Commitment_Change_Message" %>

<%@ Register TagPrefix="uc1" TagName="Sourcing_Header" Src="Sourcing_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title id="PageTitle" runat="server"></title>
		<link href="../System/CSS/mail.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/style.css" type="text/css" rel="stylesheet" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="800" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:Label ID="lblStyleChange" runat="server">Commitment Change Notification</asp:Label>
					</td>
					<td align="right"><img height="35" src="../logo.png"></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="800" border="0">
				<tr>
					<td bgColor="#ffffff"><uc1:Sourcing_Header id="Sourcing_Header1" runat="server"></uc1:Sourcing_Header></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="800" border="0">
				<tr>
					<td bgColor="#ffffff"><br />&nbsp;<img src="../System/Icons/icon_link.gif"><asp:hyperlink id="hlReturn" runat="server" Font-Underline="true" Font-Size="12px" ForeColor="Blue"
							CssClass="fonthead">Click here to view the commitment...</asp:hyperlink><BR />&nbsp;</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="800" border="0">
				<tr>
					<td>
					    <asp:DataGrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				            AutoGenerateColumns="False" DataKeyField="SourcingCommitmentItemChangeID" AllowPaging="false" AllowSorting="false">
				            <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				            <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			            </asp:DataGrid>
						</td>
				</tr>
			</table>
			<br>
		</form>
	</body>
</html>