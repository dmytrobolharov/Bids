<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Configurator_Results.aspx.vb" Inherits="YuniFace.Control_Configurator_Results" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
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
					    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
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

            <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
                <tr><td>&nbsp;<br /></td><td>&nbsp;<br /></td></tr>
                <tr>
                    <td colspan="2">
				        <asp:label id="lblConfigureYuniquePLM" runat="server" ForeColor="Green">Configure YuniquePLM</asp:label>
                    </td>
		        </tr>
			    <tr valign='top'>
				    <td width='50%'>
					    <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
						    <tr>
							    <td width='125' height='25' class='fontHead' nowrap="nowrap">
								    <asp:label id="lblOverallStatusHeader" runat="server">Overall Status</asp:label>
							    </td>
							    <td class='font'>
								    <asp:label id="lblOverallStatus" runat="server"></asp:label>
							    </td>
						    </tr>
						    <tr>
							    <td width='125' height='25' class='fontHead' nowrap="nowrap">
								    <asp:label id="lblPercentCompleteHeader" runat="server">Percent Complete</asp:label>
							    </td>
							    <td class='font'>
								    <asp:label id="lblPercentComplete" runat="server"></asp:label>
							    </td>
						    </tr>
						    <tr>
							    <td width='125' height='25' class='fontHead' nowrap="nowrap">
								    <asp:label id="lblStartTimeHeader" runat="server">Start Time</asp:label>
							    </td>
							    <td class='font'>
								    <asp:label id="lblStartTime" runat="server"></asp:label>
							    </td>
						    </tr>
						    <tr>
							    <td width='125' height='25' class='fontHead' nowrap="nowrap">
								    <asp:label id="lblEndTimeHeader" runat="server">End Time</asp:label>
							    </td>
							    <td class='font'>
								    <asp:label id="lblEndTime" runat="server"></asp:label>
							    </td>
						    </tr>
						    <tr>
							    <td width='125' height='25' class='fontHead' nowrap="nowrap">
								    <asp:label id="lblElapsedTimeHeader" runat="server">Elapsed Time</asp:label>
							    </td>
							    <td class='font'>
								    <asp:label id="lblElapsedTime" runat="server"></asp:label>
							    </td>
						    </tr>
					    </table>
				    </td>
				    <td width='50%'>
				    </td>
			    </tr>
                <tr><td>&nbsp;<br /></td><td>&nbsp;<br /></td></tr>
                <tr>
                    <td colspan="2">
				        <asp:label id="lblTaskStatus" runat="server" ForeColor="Green">Task Status</asp:label>
                    </td>
		        </tr>
                <tr>
				    <td width='50%'>
                        <asp:PlaceHolder ID="plhLResults" runat="server"></asp:PlaceHolder>
				    </td>
				    <td width='50%'>
				    </td>
		        </tr>
		    </table>

			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>

		</form>
	</body>
</html>
