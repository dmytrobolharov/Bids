<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Override_Custom_SPX_Edit.aspx.vb" Inherits="YuniFace.Control_Override_Custom_SPX_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Custom Stored Procedure</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
		<meta name="vs_defaultClientScript" content="JavaScript" />
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
		<link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="btnSave" >
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
                </Scripts>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadScriptManager>
            <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
                <StyleSheets>
                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                </StyleSheets>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadStyleSheetManager>
            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" >
            </telerik:RadAjaxManager>

	        <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
					<td valign="top">
						<cc1:confirmedimagebutton id="btnSave" runat="server" ImageUrl="" Message="NONE" EnableViewState="False" />
						<cc1:confirmedimagebutton id="btnDel" runat="server" ImageUrl="" Message="NONE" EnableViewState="False" CausesValidation="false" />
						<cc1:confirmedimagebutton id="btnClose" runat="server" ImageUrl="" Message="NONE" EnableViewState="False" CausesValidation="false" />
                    </td>
					<td width="75">&nbsp;</td>
					<td align="right"></td>
				</tr>
			</table>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>

		    <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td height='25' class='fonthead' nowrap>
					    <asp:label id="lblStoredProcedureName" runat="server">Stored Procedure Name</asp:label>
					</td>
					<td width='10px' class='font'>
						&nbsp;
					</td>
					<td width='100%' class='font'>
                        <telerik:RadComboBox ID="cboStoredProcedureName" runat="server" Width="400px" Height="150px"
                            EmptyMessage="" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                            EnableVirtualScrolling="true" OnItemsRequested="cboStoredProcedureName_ItemsRequested"
                            AllowCustomText="true"   MarkFirstMatch="true" 
                            EnableEmbeddedSkins="false" Skin="YPLM"
                            AutoPostBack="false">
                        </telerik:RadComboBox>
					</td>
				</tr>
			</table>
			<br />
			<br />

			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
                <tr>
                    <td>
                        <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                    </td>
                </tr>
                <tr>
                    <td width="100%" valign="top">
                        <asp:TextBox ID="txtSPX" runat="server" Height="600" TextMode="MultiLine" 
                                     Width="100%" Wrap="False" Font-Size="Smaller"></asp:TextBox>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
