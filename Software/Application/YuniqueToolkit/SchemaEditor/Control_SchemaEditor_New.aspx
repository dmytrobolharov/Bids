<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SchemaEditor_New.aspx.vb" Inherits="YuniFace.Control_SchemaEditor_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
    <head id="Head1" runat="server">
        <title id="PageTitle" runat="server">Schema New</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
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

            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td>
                        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="" />
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" ImageUrl="" CausesValidation="False" />
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
                                        <asp:Label ID="lblHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0">New Schema...</asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlBody" runat="server">
                            <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False" />
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
