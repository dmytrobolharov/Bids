<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Configurator_Main.aspx.vb" Inherits="YuniFace.Control_Configurator_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"> -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
	<head>
		<title>Configure YuniquePLM</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
		<meta name="vs_defaultClientScript" content="JavaScript" />
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	</head>
	<body MS_POSITIONING="GridLayout">
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

			<table class="TableHeader" id="tbrToolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnLDemo" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnLActivate" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnLUpdate" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnConfigureYuniquePLM" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					</td>
					<td class="fontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Configure YuniquePLM</asp:label></td>
				</tr>
			</table>

            <br />
            <telerik:RadTabStrip ID="RadTabStrip1" runat="server" Align="Justify" Skin="Outlook" MultiPageID="RadMultiPage1" SelectedIndex="0" CssClass="tabStrip">
                <Tabs>
                    <telerik:RadTab Text="License">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Company Info">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Application Server">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Database Server">
                    </telerik:RadTab>
                    <telerik:RadTab Text="CAD Database Server">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Report Server">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Mail">
                    </telerik:RadTab>
<%--                    <telerik:RadTab Text="Configure YuniquePLM">
                    </telerik:RadTab>--%>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" CssClass="multiPage">
                <telerik:RadPageView ID="rpvLicense" runat="server">
                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblLLicense" runat="server" ForeColor="Green">License</asp:label>
                            </td>
				        </tr>
					    <tr valign='top'>
						    <td width='50%'>
							    <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblLSerialNumber" runat="server">Serial Number</asp:label>
									    </td>
									    <td class='font'>
										    <asp:label id="txtLSerialNumber" runat="server"></asp:label>
									    </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblLInstallationCode" runat="server">Installation Code</asp:label>
									    </td>
									    <td class='font'>
						                    <telerik:RadTextBox ID="txtLInstallationCode" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
                                        </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblLInstallationSerial" runat="server">Unique Serial</asp:label>
									    </td>
									    <td class='font'>
										    <asp:label id="txtLInstallationSerial" runat="server"></asp:label>
                                        </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblLNumberOfUsers" runat="server">Number of Users</asp:label>
									    </td>
									    <td class='font'>
										    <asp:label id="txtLNumberOfUsers" runat="server"></asp:label>
									    </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblLLicenseStatus" runat="server">License Status</asp:label>
									    </td>
									    <td class='font'>
										    <asp:label id="txtLLicenseStatus" runat="server"></asp:label>
									    </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblLInstallationDate" runat="server">Installation Date</asp:label>
									    </td>
									    <td class='font'>
										    <asp:label id="txtLInstallationDate" runat="server"></asp:label>
									    </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblLLastUpdated" runat="server">Last Updated</asp:label>
									    </td>
									    <td class='font'>
										    <asp:label id="txtLLastUpdated" runat="server"></asp:label>
									    </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblLExpirationDate" runat="server">Expiration Date</asp:label>
									    </td>
									    <td class='font'>
										    <asp:label id="txtLExpirationDate" runat="server"></asp:label>
									    </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap" valign="top">
									        <br />
										    <asp:label id="lblLFeatures" runat="server">Features</asp:label>
									    </td>
									    <td class='font'>
									        <br />
                                            <asp:PlaceHolder ID="plhLFeatures" runat="server"></asp:PlaceHolder>
									    </td>
								    </tr>
							    </table>
						    </td>
						    <td width='50%'>
						    </td>
					    </tr>
				    </table>
                </telerik:RadPageView>
                <telerik:RadPageView ID="rpvCompanyInfo" runat="server">
                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblCICompanyInfo" runat="server" ForeColor="Green">Company Info</asp:label>
                            </td>
				        </tr>
					    <tr valign='top'>
						    <td width='50%'>
							    <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblCIAddress1" runat="server">Address Line 1</asp:label>
									    </td>
									    <td class='font'>
						                    <telerik:RadTextBox ID="txtCIAddress1" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
									    </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblCIAddress2" runat="server">Address Line 2</asp:label>
									    </td>
									    <td class='font'>
						                    <telerik:RadTextBox ID="txtCIAddress2" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
									    </td>
								    </tr>
								    <tr>
									    <td width='125' height='25' class='fontHead' nowrap="nowrap">
										    <asp:label id="lblCIAddress3" runat="server">Address Line 3</asp:label>
									    </td>
									    <td class='font'>
						                    <telerik:RadTextBox ID="txtCIAddress3" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
									    </td>
								    </tr>
							    </table>
						    </td>
						    <td width='50%'>
						    </td>
					    </tr>
				    </table>
                </telerik:RadPageView>
                <telerik:RadPageView ID="rpvApplicationServer" runat="server">
                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblASApplicationServer" runat="server" ForeColor="Green">Application Server</asp:label>
                            </td>
				        </tr>
				        <tr valign='top'>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblASServerName" runat="server">Server Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtASServerName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblASIPAddress" runat="server">IP Address</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtASIPAddress" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblASAdminName" runat="server">Admin Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtASAdminName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
								        </td>
								        <td class='font'>
						                    <asp:checkbox id="chkASIPOverName" runat="server" Enabled="false" CssClass="font" />
								        </td>
							        </tr>
						        </table>
					        </td>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblASUserName" runat="server">User Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtASUserName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblASPassword" runat="server">Password</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtASPassword" runat="server" Enabled="false" TextMode="Password" Label="" EmptyMessage="" AutoPostBack="false" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblASAdminEMail" runat="server">Admin EMail</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtASAdminEMail" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblASWSIdentifier" runat="server">Web Site Identifier</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtASWSIdentifier" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
			        </table>
                </telerik:RadPageView>
                <telerik:RadPageView ID="rpvDatabaseServer" runat="server">
                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblDSConnection" runat="server" ForeColor="Green">Database Connection</asp:label>
                            </td>
				        </tr>
				        <tr valign='top'>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblDSServerName" runat="server">Server Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtDSServerName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblDSInstanceName" runat="server">Instance Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtDSInstanceName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblDSInitialCatalog" runat="server">Initial Catalog</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtDSInitialCatalog" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblDSUserName" runat="server">User Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtDSUserName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblDSPassword" runat="server">Password</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtDSPassword" runat="server" Enabled="false" TextMode="Password" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
                        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblDSScripts" runat="server" ForeColor="Green">Database Scripts</asp:label>
                            </td>
				        </tr>
                        <tr>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblDSDSUserName" runat="server">User Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtDSDSUserName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblDSDSPassword" runat="server">Password</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtDSDSPassword" runat="server" Enabled="false" TextMode="Password" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:ListBox ID="lstDSDSScripts" runat="server" Width="99%" Height="300"></asp:ListBox>
                            </td>
                        </tr>
			        </table>
                </telerik:RadPageView>
                <telerik:RadPageView ID="rpvCADDatabaseServer" runat="server">
                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblCADConnection" runat="server" ForeColor="Green">Remote CAD Database Connection</asp:label>
                            </td>
				        </tr>
				        <tr valign='top'>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblCADServerName" runat="server">Server Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtCADServerName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblCADDatabaseName" runat="server">Database Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtCADDatabaseName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblCADUserName" runat="server">User Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtCADUserName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblCADPassword" runat="server">Password</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtCADPassword" runat="server" Enabled="false" TextMode="Password" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
                        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblCADLocalLogin" runat="server" ForeColor="Green">Local Login</asp:label>
                            </td>
				        </tr>
                        <tr>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblCADLocalUserName" runat="server">User Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtCADLocalUserName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblCADLocalPassword" runat="server">Password</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtCADLocalPassword" runat="server" Enabled="false" TextMode="Password" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
			        </table>
                </telerik:RadPageView>
                <telerik:RadPageView ID="rpvReportServer" runat="server">
                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblRSConnection" runat="server" ForeColor="Green">Report Server Connection</asp:label>
                            </td>
				        </tr>
				        <tr valign='top'>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblRSServerName" runat="server">Server Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtRSServerName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblRSDomainName" runat="server">Domain Name</asp:label>
								        </td>
								        <td class='font'>
									        <asp:label id="txtRSDomainName" runat="server">Domain Name</asp:label>
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblRSInstanceName" runat="server">Instance Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtRSInstanceName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblRSUserName" runat="server">User Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtRSUserName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblRSPassword" runat="server">Password</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtRSPassword" runat="server" Enabled="false" TextMode="Password" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
                        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblRSInstallLocation" runat="server" ForeColor="Green">Reporting Services Install Location (Report Server Only)</asp:label>
                            </td>
				        </tr>
                        <tr>
                            <td colspan="2">
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblRSLocation" runat="server">Install Location</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtRSLocation" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
			        </table>
                </telerik:RadPageView>
                <telerik:RadPageView ID="rpvMail" runat="server">
                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <asp:label id="lblMMailSetup" runat="server" ForeColor="Green">Mail Setup</asp:label>
                            </td>
				        </tr>
				        <tr valign='top'>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblMSMTPServer" runat="server">SMTP Server</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtMSMTPServer" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblMSMTPUserName" runat="server">SMTP User Name</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtMSMTPUserName" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblMSMTPPassword" runat="server">SMTP Password</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtMSMTPPassword" runat="server" Enabled="false" TextMode="Password" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
					        <td width='50%'>
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblMSMTPPort" runat="server">SMTP Port</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtMSMTPPort" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblMSMTPFromAddress" runat="server">SMTP From Addr</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtMSMTPFromAddress" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
                        <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        <tr>
                            <td colspan="2">
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
								        </td>
								        <td class='font'>
            			                    <asp:checkbox id="chkMSaveSentMailMessages" runat="server" Enabled="false" CssClass="font" />
								        </td>
							        </tr>
						        </table>
                            </td>
				        </tr>
                        <tr>
                            <td colspan="2">
						        <table width='98%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
							        <tr>
								        <td width='125' height='25' class='fontHead' nowrap="nowrap">
									        <asp:label id="lblMMailQueueFolder" runat="server">Mail Queue Folder</asp:label>
								        </td>
								        <td class='font'>
						                    <telerik:RadTextBox ID="txtMMailQueueFolder" runat="server" Enabled="false" TextMode="SingleLine" Width="100%" EnableEmbeddedSkins="false" Skin="YPLM" SelectionOnFocus="SelectAll" EnableSingleInputRendering="true" />
								        </td>
							        </tr>
						        </table>
					        </td>
				        </tr>
			        </table>
                </telerik:RadPageView>
                <telerik:RadPageView ID="rpvConfigureYuniquePLM" runat="server">
                    <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                        <tr><td>&nbsp;</td></tr>
                        <tr>
                            <td width="100%">
						        <asp:label id="lblCConfigureYuniquePLM" runat="server" ForeColor="Green">Configure YuniquePLM</asp:label>
                            </td>
				        </tr>
                        <tr>
                            <td width="100%" height='25' class='fontHead' nowrap="nowrap">
						        <asp:label id="lblCConfigureMessage" runat="server">Please perform the following operations when I press the 'Configure YuniquePLM' button.</asp:label>
                            </td>
                        </tr>
                        <tr>
                            <td width="100%">
                                <telerik:RadTreeView ID="rtvCTasks" runat="server" Enabled="false" Width="99%" Height="400" CheckBoxes="true" TriStateCheckBoxes="true" CheckChildNodes="true" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1" />
                            </td>
                        </tr>
			        </table>
                </telerik:RadPageView>
            </telerik:RadMultiPage>

			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>

		</form>
	</body>
</html>
