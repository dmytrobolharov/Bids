<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_SKUPlan.aspx.vb" Inherits="plmOnApp.Planning_Folder_SKUPlan" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Planning Style Configuration</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/toastr.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../System/Jscript/Custom.js"></script>
    <style type="text/css">
        .search-cell td {
            vertical-align: top !important;
        }
        th a img {
            border:none;
        }
    </style>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
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
    <div id="fixed" style="position: fixed; top: 0; left: 0; right: 0;">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle" align="left">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td align="left">
                    <cc1:ConfirmedImageButton ID="btnStart" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                    <asp:Panel runat="server" ID="pnlEditButtons">
                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>                        
                        <cc1:ConfirmedImageButton ID="btnBatchUpdate" runat="server" Message="NONE" Visible="True" CausesValidation="false">
                        </cc1:ConfirmedImageButton> 
                        <asp:ImageButton ID="btnInfo" runat="server" OnClientClick="showInfoDialog(); return false;" disabled="disabled" />                       
                        <cc1:BWImageButton ID="btnChangeLog" runat="server" Visible="true" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" />
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 35px;">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" style="border-bottom: orange thin solid;
            border-left-style: none; background-color: white">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <!-- For 'Info' button's sake -->
        <div id="divSKUHeader" style="display: none">
            <table id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
                <tr>
                    <td>
                        <asp:PlaceHolder ID="plhHeaderControl" runat="server"></asp:PlaceHolder>
                    </td>
                </tr>
            </table>
        </div>
        <asp:Panel runat="server" ID="pnlSKU">
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
                        <asp:LinkButton ID="lbStatus" runat="server"></asp:LinkButton>
                    </td>
                    <td class="fontHead" valign="middle" align="center" width="25">
                    </td>
                </tr>
            </table>
            <asp:Panel ID="pnlBatchEdit" runat="server">
                <table id="BatchTableHeader" class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" runat="server">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                        </td>
                        <td width="20">
                            <img id="imgBtnBatchExp" onclick="return ShowBatchEditContent(this)" style="cursor: pointer; display: none;"
                                src="../System/Icons/icon_Next.gif" alt="" />
                            <img id="imgBtnBatchCol" onclick="return HideBatchEditContent(this)" style="cursor: pointer" src="../System/Icons/icon_Down.gif"
                                alt="" />
                        </td>
                        <td>
                            <asp:Label ID="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table id="BatchTable" cellspacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F" border="0">
                    <tr>
                        <asp:PlaceHolder ID="plhEditControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                    </tr>
                </table>
            </asp:Panel>
            <table id="CompareContentHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <tr class="TableHeader">
		            <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="20">
		                <img id="imgBtnExp_CompareContent" onclick="return ShowCompareContent(this)" style="cursor:pointer;" src="../System/Icons/icon_Next.gif" />
		                <img id="imgBtnCol_CompareContent" onclick="return HideCompareContent(this)" style="cursor:pointer;" src="../System/Icons/icon_Down.gif" />
		            </td>
		            <td class="fontHead">
			            <asp:label id="lblCostingSummary" Text="Compare" runat="server"></asp:label>
		            </td>
	            </tr>
            </table>
            <div id="divCompareContent" style="display:block" width="100%">
                <asp:UpdatePanel runat="server" ID="upCompare">
                    <ContentTemplate>
                        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
			                <tr vAlign="top">
				                <td>
					                <asp:DataGrid id="dgCompare" runat="server" AllowSorting="false">
						                <AlternatingItemStyle Height="20px" CssClass="ItemTemplate"></AlternatingItemStyle>
						                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							            <PagerStyle Visible="False"></PagerStyle>
					                </asp:DataGrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			                    </td>
			                </tr>
		                </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <table class="TableHeaderBlue" height="25" width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                    </td>
                    <td>
                        <asp:Label ID="LabelSearch" runat="server" Font-Names="Tahoma,Verdana"></asp:Label>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" bgcolor="white" border="0">
                <tr>
                    <td class="search-cell">
                        <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
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
        </asp:Panel>
    </div>
    <script type="text/javascript">
        $("select[id$=cboRecordsPerPage] option").filter(function () {
            return $(this).attr("value") > 50;
        }).remove();
    </script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/toastr.min.js"></script>
    <script type="text/javascript" language="javascript">
        toastr.options = {
            "closeButton": true,
            "debug": false,
            "positionClass": "toast-bottom-right",
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "0",
            "extendedTimeOut": "0",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        }
    </script>

    </form>
    <script type="text/javascript">
        $("#RadGridSKUItems :text").each(function (i, elem) {
            $(elem).keyup(function (e) {
                arrowkeyPressed(this.id, $('#RadGridSKUItems .rgDataDiv .rgMasterTable').attr('id'), e.originalEvent);
            })
        });

        $('#RadGridSKUItems').on('focus', ':text', function () {
            //this.select();
        });

        var styleId, focusedControlId;
        $('#RadGridSKUItems').on('click', ':text', function () {
            var newStyleId = $find($("#" + this.id).closest("tr").attr('id')).getDataKeyValue("StyleID");
            if (styleId != newStyleId) {
                styleId = newStyleId
                UpdateCompareGrid(styleId);
                focusedControlId = this.id;
            }
            this.select();
        });

        try {
            function ShowBatchEditContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnBatchCol').style.display = 'block';
                document.getElementById('BatchTable').style.display = 'block';
                return false;
            }

            function HideBatchEditContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnBatchExp').style.display = 'block';
                document.getElementById('BatchTable').style.display = 'none';
                return false;
            }
        } catch (e) { }

        try {
            function ShowCompareContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnCol_CompareContent').style.display = 'block';
                document.getElementById('divCompareContent').style.display = 'block';
                return false;
            }

            function HideCompareContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnExp_CompareContent').style.display = 'block';
                document.getElementById('divCompareContent').style.display = 'none';
                return false;
            }
        } catch (e) { }

        /** Resizing SKUItems Grid to take all the free height on the screen **/
        (function resizeGrid() {

            var changeGrid = $("#RadGridSKUItems");
            var windowHeight = $(window).height();
            var formHeight = $("#Form1").height();
            var minHeight = 100;

            // Calculating, how much free space we have on the window for grid area
            var diff = windowHeight - (formHeight - changeGrid.height());

            if (diff > minHeight) {
                changeGrid.height(diff);
            } else {
                changeGrid.height(minHeight);
            }
        })();

        $(document).ready(function () {
            jQuery.fn.extend({
                disable: function (state) {
                    return this.each(function () {
                        if (this) {
                            this.disabled = state;
                        }
                    });
                }
            });

            $("#RadGridSKUItems_GridHeader .rgMasterTable th").css("white-space", "");
            $("#toolbar input").disable(false);
        });       
    </script>

    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
    <script type="text/javascript">
        function showInfoDialog() {
            var $infoDialog = $("#divSKUHeader");                               

            $infoDialog.dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                width: 500,
                title: "<%= strSKUHeaderName %>",
                buttons: {}
            });

            $infoDialog.dialog('open');
            return false;
        }

        function ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("RadGridSKUItems").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridSKUItems', '<%= aspxPageName & "?PLID=" & _PlanningID %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
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
            PageMethods.SaveHiddenColumns('RadGridSKUItems', '<%= aspxPageName & "?PLID=" & _PlanningID %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function UpdateCompareGrid(styleId) {
            __doPostBack('<%= upCompare.ID %>', 'STYLE__' + styleId);
        }

        Sys.Application.add_load(function () {
            $find('RadGridSKUItems').get_masterTableView().get_dataItems();
            if (focusedControlId != null) {
                setTimeout(function () { $("#" + focusedControlId).focus(); }, 1);
            }
        });

    </script>
</body>
</html>
