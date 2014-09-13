<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Share_Agent_Edit.aspx.vb" Inherits="plmOnApp.Share_Agent_Edit"%>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Share Agent Edit</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">		
		
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<br>
			<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">User</asp:label></TD>
				</TR>
			</TABLE>
			<br>
			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview>
			
			<asp:Panel ID="pnlTechPacks" Runat="server">
				<asp:datagrid id="dgTechPacks" runat="server" EnableViewState="true" PageSize="100" AutoGenerateColumns="False"
					BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px">
					<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
					<ItemStyle CssClass="ItemTemplate"></ItemStyle>
					<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				</asp:datagrid>
			</asp:Panel>
			<asp:Panel ID="pnlQuotes" Runat="server">
				<asp:datagrid id="dgQuotes" runat="server" EnableViewState="true" PageSize="100" AutoGenerateColumns="False"
					BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px">
					<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
					<ItemStyle CssClass="ItemTemplate"></ItemStyle>
					<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				</asp:datagrid>
			</asp:Panel>
			<asp:Panel ID="pnlSamples" Runat="server">
				<asp:datagrid id="dgSamples" runat="server" EnableViewState="true" PageSize="100" AutoGenerateColumns="False"
					BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px">
					<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
					<ItemStyle CssClass="ItemTemplate"></ItemStyle>
					<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				</asp:datagrid>
			</asp:Panel>
		</form>
	</body>
</HTML>
