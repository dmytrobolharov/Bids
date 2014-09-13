<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Add_Style.aspx.vb" Inherits="plmOnApp.SampleRequest_Add_Style" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</HEAD>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSaveMaterial" runat="server" Message="NONE"></cc1:confirmedimagebutton></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnGoToStyle" runat="server"></cc1:bwimagebutton></TD>
				</TR>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="800"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" width="300">
						<TABLE class="TableHeader" id="Table2" height="25" cellSpacing="0" cellPadding="0" width="100%"
							border="0" runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD><asp:Label ID="lblStyleImage" runat="server"></asp:Label></TD>
							</TR>
						</TABLE>
						<cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
					<td vAlign="top">
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0"
							runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD><asp:Label ID="lblTechPackH" runat="server"></asp:Label></TD>
							</TR>
						</TABLE>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr class="TableHeaderOver">
								<td width="10" height="23">&nbsp;</td>
								<td width="18">&nbsp;
									<asp:textbox id="txtTechPackID" runat="server" Visible="False" Width="5px"></asp:textbox></td>
								<td width="100"><asp:Label ID="lblTechPackNumH" runat="server"></asp:Label>
								</td>
								<td width="200"><asp:Label ID="lblTechPackNameH" runat="server"></asp:Label></td>
								<td><asp:Label ID="lblLastModified" runat="server"></asp:Label>
								</td>
							</tr>
							<tr class="font" id="TR_TechPack" runat="server">
								<td width="10">&nbsp;</td>
								<td width="18"><asp:image id="imgTechPackStatus" runat="server" ImageUrl="../System/Icons/icon_ball_gray.gif"></asp:image></td>
								<td width="100">&nbsp;
									<asp:label id="lblTechPackNo" runat="server"></asp:label></td>
								<td>&nbsp;
									<asp:label id="lblTechPackName" runat="server"></asp:label></td>
								<td>&nbsp;
									<asp:label id="lblTechPackLastModified" runat="server"></asp:label></td>
							</tr>
							<tr class="fontHead">
								<td></td>
								<td></td>
								<td colSpan="3"><asp:label id="lblTechPackNotFound" runat="server" ForeColor="Red" Height="25px"></asp:label></td>
							</tr>
						</table>
						<TABLE class="TableHeader" id="Table1" height="25" cellSpacing="0" cellPadding="0" width="100%"
							border="0" runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD><asp:Label ID="lblSampleWorkflowH" runat="server"></asp:Label></TD>
							</TR>
						</TABLE>
						<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td width="25" height="35">&nbsp;</td>
								<td class="fontHead">
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td width="25">&nbsp;</td>
								<td vAlign="top"><asp:datagrid id="dgSampleWorkflow" runat="server" ForeColor="Transparent" ShowHeader="False"
										AutoGenerateColumns="False" PageSize="100" GridLines="Horizontal" BorderColor="White" BackColor="White"
										BorderStyle="None" BorderWidth="1px" CellPadding="0">
										<HeaderStyle CssClass="TableHeader"></HeaderStyle>
										<Columns>
											<asp:TemplateColumn>
												<ItemTemplate>
													&nbsp;
													<asp:Label id="lblRadio" runat="server"></asp:Label>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													Sample Workflow
												</HeaderTemplate>
												<ItemTemplate>
													<asp:Label id="lblSampleWorkflow" runat="server" CssClass="font"></asp:Label>
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
										<PagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="White"></PagerStyle>
									</asp:datagrid></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
