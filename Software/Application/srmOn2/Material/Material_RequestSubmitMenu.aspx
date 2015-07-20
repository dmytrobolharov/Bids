<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_RequestSubmitMenu.aspx.vb" Inherits="srmOnApp.Material_RequestSubmitMenu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YstreeView" Assembly="YStreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register assembly="YSTab" namespace="Yunique.WebControls.YSTab" tagprefix="cc3" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head id="Head1" runat="server">
		<title>Material_Menu</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/tree.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" height="27" cellspacing="0" cellpadding="0" width="100%"
				border="0" runat="server">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center"><asp:label id="lblMaterialRequest" runat="server">Material Request</asp:label>&nbsp;</div>
					</td>
				</tr>
			</table>
			<table border="0">
				<tr height="1">
					<td></td>
				</tr>
			</table>
			<cc3:YSTabView ID="YSTabView1" runat="server" />
			<cc1:ystreeview id="YStreeView1" runat="server"></cc1:ystreeview>
            
            <br>
			<table class="TableHeaderOver" height="24" cellspacing="0" cellpadding="0" width="100%"
				border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center"><asp:label id="lblMaterial" runat="server">Material</asp:label></div>
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom1" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom2" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom3" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom4" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom5" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom6" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom7" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom8" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
				<tr>
					<td align="center">
						<asp:Label id="lblMaterialCustom9" runat="server" CssClass="fontHead"></asp:Label></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
