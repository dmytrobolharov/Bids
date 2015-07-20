<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Menu.aspx.vb" Inherits="plmOnApp.Sourcing_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr>
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td class="fontHead">
							<DIV align="center"><asp:label id="lblSourcing" runat="server">Sourcing</asp:label></DIV>
						</td>
					</tr>
				</TBODY>
			</table>
			<cc1:ystreeview id="YSTreeView1" runat="server"></cc1:ystreeview><br>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center"><cc2:bwimagebutton id="imgDesign" runat="server"></cc2:bwimagebutton></td>
				</tr>
			</table>
			<br/>
			<br/>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center"><asp:label id="lblStyleNo" runat="server" CssClass="fonthead"></asp:label></td>
				</tr>
				<TR>
					<TD align="center"><asp:label id="lblStyleDescription" runat="server" CssClass="fonthead"></asp:label></TD>
				</TR>
				<TR>
					<TD align="center"><br /><asp:label id="lblSeasonYear" runat="server" CssClass="fonthead"></asp:label></TD>
				</TR>				
			</table>

    </form>
</body>
</html>
