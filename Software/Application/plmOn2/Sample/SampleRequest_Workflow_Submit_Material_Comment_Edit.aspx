<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Material_Comment_Edit.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Material_Comment_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton></TD>
					<td width="150"><asp:checkbox id="cbAutoFitComment" runat="server" AutoPostBack="True" ></asp:checkbox></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<asp:textbox id="txtFitComment" runat="server" TextMode="MultiLine" MaxLength="4000" Width="790px"
				Height="550px"></asp:textbox></form>
	</body>
</HTML>
