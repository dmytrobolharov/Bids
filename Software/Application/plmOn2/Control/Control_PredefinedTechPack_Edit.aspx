<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_PredefinedTechPack_Edit.aspx.vb" Inherits="plmOnApp.Control_PredefinedTechPack_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Control Panel</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td nowrap="nowrap">
                        <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnAdd" runat="server" ></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnDelete" runat="server"  CausesValidation="false"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
                    </td>
                    <td valign="middle" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td valign="middle"><cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton></td>
					<td width="100%">&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
            <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="ReportTechPackPageID">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid>
            <asp:label id="SortOrder" runat="server" Visible="False" Text="ReportPageSort, MapDetail, ReportPageName"></asp:label>
            <asp:hiddenfield id="hdnSortOrder" runat="server"></asp:hiddenfield>
		</form>
	</body>
</HTML>
