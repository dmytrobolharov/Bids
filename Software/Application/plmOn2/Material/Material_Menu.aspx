<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Menu.aspx.vb" Inherits="plmOnApp.Material_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Production_Menu</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="left"><asp:imagebutton id="btnHome" runat="server" ImageUrl="../System/icons/icon_home.gif"></asp:imagebutton>&nbsp;
							<asp:imagebutton id="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif"></asp:imagebutton>&nbsp;
							<asp:imagebutton id="btnTradePartner" runat="server" ImageUrl="../System/icons/icon_trade.gif" Visible="False"></asp:imagebutton></div>
					</td>
				</tr>
			</table>
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
			<BR>
			<table class="TableHeaderOver" height="24" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center"><asp:Label ID="lblDetail" runat="server" Text="Detail"></asp:Label></div>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center"><cc2:bwimagebutton id="imgDesign" runat="server"></cc2:bwimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialNo" runat="server" CssClass="fonthead"></asp:Label></td>
				</tr>
				<TR>
					<TD align="center">
						<asp:Label id="lblMaterialDescription" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
			</table>
		</form>
	</body>
</HTML>
