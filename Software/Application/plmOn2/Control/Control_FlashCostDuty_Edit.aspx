<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_FlashCostDuty_Edit.aspx.vb" Inherits="plmOnApp.Control_FlashCostDuty_Edit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title>Control</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>

        <style type="text/css">
            .RadGrid th.fontHead
            {
            	font-weight: bold;
            }
        </style>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
 
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js">
                </asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js">
                </asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js">
                </asp:ScriptReference>
            </Scripts>
            <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadScriptManager>
                <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
                <StyleSheets>
                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                </StyleSheets>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadStyleSheetManager>
            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />	
            
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false"/>
                    </td>
                    <td>&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>

            <table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>

            <telerik:RadGrid ID="DutyRadGrid" runat="server" EnableEmbeddedSkins="false" AllowMultiRowSelection="false"
                              Width="98%">
                <MasterTableView BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
			            PageSize="100" AutoGenerateColumns="False" DataKeyNames="StyleCategoryID">                
                </MasterTableView>
                <ClientSettings AllowRowsDragDrop="false">
                    <Selecting AllowRowSelect="false" EnableDragToSelectRows="false" />
                    <Scrolling AllowScroll="true" FrozenColumnsCount="1" UseStaticHeaders="true"/>
                </ClientSettings>
            </telerik:RadGrid>

            <telerik:RadScriptBlock runat="server" ID="radScriptManager">
                <script type="text/javascript">
                    var resizableArea = $("#DutyRadGrid .rgDataDiv");
                    var unresizableArea = $("#DutyRadGrid .rgHeaderDiv");

                    var availableHeight = $(window).height() - $("#Form1").height() + resizableArea.height();
                    resizableArea.height(availableHeight);
                </script>
            </telerik:RadScriptBlock>

		</form>
	</body>
</html>
