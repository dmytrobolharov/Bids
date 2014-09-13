<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SpreadsheetEditor_Edit.aspx.vb" Inherits="YuniFace.Control_SpreadsheetEditor_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title>Spreadsheet Editor</title>
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

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        <cc1:ConfirmedImageButton ID="btnEditFileFolder" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="btnEditFile" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnRestore" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnDelete" runat="server" CausesValidation="False"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnUpdate" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnCancel" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
					<td class="fontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Spreadsheet</asp:label></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td class="fontHead" width="40">
					    <asp:Label ID="lblFileName" runat="server" />
					</td>
					<td class="font">
					    &nbsp;
					</td>
					<td class="font">
					    <asp:Label ID="txtFileName" runat="server" />
					</td>
				</tr>
				<tr>
					<td class="fontHead" width="40">
					    <asp:Label ID="lblCreated" runat="server" />
					</td>
					<td class="font">
					    &nbsp;
					</td>
					<td class="font">
					    <asp:Label ID="txtCreated" runat="server" />
					</td>
				</tr>
				<tr>
					<td class="fontHead" width="40">
					    <asp:Label ID="lblModified" runat="server" />
					</td>
					<td class="font">
					    &nbsp;
					</td>
					<td class="font">
					    <asp:Label ID="txtModified" runat="server" />
					</td>
				</tr>
				<tr>
					<td class="fontHead" width="40">
					    <asp:Label ID="lblSize" runat="server" />
					</td>
					<td class="font">
					    &nbsp;
					</td>
					<td class="font">
					    <asp:Label ID="txtSize" runat="server" />
					</td>
				</tr>
			</table>

            <br />
            <cc2:YSTabView ID="YSTabView1" StartTab="1" runat="server"></cc2:YSTabView>

            <asp:Panel runat="server" ID="pnlPerm" Visible="false">
		        <table style="height:50;" cellspacing="0" cellpadding="0" width="100%" bgcolor="#990000" border="1" bordercolor="red">
			        <tr>
				        <td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="Image1" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" Text="You might not have permission to edit spreadsheet files using your credentials." CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>			
	        </asp:Panel>

            <asp:Panel runat="server" ID="pnlWhereUsed" Visible="false">
                <br />
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr class="font">
				        <td height='25' class='fontHead' nowrap="nowrap">
					        <asp:label id="lblWhereUsed" runat="server"></asp:label>
				        </td>
			        </tr>
			        <tr class="font">
				        <td>
                            <asp:PlaceHolder ID="plhWhereUsed" runat="server"></asp:PlaceHolder>
				        </td>
			        </tr>
			    </table>
			</asp:Panel>

		</form>
	</body>
</html>
