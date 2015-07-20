<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Report_Menu.aspx.vb" Inherits="YuniqueBI.Report_Menu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Report Menu</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeaderBlue" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR>
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD class="fontHead">
							<DIV align="center"><asp:label id="lblHeader" runat="server" CssClass="fontHead">Reporting</asp:label>&nbsp;
							</DIV>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" align="left">
						<div><asp:imagebutton id="btnHome" runat="server" ImageUrl="../System/icons/icon_home.gif"></asp:imagebutton>
                            &nbsp;
							<asp:imagebutton id="btnDash" runat="server" ImageUrl="../System/icons/icon_dash.gif"></asp:imagebutton>
                            &nbsp;
							<asp:imagebutton id="btnReport" runat="server" ImageUrl="../System/icons/icon_filegrid.gif"></asp:imagebutton>
                            &nbsp;
							<asp:imagebutton id="btnSetting" runat="server" ImageUrl="../System/icons/icon_tool.gif"></asp:imagebutton></div>
					</td>
				</tr>
			</table>					
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
		</form>
	</body>
</HTML>
