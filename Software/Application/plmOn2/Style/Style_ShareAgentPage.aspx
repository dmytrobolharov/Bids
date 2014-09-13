<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_ShareAgentPage.aspx.vb" Inherits="plmOnApp.Style_ShareAgentPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Add Agent</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnAgentRemove" runat="server" 
								></cc1:confirmedimagebutton>
								<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblPageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Agent</asp:label>&nbsp;</td>
				</tr>
			</table>
			<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header><br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td colSpan="4">
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="TableHeader">
								<td class="TableHeader" width="10" height="25"></td>
								<td class="TableHeader" width="200"><asp:label id="lblAvailable" runat="server" CssClass="fontHead">Available</asp:label></td>
								<td class="TableHeader" width="10"></td>
								<td class="TableHeader" width="200"><asp:label id="lblShared" runat="server" CssClass="fontHead">Shared</asp:label></td>
								<td class="TableHeader" width="10"></td>
							</tr>
							<tr>
								<td valign="top" width="10"></td>
								<td align="center" width="100"><asp:listbox id="lstUserSelect" runat="server" Width="300px" CssClass="fonthead" BorderStyle="Outset"
										SelectionMode="Multiple" Height="450px"></asp:listbox></td>
								<td align="center" width="10">
								    <asp:imagebutton id="btnaddUserall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnaddUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserAll" runat="server" ></asp:imagebutton><BR>
								</td>
								<td width="100"><asp:listbox id="lstUserSelected" Width="300px" CssClass="fonthead" SelectionMode="Multiple"
										Height="450px" Runat="server"></asp:listbox></td>
								<td align="center" width="100%"><BR>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
