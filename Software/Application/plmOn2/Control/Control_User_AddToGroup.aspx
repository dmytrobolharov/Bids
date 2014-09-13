<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_User_AddToGroup.aspx.vb" Inherits="plmOnApp.Control_User_AddToGroup" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Control_User_AddToGroup</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
                        <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
                    </TD>
				</TR>
			</TABLE>
			<asp:datagrid id="dgGroups" runat="server" AutoGenerateColumns="False" PageSize="100" EnableViewState="true"
				BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0" DataKeyField="GroupID">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<ItemStyle Width="20px"></ItemStyle>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1"></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox ID="chkAddGroup" Runat="server"></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<ItemStyle Width="200px"></ItemStyle>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="Label2"><%#GetSystemText("GroupName")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label runat="server" ID="lblGroupName"><%#GetSystemText("GroupName")%></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
	</body>
</HTML>
