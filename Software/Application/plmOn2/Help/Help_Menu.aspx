<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Help_Menu.aspx.vb" Inherits="plmOnApp.Help_Menu" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register src="Header1.ascx" tagname="HelpHeader" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
		<title>Help Menu</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <style type="text/css">
            div.RadTreeView_Default,
            div.RadTreeView_Default a.rtIn,
            div.RadTreeView_Default .rtEdit .rtIn input
            {
                color: #000000;
                font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
                font-size:8pt;
                font-weight: bold;
                }
         
            div.RadTreeView_Default .rtSelected .rtIn
            {
                color: #000000;
                }
             
            div.RadTreeView_Default .rtHover .rtIn
            {
                Text-Decoration: underline; 
                color: #CC0000; 
                }
	        
            div.RadTreeView_Default .rtHover .rtIn,
            div.RadTreeView_Default .rtSelected .rtIn {
                background: none !important;
                border: none !important;
                padding: 4px 3px 3px !important;
            }
        </style>
	</head>
	<body>
		<form id="frmMenu" method="post" runat="server">
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            </telerik:RadScriptManager>
            <uc1:HelpHeader ID="TreeHeader" runat="server" />
            <%--style="white-space:normal"--%>
            <telerik:RadTreeView ID="rtvHelp" runat="server" Skin="Default" EnableEmbeddedSkins="true">
            </telerik:RadTreeView>
		</form>
	</body>
</html>