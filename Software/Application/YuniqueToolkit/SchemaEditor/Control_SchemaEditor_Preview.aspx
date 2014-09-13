<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SchemaEditor_Preview.aspx.vb" Inherits="YuniFace.Control_SchemaEditor_Preview" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
        <title runat="server" id="PageTitle">Schema Preview</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<script language="JavaScript">
		<!--

		    if (window.screen) 
			{
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}

			self.focus();

		//-->
		</script>
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

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnClose" runat="server" ImageUrl="" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
    				<td class="fontHead" align="right" width="100">
    				</td>
    				<td width="40">
    				</td>
				</tr>
			</table>
			
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>

			<table style="BORDER-BOTTOM: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td>

                        <!-- Form controls -->
                        <asp:Panel runat="server" ID="pnlForm" Visible="false">
                            <br />
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td width="10">&nbsp;</td>
                                    <td>
                                        <asp:placeholder id="plhFormControls" runat="server" EnableViewState="False" />
                                    </td>
                                </tr>
                            </table>
                            <br />
	                    </asp:Panel>


                        <!-- Search controls -->
                        <asp:Panel runat="server" ID="pnlSearch" Visible="false">
						    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
							    <tr>
								    <td>
								        <asp:placeholder id="plhSearchControls" runat="server" EnableViewState="False" />
								    </td>
								    <td valign="top" width="100%">
									    <table>
										    <tr>
											    <td>
											        <asp:imagebutton id="imgBtnSearch" runat="server" />
											    </td>
										    </tr>
									    </table>
								    </td>
							    </tr>
						    </table>
	                    </asp:Panel>


                        <!-- Grid controls -->
                        <asp:Panel runat="server" ID="pnlGrid" Visible="false">
						    <table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
							    <tr valign="middle">
								    <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								    <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								    <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								    <td nowrap align="center" width="100"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								    <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								    <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
								    <td width="10">&nbsp;</td>
								    <td nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								    <td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
								    <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										    <asp:ListItem Value="5">5</asp:ListItem>
										    <asp:ListItem Value="10">10</asp:ListItem>
										    <asp:ListItem Value="15">15</asp:ListItem>
										    <asp:ListItem Value="20">20</asp:ListItem>
										    <asp:ListItem Value="25">25</asp:ListItem>
										    <asp:ListItem Value="30">30</asp:ListItem>
										    <asp:ListItem Value="40">40</asp:ListItem>
										    <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									    </asp:dropdownlist></td>
								    <td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
							    </tr>
						    </table>

                            <asp:datagrid id="DataGrid1" runat="server" EnableViewState="False" DataKeyField="">
                                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                <PagerStyle Visible="False"></PagerStyle>
                            </asp:datagrid>
                            <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
	                    </asp:Panel>

					</td>
				</tr>
			</table>
			<br />
			<br />
			<input id="hiddenCurrentPage" type="hidden" value="0" runat="server">&nbsp;&nbsp;
		</form>
	</body>
</html>
