<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_SKUItem_View.aspx.vb" Inherits="plmOnApp.Style.SKU.Style_SKUItem_View" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<!DOCTYPE HTML />
<html>
<head>
    <title>Planning Style Configuration</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../System/Jscript/Custom.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <style type="text/css">
        .search-cell td {
            vertical-align: top !important;
        }
    </style>
</head>
<body>
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
    <div id="fixed" style="position:fixed; top:0; left:0; right:0;">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle" align="left">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td align="left">
                    <cc1:ConfirmedImageButton ID="btnEdit" runat="server" Message="NONE" Visible="True"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" Visible="True" disabled="disabled"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnBatchUpdate" runat="server" Message="NONE" Visible="True" CausesValidation="true" disabled="disabled"></cc1:ConfirmedImageButton>
                    <asp:ImageButton ID="btnInfo" runat="server" OnClientClick="showInfoDialog(); return false;" disabled="disabled" />
                    <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" />
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top:35px;">
        <uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit>
        <uc2:style_header id="Style_Header1" runat="server" StyleID='<%=Request("SID")%>'></uc2:style_header>
        <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
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

        <%--<table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td width="20">
                    <img id="imgBtnBatchExp" onclick="return ShowBatchEditContent(this)" style="cursor: pointer; display: none;" src="../System/Icons/icon_Next.gif" alt="" />
                    <img id="imgBtnBatchCol" onclick="return HideBatchEditContent(this)" style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                </td>
                <td>
                    <asp:Label ID="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"></asp:Label>
                </td>
            </tr>
        </table>
        <table id="BatchTable" runat="server" cellspacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F"
            border="0">
            <tr>
                <td>
                    <asp:PlaceHolder ID="plhEditControlsHolder" runat="server" EnableViewState="False" ClientIDMode="AutoID"></asp:PlaceHolder>
                </td>            
            </tr>
        </table>--%>
        <table class="TableHeaderBlue" height="25" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td>
                    <asp:Label ID="LabelSearch" runat="server" Font-Names="Tahoma,Verdana"></asp:Label>
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
            <tr>
                <td class="search-cell">
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>               
                </td>
                <td width="100%" valign="top">
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
            <asp:PlaceHolder runat="server" ID="plhChangeLogGrid"></asp:PlaceHolder>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        $("select[id$=cboRecordsPerPage] option").filter(function () {
            return $(this).attr("value") > 50;
        }).remove();
    </script>
    <script type="text/javascript">
        $("#RadGridSKUItems :text").each(function (i, elem) {            
            $(elem).keyup(function (e) {
                arrowkeyPressed(this.id, $('#RadGridSKUItems .rgDataDiv .rgMasterTable').attr('id'), e.originalEvent);
            })
        });

        $('#RadGridSKUItems').on('focus', ':text', function () {
            this.select();
        })

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
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript">
        function showInfoDialog() {
            var $infoDialog = $("#divSKUHeader");
            var headerWidth = 0.9*$("#RadGridSKUItems").width();

            $infoDialog.dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                width: headerWidth,
                title: '<%= _WorkflowItemName %>',
                buttons: {}
            });

            $infoDialog.dialog('open');
            return false;
        }
    </script>
</body>
</html>
