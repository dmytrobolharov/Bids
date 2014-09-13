<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_ShareAdd.aspx.vb" Inherits="plmOnApp.Style_ShareAdd" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Add User</title>	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table height="10" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Share Style With...</asp:label></td>
				</tr>
			</table>
			<BR>
			<table cellSpacing="0" cellpadding="0" width="750" border="0">
				<tr>
					<td colSpan="4">
						<table width="100%" align="center">
							<tr>
								<td class="fontHead" align="center" width="10"></td>
								<td class="fontHead" width="100">&nbsp;<asp:label id="lblSelectSize" runat="server" CssClass="fontHead">Select Size</asp:label></td>
								<td align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:dropdownlist id="drlUserType" runat="server" CssClass="fontHead" Width="250px" AutoPostBack="True">
												<asp:ListItem Value="0">Team</asp:ListItem>
												<asp:ListItem Value="1">Trade Partner</asp:ListItem>
											</asp:dropdownlist></B></FONT></td>
								<td width="10"></td>
								<td align="center" width="200"><asp:label id="lblSelectedUsers" runat="server" CssClass="fontHead">Selected&nbsp;Users</asp:label></td>
								<td width="10"></td>
							</tr>
							<tr>
								<td valign="top" width="10"></td>
								<td valign="top" width="125">
									<asp:listbox id="lslStyleSize" runat="server" Width="250px" CssClass="fonthead" BorderStyle="Outset"
										SelectionMode="Multiple" Height="250px"></asp:listbox></td>
								<td align="center" width="200"><asp:listbox id="lstSelect" runat="server" CssClass="fonthead" Width="250px" Height="250px" SelectionMode="Multiple"
										BorderStyle="Outset"></asp:listbox></td>
								<td align="center" width="10"><asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
								</td>
								<td width="200"><asp:listbox id="lstSelected" CssClass="fonthead" Width="250px" Height="250px" SelectionMode="Multiple"
										Runat="server"></asp:listbox></td>
								<td align="center" width="10"><asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnColmovedwn"  Runat="server"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
