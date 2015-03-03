<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_Schedule.aspx.vb" Inherits="plmOnApp.Sourcing_Page_Schedule" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
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

     <wc1:Color_Wait ID="Color_Wait" runat="server" />
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td valign="top">
                <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click();"></cc1:confirmedimagebutton>
            </td>
            <td width="75">
                &nbsp;
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <table height="10" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee" border="0">
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr bgcolor="White">            
            <td>
                <asp:PlaceHolder ID="plhSourcingHeader" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnSelectedStyleTypes" runat="server" />
    <asp:HiddenField ID="hdnSelectedStyleCategories" runat="server" />
    </form>
        <script language="javascript" type="text/javascript">

            function GetSelectedStyleTypes() {
                var comboItems = $find('<%= dclStyleType.ClientID %>').get_items();
                var hdnSelectedStyleTypes = $("#hdnSelectedStyleTypes");

                var oldSelectedStyleTypes = $(hdnSelectedStyleTypes).val(); 
                var strSelectedStyleTypes = ""

                for (var i = 0; i < comboItems.get_count(); i++) {
                    if (comboItems.getItem(i).get_checked()) {

                        if (strSelectedStyleTypes != "") {
                            strSelectedStyleTypes += ",";
                        }
                        strSelectedStyleTypes += comboItems.getItem(i).get_value();
                    }
                }
                $(hdnSelectedStyleTypes).val(strSelectedStyleTypes);
                return (strSelectedStyleTypes != oldSelectedStyleTypes)
            }

            function OnStyleTypesLoad(sender, eventArgs) {
                GetSelectedStyleTypes();    
            }

            function OnStyleTypesSelectionChanged(sender, eventArgs) {
                var doRefresh = GetSelectedStyleTypes();
                if (doRefresh) {
                    <%= ClientScript.GetPostBackEventReference(New PostBackOptions(dclStyleType) With {.PerformValidation = False}) %>;
                }
            }

                    
            function GetSelectedStyleCategories(sender, eventArgs) {
                var comboItems = $find('<%= dclStyleCategory.ClientID %>').get_items();
                var hdnSelectedStyleCategories = $("#hdnSelectedStyleCategories");

                var strSelectedStyleCategories = ""

                for (var i = 0; i < comboItems.get_count(); i++) {
                    if (comboItems.getItem(i).get_checked()) {

                        if (strSelectedStyleCategories != "") {
                            strSelectedStyleCategories += ",";
                        }
                        strSelectedStyleCategories += comboItems.getItem(i).get_value();
                    }
                }
                $(hdnSelectedStyleCategories).val(strSelectedStyleCategories);
            }

            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
        </script>
</body>
</html>
