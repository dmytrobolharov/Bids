<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SchemaEditor_EditValidators.aspx.vb" Inherits="YuniFace.Control_SchemaEditor_EditValidators" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head id="Head1" runat="server">
        <title runat="server" id="PageTitle">Edit validators</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
		<meta name="vs_defaultClientScript" content="JavaScript" />
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
	    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
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
            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            </telerik:RadAjaxManager>

            <script type="text/javascript">
                function closeWin() {
                    GetRadWindow().close();
                }

                function GetRadWindow() {
                    var oWindow = null; if (window.radWindow)
                        oWindow = window.radWindow; else if (window.frameElement.radWindow)
                        oWindow = window.frameElement.radWindow; return oWindow;
                }
            </script>

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnSaveAndClose" runat="server" ImageUrl="" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnCancel" runat="server" ImageUrl="" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>

			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
	            <tr valign='top' align="center">
		            <td width='98%'>
            	        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
            	        <asp:Label ID="lblRadGridDefaultHeader" runat="server">Default</asp:Label></b></font>
		            </td>
	            </tr>
			    <tr class="fontHead">
				    <td>
				        <cc1:confirmedimagebutton id="btnAddDefault" runat="server" ImageUrl="" Message="NONE" EnableViewState="False" />&nbsp;
				        <cc1:confirmedimagebutton id="btnDeleteDefault" runat="server" ImageUrl="" Message="NONE" EnableViewState="False" />
				    </td>
			    </tr>
	            <tr valign='top' align="center">
		            <td width='98%'>
                        <asp:PlaceHolder ID="plhDefaultControlsHolder" runat="server"></asp:PlaceHolder>
		            </td>
	            </tr>

	            <tr valign='top' align="center">
		            <td width='98%'>
		                <br />
            	        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
            	        <asp:Label ID="lblRadGridSearchHeader" runat="server">Search</asp:Label></b></font>
		            </td>
	            </tr>
			    <tr class="fontHead">
				    <td>
				        <cc1:confirmedimagebutton id="btnAddSearch" runat="server" ImageUrl="" Message="NONE" EnableViewState="False" />&nbsp;
				        <cc1:confirmedimagebutton id="btnDeleteSearch" runat="server" ImageUrl="" Message="NONE" EnableViewState="False" />
				    </td>
			    </tr>
	            <tr valign='top' align="center">
		            <td width='98%'>
                        <asp:PlaceHolder ID="plhSearchControlsHolder" runat="server"></asp:PlaceHolder>
		            </td>
	            </tr>
			</table>
			<br />

		</form>
    </body>
</html>
