<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Material_Add_Menu.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_Menu" %>

<%@ Register Assembly="YsTreeView" Namespace="Yunique.WebControls.YsTreeView" TagPrefix="cc3" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Production_Menu</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center">
                            <asp:Label ID="lblMaterialH" runat="server" ></asp:Label></div>
					</td>
				</tr>
			</table>
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
			<BR>
			<table class="TableHeaderOver" height="24" cellSpacing="0" cellpadding="0" width="100%"
				border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center">
                            <asp:Label ID="lblStyle" runat="server" ></asp:Label>
						</div>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td align="center"><cc2:bwimagebutton id="imgDesign" runat="server"></cc2:bwimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td align="center">
						<asp:Label id="lblStyleNo" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblStyleDescription" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td></td>
				</tr>
			</table>
           
		</form>
	</body>
</html>
