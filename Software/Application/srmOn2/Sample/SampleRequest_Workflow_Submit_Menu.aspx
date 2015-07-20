<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Menu.aspx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Menu" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Production_Menu</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" height="27" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center"><asp:Label id="lblSample" runat="server" CssClass="fonthead">Sample</asp:Label>
						</div>
					</td>
				</tr>
			</TABLE>
			<cc1:ystreeview id="YSTreeView1" runat="server"></cc1:ystreeview><br>
			<table class="TableHeaderOver" height="24" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center"><asp:label id="lblStyle" runat="server">Style</asp:label>
						</div>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center"><cc2:bwimagebutton id="imgDesign" runat="server"></cc2:bwimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td align="center">
						<asp:Label id="lblStyleNo" runat="server" CssClass="fonthead"></asp:Label></td>
				</tr>
				<TR>
					<TD align="center">
						<asp:Label id="lblStyleDescription" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Label id="lblStyleSize" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
			</table>
		</form>
	</body>
</HTML>
