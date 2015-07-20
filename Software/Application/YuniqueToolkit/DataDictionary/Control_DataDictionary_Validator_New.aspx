<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DataDictionary_Validator_New.aspx.vb" Inherits="YuniFace.Control_DataDictionary_Validator_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title runat="server" id="PageTitle">New Data Dictionary Validator Entry</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    </head>
    <body ms_positioning="GridLayout">
        <form id="Form1" method="post" runat="server">
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

            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="80">
                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" ImageUrl="" Message="NONE"></cc1:ConfirmedImageButton>
                    </td>
                    <td>
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" ImageUrl="" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
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
                                        <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlEditControls" runat="server">
                            <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg" border="0">
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
        </form>
    </body>
</html>
