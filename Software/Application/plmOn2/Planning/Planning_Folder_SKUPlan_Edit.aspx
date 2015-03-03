<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_SKUPlan_Edit.aspx.vb" Inherits="plmOnApp.Planning_Folder_SKUPlan_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EDGE" />
    <title>Planning SKU Plan</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../System/Jscript/Custom.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <style type="text/css">
        .search-cell td {
            vertical-align: top !important;
        }
        th a img {
            border:none;
        }
        .multi-sku {
        	background-color: yellow;
        }
        .rgRowYPLM td, .rgAltRowYPLM td {	    	
	    	white-space: normal !important;
	    }
	    
        th.rgHeaderYPLM, th.rgHeader {
            padding: 0 0px !important;
        }	    
        
        #RadGridSKUItems .rgMasterTable td {
            border-color: #ddd !important;
        }
        
        .rgCheck {
        	padding: 2px !important;
        }
    </style> 
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
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
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" Visible="True" OnClientClick="return ConfirmSave(this);"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE" Visible="True" OnClientClick="return ConfirmSave(this);">
                </cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnAutogenerate" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSyncStatus" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnDelete" runat="server" Visible="True"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" Visible="True" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" Visible="true" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" />
            </td>
        </tr>
    </table>
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" style="border-bottom: orange thin solid;
        border-left-style: none; background-color: white">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>

    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td class="fontHead" width="20">
                <div align="center">
                    <asp:Image ID="imgWorkStatus" ImageUrl="../System/Icons/icon_ball_gray.gif" runat="server"></asp:Image></div>
            </td>
            <td class="fontHead" valign="middle">
                <asp:Label ID="lbStatus" runat="server"></asp:Label>
            </td>
            <td class="fontHead" valign="middle" align="center" width="25">
            </td>
        </tr>
    </table>

    <div style="background-color: #fff">
    <table cellspacing="0" cellpadding="0" border="0">
        <tr>
            <asp:PlaceHolder ID="plhEditControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
        </tr>
    </table>
    </div>

    <table class="TableHeader" height="25" width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
        </tr>
    </table>
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
    <div style="width: 100%">
        <asp:PlaceHolder runat="server" ID="plhSKUGrid"></asp:PlaceHolder>
    </div>
    <div id="confirm-message" style="display:none;">
        <%= GetSystemText("You are about to make changes to the SKU Plan.") %>
        <br /><%= GetSystemText("Would you like to keep the Style SKU Pages in sync?")%>
    </div>

    <script type="text/javascript">
        function ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("RadGridSKUItems").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridSKUItems', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function ColumnShown(sender, eventArgs) {
            var tableColumns = $find("RadGridSKUItems").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridSKUItems', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }        
    </script>
    </form>

    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript">
        function ConfirmSave(btn) {
            var hasChanged = false;
            $("input[id*='plhEditControlsHolder_'], select[id*='plhEditControlsHolder_']").each(function () {                
                if ($(this).siblings("[name=" + this.id.replace("plhEditControlsHolder", "fx") + "]").val() != $(this).val()) {
                    hasChanged = true;
                }
            });

            if (hasChanged) {
                $("#confirm-message").dialog({
                    autoOpen: true,
                    modal: true,
                    resizable: false,
                    width: 350,
                    title: '<%= GetSystemText("Keep Style SKU Pages in sync?") %>',
                    buttons: {
                        '<%= GetSystemText("Yes") %>': function () { 
                            if (btn.id == "btnSave") {
                                <%= ClientScript.GetPostBackEventReference(btnSave, "1") %>;
                            } else {
                                <%= ClientScript.GetPostBackEventReference(btnSaveClose, "1") %>;
                            }
                        },
                        '<%= GetSystemText("No") %>': function () {
                            if (btn.id == "btnSave") {
                                <%= ClientScript.GetPostBackEventReference(btnSave, "0") %>;
                            } else {
                                <%= ClientScript.GetPostBackEventReference(btnSaveClose, "0") %>;
                            }
                        }
                    }
                });
            }

            return !hasChanged;
        }

         /** Resizing SKUItems Grid to take all the free height on the screen **/
        (function resizeGrid() {

            var changeGrid = $("#RadGridSKUItems");
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

            var totalWidth = 0;
            $(".rgDataDiv col").each(function(){
                totalWidth += parseInt($(this).css("width"), 10);
            });
            $("#RadGridSKUItems").width(Math.min($(window).width(), totalWidth + 20));
            $(".rgPagerYPLM td:nth-child(2)").append("<div style='width:100px'>")
        })();        
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
