<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LineAttributeMenu.aspx.vb" Inherits="plmOnApp.LineAttributeMenu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>LinePlan Menu</title>
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
		<br>
		<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	
		<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
    </form>
</body>
</html>




