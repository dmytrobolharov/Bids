<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_LineList_New.aspx.vb" Inherits="plmOnApp.Planning_Folder_LineList_New" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head id="Head1" runat="server">
    <title></title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body ms_positioning="GridLayout">
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
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
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSaveMaterial" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.close(); return false;"
                    CausesValidation="False"></cc1:ConfirmedImageButton>
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
                <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
                    cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                    <tr>
                        <td>
                            &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">New Line List Folder...</asp:Label>
                        </td>
                    </tr>
                </table>
                <br>
                <asp:Panel ID="pnlMaterial" runat="server">
                    <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr valign="top">
                            <td width="10">
                                &nbsp;
                            </td>
                            <td>
                                <blockquote dir="ltr" style="margin-right: 0px">
                                    <p>
                                        <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                    </p>
                                </blockquote>
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
    <asp:HiddenField ID="hdnSelectedCalendars" runat="server" />
    <asp:HiddenField ID="hdnXmlFiles" runat="server" />
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
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

                    function GetSelectedCalendars(sender, eventArgs) {
                        var comboItems = $find('<%= dclCalendar.ClientID %>').get_items();
                        var hdnSelectedCalendars = $("#hdnSelectedCalendars");

                        var strSelectedCalendars = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedCalendars != "") {
                                    strSelectedCalendars += ",";
                                }
                                strSelectedCalendars += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedCalendars).val(strSelectedCalendars);
                    }

        </script>
    </telerik:RadScriptBlock>
    </form>
</body>
</html>
