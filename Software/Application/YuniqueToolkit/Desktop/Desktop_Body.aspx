<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Desktop_Body.aspx.vb" Inherits="YuniFace.Desktop_Body" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Yunique Toolkit</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
		<meta name="vs_defaultClientScript" content="JavaScript" />
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />

        <script language="javascript" src="../System/Jscript/System.js"></script>

        <style type="text/css">
            td.off
            {
                cursor: hand;
            }
            td.on
            {
                cursor: hand;
            }
        </style>

        <script language="javascript" type="text/javascript">
            function BindMouseOverImage(ID, Path) {
                document.getElementById('' + ID + '').src = Path
            }
        </script>
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

			<table width="100%" height="27" border="0" cellpadding="0" cellspacing="0" class="TableHeader">
				<tr>
					<td width="100%">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" bgcolor="#ffffff">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><div align="right">
									<asp:Label id="lblHeader" runat="server" Font-Size="XX-Large" ForeColor="Silver"></asp:Label></div>
								</td>
							</tr>
						</table>
                        <br />
						<table width="100%" height="50%" border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td align="center" width="100%">
                                    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
								</td>
							</tr>
						</table>
						<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" background="../System/Images/MiddleFill.jpg">
							<tr valign="top">
								<td width="100%">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
