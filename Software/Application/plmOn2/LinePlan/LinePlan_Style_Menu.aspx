<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Style_Menu.aspx.vb" Inherits="plmOnApp.LinePlan_Style_Menu" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title runat="server" id="PageTitle"></title>
    
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" align="left">
						<div><asp:imagebutton id="btnHome" runat="server" ImageUrl="../System/icons/icon_home.gif"></asp:imagebutton>&nbsp;
							<asp:imagebutton id="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:imagebutton></div>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="#ffffff">
				<tr>
					<td align="center"><asp:Label id="lbDevNo" runat="server" Font-Size="Medium"></asp:Label></td>
				</tr>
			</table>
			
			<table class="TableHeaderGreen" height="24" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server"  id="tbLinePlan">
				<tr>
					<td vAlign="middle" align="center" width="10"><asp:imagebutton id="Imagebutton1" runat="server" ImageUrl="../System/icons/icon_paneldown.gif"></asp:imagebutton></td>
					<td class="fontHead">
						<div align="left"><asp:LinkButton runat="server" ID="btnLinePlan" ></asp:LinkButton></div>
					</td>
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
					<td align="center"><asp:label id="lblStyleNo" runat="server" CssClass="fonthead"></asp:label></td>
				</tr>
				<TR>
					<TD align="center"><asp:label id="lblStyleDescription" runat="server" CssClass="fonthead"></asp:label></TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
			</table>
			<asp:literal id="ltVariation" runat="server"></asp:literal>
			<br>
			<asp:Panel ID="pnlTechpack" Runat="server" visible="false" > 
				<TABLE class="TableHeaderOver" id="tbTechPack" height="24" cellSpacing="0" cellPadding="0"
					width="100%" border="0" runat="server">
					<TR>
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD class="fontHead">
							<DIV align="center">
                                <asp:Label ID="lblTechPack" runat="server" ></asp:Label></DIV>
						</TD>
					</TR>
				</TABLE>
				<cc1:ystreeview id="Ystreeview5" runat="server"></cc1:ystreeview>
				<br>
			</asp:Panel>
			
			<asp:Panel runat ="server" ID="pnlQuotation" visible="false"> 
			    <TABLE class="TableHeaderOver" height="24" cellSpacing="0" cellPadding="0" width="100%"
				    border="0">
				    <TR>
					    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					    <TD class="fontHead">
						    <DIV align="center">
                                <asp:Label ID="lblQuotation" runat="server" ></asp:Label></DIV>
					    </TD>
				    </TR>
			    </TABLE>
			    <cc1:ystreeview id="YSTreeView3" runat="server"></cc1:ystreeview>
			    <BR>
			</asp:Panel>
			<asp:Panel runat ="server" ID="pnlSample"  visible="false">
			    <TABLE class="TableHeaderOver" id="Table1" height="24" cellSpacing="0" cellPadding="0"
				    width="100%" border="0">
				    <TR>
					    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					    <TD class="fontHead">
						    <DIV align="center">
                                <asp:Label ID="lblSample" runat="server" ></asp:Label></DIV>
					    </TD>
				    </TR>
			    </TABLE>
			    <cc1:ystreeview id="Ystreeview4" runat="server"></cc1:ystreeview><br>
			    <br>			
			</asp:Panel>

			

    </form>
</body>
</html>
