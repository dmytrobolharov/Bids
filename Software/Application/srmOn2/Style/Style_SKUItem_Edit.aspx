<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_SKUItem_Edit.aspx.vb" Inherits="srmOnApp.Style_SKUItem_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Style SKU</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../System/Jscript/Custom.js"></script>
    <style type="text/css">
        .search-cell td {
            vertical-align: top !important;
        }
        
        .rgRowYPLM td, .rgAltRowYPLM td, .rgFooter td {
        	border-color: #ddd;
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
    <div id="fixed" style="position: fixed; top: 0; left: 0; right: 0;">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle" align="left">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td align="left">                    
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Visible="true" Message="NONE" CausesValidation="false">
                    </cc1:ConfirmedImageButton>                    
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
        <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr class="TableHeader">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td width="20">
                    <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor: pointer" src="../System/Icons/icon_Next.gif"
                        alt="" />
                    <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor: pointer" src="../System/Icons/icon_Down.gif"
                        alt="" />
                </td>
                <td class="fontHead">
                    <asp:Label ID="lblHeaderDetail" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <div id="divHeaderContent" style="display: block">
            <table id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
                <tr>
                    <asp:PlaceHolder ID="plhHeaderControl" runat="server"></asp:PlaceHolder>                    
                </tr>
            </table>
        </div>
        <br />
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
        $("#RadGridSKUItems :text").each(function (i, elem) {
            $(elem).keyup(function (e) {
                arrowkeyPressed(this.id, $('#RadGridSKUItems .rgDataDiv .rgMasterTable').attr('id'), e.originalEvent);
            })
        });

        $('#RadGridSKUItems').on('focus', ':text', function () {
            this.select();
        })

        try {
            document.getElementById('imgBtnExp').style.display = 'none';
            function ShowHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnCol').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'block';
                return false;
            }

            function HideHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnExp').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'none';
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
            $("#RadGridSKUItems_GridHeader .rgMasterTable th").css("white-space", "");
        });
    </script>
</body>
</html>