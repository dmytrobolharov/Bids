<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Dash_Main.aspx.vb" Inherits="YuniqueBI.Dash_Main"%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>	
        <style type="text/css">
        .DropdownLabel 
        {
            font-family:Verdana;
            font-size:8pt;
            font-weight:bold;
        
        }
        .Dropdown
        {
            font-family:Verdana;
            font-size:8pt;
        
        }
    </style>
	</head>

	<body>
		<form id="Form1" method="post" runat="server">
            <table border="0" cellspacing="5" cellpadding="5" >
                <tr>
                    <td>
                        &nbsp; &nbsp;<asp:Label runat="server" ID="lblLanguage" CssClass="DropdownLabel">Language:</asp:Label>
                    </td>
                    <td>
                        &nbsp;<asp:DropDownList ID="ddlLanguage" runat="server" AutoPostBack="false" Width="200" CssClass="Dropdown"></asp:DropDownList>
                    </td>
                      <td>
                        <asp:button id="Button1" runat="server" CssClass="DropdownLabel" Text="GO" /> 
                    </td>
                    <td>                        
                        <asp:button id="btnEditReport" runat="server" CssClass="DropdownLabel" Text="Edit Report" /> 
                    </td>  
                     <td>
                        <asp:hiddenfield id="lblSourcingHeaderid" runat="server"  /> 
                        <asp:hiddenfield id="lblCurrentReport" runat="server"  /> 
                    </td>           
                </tr>
            </table>
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                Font-Size="8pt" Height="100%" ProcessingMode="Remote" Width="100%" 
                PromptAreaCollapsed="True" ShowParameterPrompts="True" BorderColor="Gray" 
                BorderStyle="Solid" BorderWidth="1px" DocumentMapCollapsed="True" 
                ShowBackButton="True" BackColor="WhiteSmoke" 
                ToolBarItemHoverBackColor="GhostWhite" 
                ToolBarItemPressedHoverBackColor="Gainsboro" HyperlinkTarget="" 
                SizeToReportContent="True">
            </rsweb:ReportViewer>
	    </form>

        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("[id$='Toolbar'] > div > div").children().css("display", "inline");
            });
        </script>
	</body>
</html>
