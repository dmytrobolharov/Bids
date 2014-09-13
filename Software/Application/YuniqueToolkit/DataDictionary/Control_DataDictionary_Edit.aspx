<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DataDictionary_Edit.aspx.vb" Inherits="YuniFace.Control_DataDictionary_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title runat="server" id="PageTitle">Edit Data Validation Entry</title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
        <meta content="JavaScript" name="vs_defaultClientScript" />
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
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
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                    </td>
                    <td>
                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" ImageUrl="" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnSaveNew" runat="server" Message="NONE" ImageUrl=""></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnDelete" runat="server" ImageUrl=""></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnClose" runat="server" ImageUrl="" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                    </td>
                    <td class="FontHead" align="right" width="75">
                    </td>
                    <td width="40">
                    </td>
                    <td>
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
            <table style="BORDER-BOTTOM: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellspacing="2" cellpadding="0" width="100%" border="0">
                <tr>
                    <td>
                        <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
							<tr valign='top'>
								<td width='50%'>
									<table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										<tr>
											<td width='125' height='25' class='fontHead' nowrap="nowrap">
												<asp:label id="lblColumnName" runat="server">Name</asp:label>
											</td>
											<td class='font'>
												<asp:label id="txtColumnName" runat="server"></asp:label>
												<asp:HiddenField ID="hdnCoreColumn" runat="server" />
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fontHead' nowrap="nowrap">
												<asp:label id="lblColumnAlias" runat="server">Alias</asp:label>
											</td>
											<td class='font'>
									            <asp:textbox id="txtColumnAlias" runat="server" CssClass="font" Width="150px" />
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
									<table id="tblValidationTable" runat="server" width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										<tr id="rowValidationTable">
											<td width='125' height='25' class='fontHead' nowrap="nowrap">
												<asp:label id="lblColumnLookupQuery" runat="server" Visible="false">Validation Table</asp:label>
											</td>
											<td class='font'>
									            <asp:DropDownList ID="drlColumnLookupQuery" runat="server" AutoPostBack="false" Width="150px" Visible="false" />
											</td>
										</tr>
									</table>
									<table id="tblLookupQuery" runat="server" width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										<tr id="rowLookupQuery">
											<td width='125' height='25' class='fontHead' nowrap="nowrap">
												<asp:label id="lblColumnLookupQueryText" runat="server">Lookup Query</asp:label>
											</td>
											<td class='font'>
									            <asp:textbox id="txtColumnLookupQueryText" runat="server" CssClass="font" Width="150px" Visible="false" />
											</td>
										</tr>
										<tr id="rowTextColumn">
											<td width='125' height='25' class='fontHead' nowrap="nowrap">
												<asp:label id="lblColumnTextColumn" runat="server">Text Column</asp:label>
											</td>
											<td class='font'>
									            <asp:textbox id="txtColumnTextColumn" runat="server" CssClass="font" Width="150px" />
											</td>
										</tr>
										<tr id="rowValueColumn">
											<td width='125' height='25' class='fontHead' nowrap="nowrap">
												<asp:label id="lblColumnValueColumn" runat="server">Value Column</asp:label>
											</td>
											<td class='font'>
									            <asp:textbox id="txtColumnValueColumn" runat="server" CssClass="font" Width="150px" />
											</td>
										</tr>
									</table>
									<table id="tblOther" runat="server" width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
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
                        <br>
                        <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                    </td>
                </tr>
            </table>

            <asp:Panel ID="pnlValidator" runat="server">
                <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                        </td>
                        <td>
                            <cc1:BWImageButton ID="btnAddValidator" runat="server" ImageUrl=""
                                NavigateUrl="Control_DataDictionary_Validator_New.aspx" WindowName="Control_DataDictionary_Validator_New"
                                WindowWidth="600px" WindowHeight="500px" Location="False" MenuBar="False" Resizable="True"
                                ScrollBars="True" Status="False" ToolBar="False" />
                        </td>
                    </tr>
                </table>

                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>

                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top">
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </form>
    </body>
</html>
