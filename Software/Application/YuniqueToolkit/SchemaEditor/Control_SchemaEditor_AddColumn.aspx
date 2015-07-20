<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SchemaEditor_AddColumn.aspx.vb" Inherits="YuniFace.Control_SchemaEditor_AddColumn" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title runat="server" id="PageTitle">Add Column</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
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

                        <br />
                        <cc3:YSTabView ID="YSTabView1" runat="server"></cc3:YSTabView>

                        <asp:Panel runat="server" ID="pnlPerm" Visible="false">
				            <table style="height:50;" cellspacing="0" cellpadding="0" width="100%" bgcolor="#990000" border="1" bordercolor="red">
					            <tr>
						            <td>
                                        <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td width="25"><div align="center"><asp:image id="Image1" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                                <td><asp:Label ID="lblPerm" runat="server" Text="You might not have permission to edit schema files using your credentials." CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>			
			            </asp:Panel>

                        <asp:Panel ID="pnlCoreColumns" runat="server">
                            <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <br />
                                        <asp:listbox id="lstCoreColumns" runat="server" CssClass="fontHead" Width="250px" Height="220px" SelectionMode="Multiple" BorderStyle="Outset"></asp:listbox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>

			            <asp:Panel ID="pnlDataDictionary" runat="server">
			                <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td width="10">
                                        &nbsp;
                                    </td>
                                    <td>
                                        <br />
                                        <asp:listbox id="lstCustomColumns" runat="server" CssClass="fontHead" Width="250px" Height="220px" SelectionMode="Multiple" BorderStyle="Outset"></asp:listbox>
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
