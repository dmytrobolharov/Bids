<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Report_Main.aspx.vb" Inherits="YuniqueBI.Report_Main"%>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>	
	</head>
	<body>
		<form id="Form1" method="post" runat="server">

            
            
	        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                Font-Size="8pt" Height="100%" ProcessingMode="Remote" Width="100%" 
                BorderColor="Gray" 
                BorderStyle="Solid" BorderWidth="1px" 
                ShowBackButton="True" BackColor="WhiteSmoke" 
                ToolBarItemHoverBackColor="GhostWhite" 
                ToolBarItemPressedHoverBackColor="Gainsboro">
            </rsweb:ReportViewer>
            
            
	    </form>
        
	</body>
</html>
