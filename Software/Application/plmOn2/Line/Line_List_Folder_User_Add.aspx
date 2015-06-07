<%@ Register TagPrefix="uc1" TagName="Line_List_Folder_Header" Src="Line_List_Folder_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_User_Add.aspx.vb" Inherits="plmOnApp.Line_List_Folder_User_Add" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Add User</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="Confirmedimagebutton1" runat="server" 
								Message="Are you sure you want to close it?"></cc1:confirmedimagebutton></TD>
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
			<uc1:Line_List_Folder_Header id="Line_List_Folder_Header1" runat="server" DESIGNTIMEDRAGDROP="575"></uc1:Line_List_Folder_Header>
			<BR>
			<TABLE cellSpacing="0" cellPadding="0" width="800" border="0">
				<TR>
					<TD colSpan="4">
						<TABLE width="100%" align="center">
							<TR>
								<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								    <asp:dropdownlist id="drlUserType" runat="server" CssClass="fontHead" Width="250px" AutoPostBack="True">												
									</asp:dropdownlist></B></FONT></TD>
								<TD width="10%"></TD>
								<TD align="center" width="40%"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">Selected 
											Recipients </B></FONT>
								</TD>
								<TD width="10%"></TD>
							</TR>
							<TR>
								<TD align="center" width="40%"><asp:listbox id="lstSelect" runat="server" CssClass="fonthead" Width="250px" Height="250px" SelectionMode="Multiple"
										BorderStyle="Outset"></asp:listbox></TD>
								<TD align="center" width="10%"><asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
									<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
								</TD>
								<TD align="center" width="40%"><asp:listbox id="lstSelected" CssClass="fonthead" Width="250px" Height="250px" SelectionMode="Multiple"
										Runat="server"></asp:listbox></TD>
								<TD align="center" width="10%"><asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton><BR>
									<asp:imagebutton id="btnColmovedwn"  Runat="server"></asp:imagebutton></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
