<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_Menu.aspx.vb" Inherits="plmOnApp.Body_Menu" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Body Menu</title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" align="left">
						<div><asp:imagebutton id="btnHome" runat="server" ImageUrl="../System/icons/icon_home.gif"></asp:imagebutton>&nbsp;
							<cc2:bwimagebutton id="btnSizeVar" runat="server" ImageUrl="../System/icons/icon_add1.gif"></cc2:bwimagebutton>&nbsp;
							<asp:imagebutton id="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif"></asp:imagebutton>&nbsp;
							<asp:imagebutton id="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:imagebutton></div>
					</td>
				</tr>
			</table>

			<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="#ffffff">
				<tr>
					<td align="center"><asp:Label id="lbDevNo" runat="server" Font-Size="Medium"></asp:Label></td>
				</tr>
			</table>


            <cc1:ystreeview id="YSTreeView2" runat="server"></cc1:ystreeview><br>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center"><cc2:bwimagebutton id="imgDesign" runat="server"></cc2:bwimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center"><asp:label id="lblBodyNo" runat="server" CssClass="fonthead"></asp:label></td>
				</tr>
				<TR>
					<TD align="center"><asp:label id="lblBodyDescription" runat="server" CssClass="fonthead"></asp:label></TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
			</table>

    </form>
</body>
</html>
