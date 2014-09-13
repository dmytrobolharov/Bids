<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TechPack_AgentAdd_BatchQueue.aspx.vb" Inherits="plmOnApp.TechPack_AgentAdd_BatchQueue" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">

<html>
	<head>
		<title runat="server" id="PageTitle">Share Tech Pack</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>

	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tbody>
					<tr vAlign="middle">
						<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td vAlign="middle" align="left" width="400">
						    <cc1:confirmedimagebutton id="btnPrevious" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						    <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						</td>
					</tr>
				</tbody>
			</table>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Share Tech Pack...</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="650" border="0">
				<tr>
					<td colSpan="4">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr class="TableHeader">
								<td class="TableHeader" width="10" height="25"></td>
								<td class="TableHeader" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								    <asp:Label ID="lblAvailable" runat="server" Text="Available Agent"></asp:Label></B></FONT></td>
								<td class="TableHeader" width="10"></td>
								<td class="TableHeader" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><asp:Label 
                                        ID="lblSelected" runat="server" Text="Selected Agent"></asp:Label>&nbsp;</B></FONT></td>
								<td class="TableHeader" width="10"></td>
							</tr>
							<tr>
								<td vAlign="top" width="10"></td>
								<td width="200">
									<table cellSpacing="0" cellPadding="0" width="200" border="0">
										<tr>
											<td><asp:textbox id="txtSearch" runat="server" Width="150px"></asp:textbox></td>
											<td><asp:imagebutton id="btnSearch" runat="server" ></asp:imagebutton></td>
											<td><asp:checkbox id="cbViewAll" runat="server" ForeColor="Red" CssClass="fontHead" Width="75px" Text="Show All"
													AutoPostBack="True" Checked="True"></asp:checkbox></td>
										</tr>
									</table>
									<asp:listbox id="lstUserSelect" runat="server" Height="250px" SelectionMode="Multiple" BorderStyle="Outset"
										CssClass="fonthead" Width="300px"></asp:listbox></TD>
								<td align="center" width="10">
								    <asp:imagebutton id="btnaddUserall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnaddUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserItem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserAll" runat="server" ></asp:imagebutton><BR>
								</td>
								<td width="200"><asp:listbox id="lstUserSelected" Height="270px" SelectionMode="Multiple" CssClass="fonthead"
										Width="300px" Runat="server"></asp:listbox></td>
								<td align="center" width="10">
								    <asp:imagebutton id="btnColUserMoveup"  Runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnColUserMoveDwn"  Runat="server"></asp:imagebutton>
							    </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
