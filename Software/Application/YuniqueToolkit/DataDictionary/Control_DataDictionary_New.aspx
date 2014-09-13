<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DataDictionary_New.aspx.vb" Inherits="YuniFace.Control_DataDictionary_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title runat="server" id="PageTitle">New Data Dictionary Entry</title>
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
            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" >
            </telerik:RadAjaxManager>

        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
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
                                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
										<tr valign='top'>
											<td width='50%'>
												<table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnAlias" runat="server">Alias</asp:label>
														</td>
														<td class='font'>
                                                            <telerik:RadComboBox ID="cboColumnAlias" runat="server" Width="150px" Height="150px"
                                                                EmptyMessage="" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                                EnableVirtualScrolling="true" OnItemsRequested="cboColumnAlias_ItemsRequested"
                                                                AllowCustomText="true"   MarkFirstMatch="true" 
                                                                EnableEmbeddedSkins="false" Skin="YPLM"
                                                                AutoPostBack="false">
                                                            </telerik:RadComboBox>
														</td>
													</tr>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnTypeID" runat="server">Column Type</asp:label>
														</td>
														<td class='font'>
												            <asp:DropDownList ID="drlColumnTypeID" runat="server" AutoPostBack="true" Width="150px" />
														</td>
													</tr>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnDataTypeID" runat="server" Visible="false">Data Type</asp:label>
														</td>
														<td class='font'>
												            <asp:DropDownList ID="drlColumnDataTypeID" runat="server" AutoPostBack="true" Width="150px" Visible="false" />
														</td>
													</tr>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnDataTypeLength" runat="server" Visible="false">Data Length</asp:label>
														</td>
														<td class='font'>
												            <asp:textbox id="txtColumnDataTypeLength" runat="server" CssClass="font" Width="150px" Visible="false" />
														</td>
													</tr>
												</table>
											</td>
											<td width='50%'>
												<table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnLookupQuery" runat="server" Visible="false">Validation Table</asp:label>
														</td>
														<td class='font'>
												            <asp:DropDownList ID="drlColumnLookupQuery" runat="server" AutoPostBack="false" Width="150px" Visible="false" />
														</td>
													</tr>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnAutoPostBack" runat="server" Visible="false">Auto PostBack</asp:label>
														</td>
														<td class='font'>
											                <asp:CheckBox ID="chbColumnAutoPostBack" runat="server" CssClass="font" Visible="false" />
														</td>
													</tr>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnAddNullField" runat="server" Visible="false">Add NULL Field</asp:label>
														</td>
														<td class='font'>
											                <asp:CheckBox ID="chbColumnAddNullField" runat="server" CssClass="font" Visible="false" />
														</td>
													</tr>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnSearch" runat="server" Visible="false">Search</asp:label>
														</td>
														<td class='font'>
											                <asp:CheckBox ID="chbColumnSearch" runat="server" CssClass="font" Visible="false" />
														</td>
													</tr>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnGridSearch" runat="server" Visible="false">Grid Search</asp:label>
														</td>
														<td class='font'>
											                <asp:CheckBox ID="chbColumnGridSearch" runat="server" CssClass="font" Visible="false" />
														</td>
													</tr>
													<tr>
														<td width='125' height='25' class='fontHead' nowrap="nowrap">
															<asp:label id="lblColumnSelect" runat="server" Visible="false">Select</asp:label>
														</td>
														<td class='font'>
											                <asp:CheckBox ID="chbColumnSelect" runat="server" CssClass="font" Visible="false" />
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
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
