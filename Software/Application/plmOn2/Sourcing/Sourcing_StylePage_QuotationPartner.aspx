<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_QuotationPartner.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_QuotationPartner" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
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

    <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
             <td>
                <asp:Label ID="lblHeader" runat="server" ></asp:Label>
            </td>
            <td valign="top">
                <cc1:ConfirmedImageButton id="btnSave" runat="server" visible="false" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" visible="false" Message="NONE" OnClientClick="window.close(); return false;"></cc1:ConfirmedImageButton>
            </td>
            <td width="75">
                &nbsp;
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <%--<table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>--%>
    <%--<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td width="100%" valign="top">
                <table height="45">
                    <tr>
                        <td valign="middle">
                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>--%>
    <asp:PlaceHolder ID="plhData" runat="server"></asp:PlaceHolder>  
    <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
        <script type="text/javascript">
            var flag = false; // to prevent child records selecting when parent chain is being selected
            function RowSelected(sender, e) {
                if (flag) return;
                flag = true;
                var parentRow = e.get_tableView().get_parentRow();

                // select parent records
                while (parentRow != null) {
                    var gdi = $find(parentRow.id);
                    gdi.set_selected(true);
                    parentRow = gdi.get_parent().get_parentRow();
                }

                flag = false;

                // select child records
                $.each(e.get_gridDataItem().get_nestedViews(), function (index, view) {
                    view.selectAllItems();
                });                
            }

            function RowDeselected(sender, e) {
                // deselect child records
                $.each(e.get_gridDataItem().get_nestedViews(), function (index, view) {
                    view.clearSelectedItems();
                });
            }
        </script>
    </telerik:RadScriptBlock>  
    </form>
</body>
</html>
