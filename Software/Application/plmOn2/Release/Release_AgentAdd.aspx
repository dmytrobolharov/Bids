<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Release_AgentAdd.aspx.vb" Inherits="plmOnApp.Release_AgentAdd" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Add Agent</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="0" cellPadding="0" width="650" border="0">
				<TR>
					<TD colSpan="4">
						<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeader">
								<TD class="TableHeader" width="10" height="25"></TD>
								<TD class="TableHeader" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><%#GetSystemText("Available Agent")%></B></FONT></TD>
								<TD class="TableHeader" width="10"></TD>
								<TD class="TableHeader" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead"><%#GetSystemText("Selected Agent")%></B></FONT></TD>
								<TD class="TableHeader" width="10"></TD>
							</TR>
							<TR>
								<TD vAlign="top" width="10"></TD>
								<TD width="200">
									<TABLE cellSpacing="0" cellPadding="0" width="200" border="0">
										<TR>
											<TD><asp:textbox id="txtSearch" runat="server" Width="150px"></asp:textbox></TD>
											<TD><asp:imagebutton id="btnSearch" runat="server"></asp:imagebutton></TD>
											<TD><asp:checkbox id="cbViewAll" runat="server" ForeColor="Red" CssClass="fontHead" Width="75px" Text="Show All"
													AutoPostBack="True" Checked="True"></asp:checkbox></TD>
										</TR>
									</TABLE>
									<asp:listbox id="lstUserSelect" runat="server" Height="250px" SelectionMode="Multiple" BorderStyle="Outset"
										CssClass="fonthead" Width="300px"></asp:listbox></TD>
								<TD align="center" width="10"><asp:imagebutton id="btnaddUserall" runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnaddUserItem" runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserItem" runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnRemoveUserAll" runat="server"></asp:imagebutton><BR>
								</TD>
								<TD width="200"><asp:listbox id="lstUserSelected" Height="270px" SelectionMode="Multiple" CssClass="fonthead"
										Width="300px" Runat="server"></asp:listbox></TD>
								<TD align="center" width="10"><asp:imagebutton id="btnColUserMoveup" Runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnColUserMoveDwn" Runat="server"></asp:imagebutton></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
