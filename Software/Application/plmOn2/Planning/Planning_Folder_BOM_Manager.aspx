<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_BOM_Manager.aspx.vb" Inherits="plmOnApp.Planning_Folder_BOM_Manager" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <title>Planning BOM Manager</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../System/Jscript/Custom.js"></script>
    <style type="text/css">
        .search-cell td {
            vertical-align: top !important;
        }
        th a img {
            border:none;
        }
        .multi-bom {
        	background-color: yellow;
        }
        #RadGridBOMItems .rgMasterTable td {
            border-color: #ddd !important;
        }
        .mismatching-bom td {
        	background-color: #faa;
        }
        .line-list-bom {
        	background: #a00 !important;
        }
    </style>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>            
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
    
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle" align="left">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td align="left">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnAutogenerate" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnLineListSync" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnPlanningSync" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" Visible="True" CausesValidation="false"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" Visible="true" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" />
            </td>
        </tr>
    </table>
    
	<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
		height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
		<tr>
			<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
		</tr>
	</table>

    <hc1:Planning_Header ID="PlanningHeader" runat="server" />

    <table cellspacing="0" cellpadding="0" bgcolor="white" border="0">
        <tr>
            <td class="search-cell">
                <asp:PlaceHolder ID="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td valign="top">
                <table>
                    <tr>
                        <td>
                            <asp:ImageButton ID="imgBtnSearch" runat="server" CausesValidation="false"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle" align="left">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td align="left">
                &nbsp;
            </td>
        </tr>
    </table>
    <div style="width: 100%">
        <asp:PlaceHolder runat="server" ID="plhBOMGrid"></asp:PlaceHolder>
    </div>

    <script type="text/javascript">
        function ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("RadGridBOMItems").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridBOMItems', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function ColumnShown(sender, eventArgs) {
            var tableColumns = $find("RadGridBOMItems").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridBOMItems', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');

            // currently it's fixing header aligment when hiding/showing columns
            $find("RadGridBOMItems").get_masterTableView().rebind();
        }        
    </script>
    </form>

    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
    <script type="text/javascript">
         /** Resizing BOMItems Grid to take all the free height on the screen **/
        (function resizeGrid() {

            var changeGrid = $("#RadGridBOMItems");
            var windowHeight = $(window).height();
            var formHeight = $("#form1").height();
            var minHeight = 100;

            // Calculating, how much free space we have on the window for grid area
            var diff = windowHeight - (formHeight - changeGrid.height());

            if (diff > minHeight) {
                changeGrid.height(diff);
            } else {
                changeGrid.height(minHeight);
            }

            $(".rgPagerYPLM [name$='chkThumbnail']").parent().append($("<div style='width:100px; height:1px;'>&nbsp;</div>"));
        })();

        function refreshPage() {
            window.location.href = window.location.href;
        }
    </script>
</body>
</html>
