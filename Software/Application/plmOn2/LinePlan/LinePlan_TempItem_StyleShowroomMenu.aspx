<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_TempItem_StyleShowroomMenu.aspx.vb" Inherits="plmOnApp.LinePlan_TempItem_StyleShowroomMenu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Showroom</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead" align="center">
						<asp:Label  runat="server" ID="lblHeader" CssClass="fontHead" ></asp:Label>
					</td>
				</tr>
		</table>
	
		<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
		<br />
		<br />
		
		<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="200" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead" align="center" valign="middle">
					    <asp:Label runat="server" ID="lblVendor"  CssClass="fontHead"></asp:Label>
					</td>
				</tr>
		</table>
		
<asp:Label runat="server" ID="lblTradePartner" Font-Names="Tahoma,Verdana" Font-Size="Large" ForeColor="#000000"  Visible="false"></asp:Label>
					     	
	

    </form>
</body>
</html>
