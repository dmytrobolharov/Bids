<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_ShareTeamAdd.aspx.vb" Inherits="plmOnApp.Style_ShareTeamAdd" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Add User</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
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
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Share Style With...</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="650" border="0">
				<tr>
					<td colSpan="4">
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="TableHeader">
								<td class="TableHeader" width="10" height="25"></td>
								<td class="TableHeader" width="200"><asp:label id="lblAvailableSize" runat="server" CssClass="fontHead">Available Size</asp:label></td>
								<td class="TableHeader" width="10"></td>
								<td class="TableHeader" width="200"><asp:label id="lblSelectedSize" runat="server" CssClass="fontHead">Selected Size</asp:label>
								</td>
								<td class="TableHeader" width="10"></td>
							</tr>
							<tr>
								<td valign="top" width="10"></td>
								<td align="center" width="200"><asp:listbox id="lstStyleSelect" runat="server" Width="250px" CssClass="fonthead" BorderStyle="Outset"
										SelectionMode="Multiple" Height="100px"></asp:listbox></td>
								<td align="center" width="10"><asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
								</td>
								<td width="200"><asp:listbox id="lstStyleSelected" Width="250px" CssClass="fonthead" SelectionMode="Multiple"
										Height="100px" Runat="server"></asp:listbox></td>
								<td align="center" width="10"><asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnColmovedwn"  Runat="server"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="650" border="0">
				<tr>
					<td colSpan="4">
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="TableHeader">
								<td class="TableHeader" width="10" height="25"></td>
								<td class="TableHeader" width="200"><asp:label id="lblAvailableUsers" runat="server" CssClass="fontHead">Available Users</asp:label></td>
								<td class="TableHeader" width="10"></td>
								<td class="TableHeader" width="200"><asp:label id="lblSelectedUsers" runat="server" CssClass="fontHead">Selected Users</asp:label></td>
								<td class="TableHeader" width="10"></td>
							</tr>
							<tr>
								<td valign="top" width="10"></td>
								<td align="center" width="200"><asp:listbox id="lstUserSelect" runat="server" Width="250px" CssClass="fonthead" BorderStyle="Outset"
										SelectionMode="Multiple" Height="250px"></asp:listbox></td>
								<td align="center" width="10"><asp:imagebutton id="btnaddUserall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnaddUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserAll" runat="server" ></asp:imagebutton><BR>
								</td>
								<td width="200"><asp:listbox id="lstUserSelected" Width="250px" CssClass="fonthead" SelectionMode="Multiple"
										Height="250px" Runat="server"></asp:listbox></td>
								<td align="center" width="10"><asp:imagebutton id="btnColUserMoveup"  Runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnColUserMoveDwn"  Runat="server"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
