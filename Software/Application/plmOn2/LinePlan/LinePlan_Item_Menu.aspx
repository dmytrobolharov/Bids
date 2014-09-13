<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Menu.aspx.vb" Inherits="plmOnApp.LinePlan_Item_Menu" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>LinePlan Menu</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>

<body>
    <form id="form1" runat="server">
    
		<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td valign="middle" align="left">
					<div><cc2:bwimagebutton id="btnSizeVar" runat="server" ImageUrl="../System/icons/icon_add1.gif"></cc2:bwimagebutton>
				</td>
			</tr>
		</table>
		<table class="TableHeaderOver" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td valign="middle" align="left">
					<asp:Label ID="lblFin" runat="server" Text="Financial Planning"></asp:Label>
				</td>
			</tr>
		</table>

		<table class="TableHeaderGreen" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td valign="middle" align="left">
					<asp:Label ID="Label1" runat="server" Text="Line Planning"></asp:Label>
				</td>
			</tr>
		</table>
        <cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
        <br/>		
		<table class="TableHeaderOver" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td valign="middle" align="left">
					<asp:Label ID="Label2" runat="server" Text="Line Analysis"></asp:Label>
				</td>
			</tr>
		</table>		
    </form>
</body>
</html>
