<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_User_ImportFromLdap.aspx.vb" Inherits="plmOnApp.Control_User_ImportFromLdap" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title>Control Panel</title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    </head>
    <body>
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
                    <td>
                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                    </td>
                </tr>
            </table>
            <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td>
                        &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" cellpadding="0" width="650" border="0">
                <tr>
                    <td colspan="4">
                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr class="TableHeader">
                                <td class="TableHeader" width="10" height="25">
                                </td>
                                <td class="TableHeader" width="200">
                                    <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fonthead">
                                        <asp:Label ID="lblAvailableUsers" runat="server" Text="Available User(s)"></asp:Label></b></font>
                                </td>
                                <td class="TableHeader" width="10">
                                </td>
                                <td class="TableHeader" width="200">
                                    <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fonthead">
                                        <asp:Label ID="lblSelectedUsers" runat="server" Text="Selected User(s)"></asp:Label>&nbsp;</b></font>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" width="10">
                                </td>
                                <td colspan="3">
                                    <table cellspacing="0" cellpadding="0" border="0">
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlUserGroups" runat="server" CssClass="fontHead">
                                                    <asp:ListItem Value="5">5</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtSearch" runat="server" Width="200px"></asp:TextBox>
                                                <asp:ImageButton ID="btnSearch" runat="server" ></asp:ImageButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" width="10">
                                </td>
                                <td valign="top" width="200">
                                    <asp:PlaceHolder ID="plhUsers" runat="server"></asp:PlaceHolder>
                                </td>
                                <td align="center" width="10">
                                    <asp:ImageButton ID="btnaddUserall" runat="server" ></asp:ImageButton><br>
                                    <asp:ImageButton ID="btnaddUserItem" runat="server" ></asp:ImageButton><br>
                                    <asp:ImageButton ID="btnRemoveUserItem" runat="server"></asp:ImageButton><br>
                                    <asp:ImageButton ID="btnRemoveUserAll" runat="server"></asp:ImageButton><br>
                                </td>
                                <td valign="top" width="200">
                                    <asp:PlaceHolder ID="plhSelectedUsers" runat="server"></asp:PlaceHolder>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
    </body>
</html>
