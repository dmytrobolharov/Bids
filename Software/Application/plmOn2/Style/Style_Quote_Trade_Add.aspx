<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_Trade_Add.aspx.vb" Inherits="plmOnApp.Style.Quote.Style_Quote_Trade_Add" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Add User</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body onblur="this.focus();" onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="Confirmedimagebutton1" runat="server" Message="NONE"
								></cc1:confirmedimagebutton></td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td colSpan="4">
						<table width="100%" align="center">
							<tr>
								<td align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblAvl" runat="server" Text="Available"></asp:Label></B></FONT></td>
								<td width="10%"></td>
								<td align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label ID="lblSel" runat="server" Text="Selected"></asp:Label>
										</B></FONT>
								</td>
								<td width="10%"></td>
							</tr>
							<tr>
								<td align="center" width="40%"><asp:listbox id="lstSelect" runat="server" BorderStyle="Outset" SelectionMode="Multiple" Height="400px"
										Width="250px" CssClass="fonthead"></asp:listbox></td>
								<td align="center" width="10%"><asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
								</td>
								<td align="center" width="40%">
									<asp:ListBox id="lstSelected" Width="250px" Height="400px" SelectionMode="Multiple" Runat="server"
										CssClass="fonthead"></asp:ListBox></td>
								<td align="center" width="10%">
									<asp:imagebutton id="btnColmoveup" Runat="server"  /><BR>
									<asp:imagebutton id="btnColmovedwn" Runat="server"  />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
