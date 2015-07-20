<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Report_Main.aspx.vb" Inherits="srmOnApp.Report_Main"%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle">Report</title>	
        <style type="text/css">
            .DropdownLabel {font-family: Verdana; font-size: 8pt; font-weight: bold;}
            .Dropdown {font-family: Verdana; font-size: 8pt;}
            html, body {overflow: hidden; height: 100%;}
            body {margin: 0; padding: 0;}
            html#html, body#body, form#form1, div#content {height: 100%;}
        </style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <rsweb:ReportViewer ID="ReportViewer1" PageCountMode="Actual" runat="server" Font-Names="Verdana" 
                Font-Size="8pt" Height="100%" ProcessingMode="Remote" Width="100%" 
                PromptAreaCollapsed="True" ShowParameterPrompts="True" BorderColor="Gray" 
                BorderStyle="Solid" BorderWidth="1px"
                ShowBackButton="False" BackColor="WhiteSmoke" 
                ToolBarItemHoverBackColor="GhostWhite" 
                ToolBarItemPressedHoverBackColor="Gainsboro" SizeToReportContent="false">
            </rsweb:ReportViewer>
	    </form>
        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () { $("[id$='Toolbar'] > div > div").children().css("display", "inline"); });
        </script>
	</body>
</html>
