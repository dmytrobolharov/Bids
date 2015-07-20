<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DashMenu.aspx.vb" Inherits="plmOnDashboard.DashMenu" %>
<%@ Register Assembly="YstreeView" Namespace="Yunique.WebControls.YstreeView" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<LINK href="./System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="./System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <title>Menu</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
 			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tbody>
					<tr>
						<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td class="fontHead">
							<DIV align="center">Dashboard&nbsp;
							</DIV>
						</td>
					</tr>
				</tbody>
			</table>
			<cc1:YStreeView id="YStreeView1" runat="server"></cc1:YStreeView>   
    </div>
    </form>
</body>
</html>
