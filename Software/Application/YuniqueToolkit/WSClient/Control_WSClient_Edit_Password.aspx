<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_WSClient_Edit_Password.aspx.vb" Inherits="YuniFace.Control_WSClient_Edit_Password" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle">Options</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
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

			<br />
			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview>
			<asp:Panel id="pnlUserOption" runat="server">
				<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr>
						<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td width="100%">
							<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"  CausesValidation="False"></cc1:confirmedimagebutton>
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<asp:label id="lblMsg" Runat="server" CssClass="fontRed"></asp:label>
				<table cellSpacing="0" cellPadding="0" width="270" border="0">
					<tr>
						<td width="120">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td class="fontHead" width="120"><asp:Label ID="lblUserName" runat="server"></asp:Label></td>
						<td>
							<asp:textbox id="txtUserName" runat="server" CssClass="font" MaxLength="25" Width="150px"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="fontHead" style="HEIGHT: 20px" width="120"><asp:Label ID="lblPassword" runat="server"></asp:Label></td>
						<td style="HEIGHT: 20px">
							<asp:textbox id="txtPassword1" runat="server" CssClass="font" MaxLength="15" Width="150px" TextMode="Password"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="fontHead" width="120"><asp:Label ID="lblConfirmpassword" runat="server"></asp:Label></td>
						<td>
							<asp:textbox id="txtPassword2" runat="server" CssClass="font" MaxLength="15" Width="150px" TextMode="Password"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="fontHead" id="AutoGenerate" colSpan="2" runat="server">
						    <asp:Label ID="lblAutogenerate" runat="server"></asp:Label>
                            &nbsp;<input id="chkAutoPwd" onclick="Check(this);" type="checkbox" name="chkAutoPwd" Runat="server" />
						</td>
					</tr>
				</table>
			</asp:Panel>
		</form>
		<script language="javascript">

		    try
            {
                document.Form1("txtPassword1").value = "#GENERAL_PASSWORD#";
                document.Form1("txtPassword2").value = "#GENERAL_PASSWORD#";
            }
            catch (err)
			{
                
            }

            function Check(obj)
            {
                document.Form1("txtPassword1").disabled= obj.checked;
                document.Form1("txtPassword2").disabled = obj.checked ;
            }

		</script>
	</body>
</html>
