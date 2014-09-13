<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Quote_Grid.aspx.vb" Inherits="plmOnApp.Quote_Grid" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Quotation</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Quote Folder...</asp:Label></td>
                </tr>
                <tr class="TableHeader">
                    <td><cc1:confirmedimagebutton id="btnSaveSearch" runat="server" Message="NONE" AutoPostBack="TRUE" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"><asp:PlaceHolder id="plhControlsHolder" runat="server"></asp:PlaceHolder>						
					</td>
				</tr>
			</table>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
								<td width="100%"><asp:imagebutton id="imgBtnSearch" runat="server" /></td>
							</tr>
						</table>

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
                        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

                        <asp:PlaceHolder ID="plhRadGridPlaceholder" runat="server"></asp:PlaceHolder>
                        
                        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</form>
	</body>
</HTML>
