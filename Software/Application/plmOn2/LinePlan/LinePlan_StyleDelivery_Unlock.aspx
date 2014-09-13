<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_StyleDelivery_Unlock.aspx.vb" Inherits="plmOnApp.LinePlan_StyleDelivery_Unlock" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">    
    </title>
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnUnlock" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>


    </form>
</body>
</html>
