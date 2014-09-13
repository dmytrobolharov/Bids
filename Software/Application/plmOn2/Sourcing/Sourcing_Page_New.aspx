<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_New.aspx.vb" Inherits="plmOnApp.Sourcing_Page_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sourcing New</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
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
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <asp:ImageButton ID="btnSaveSourcing" runat="server"></asp:ImageButton>
                <asp:ImageButton id="btnClose" runat="server" causesvalidation="False" OnClientClick="window.close();"></asp:ImageButton>
            </td>
        </tr>
    </table>
    <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <div align="right">
                                <asp:Label ID="lblSourcingHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0">New Style...</asp:Label></div>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnlSourcing" runat="server">
                    <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr valign="top">
                            <td width="10">
                                &nbsp;
                            </td>
                            <td>
                                <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
                    border="0">
                    <tr valign="top">
                        <td width="33%">
                        </td>
                        <td width="33%">
                        </td>
                        <td width="33%">
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10%" bgcolor="#f5f5f5">
                &nbsp;
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

        </script>

</body>
</html>
