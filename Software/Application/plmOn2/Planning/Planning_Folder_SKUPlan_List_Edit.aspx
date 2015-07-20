﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_SKUPlan_List_Edit.aspx.vb" Inherits="plmOnApp.Planning_Folder_SKUPlan_List_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<script language="javascript">
    function RefreshMenu() {
        try {
            parent.window.menu.location.href = parent.window.menu.location.href
        } catch (e) { }
    }
</script>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="middle" align="left">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSaveAndClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <hc1:planning_header id="PlanningHeader" runat="server" />
    <br />
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="False" DataKeyField="PlanningSKUHeaderID">
                    <AlternatingItemStyle Height="20px" Wrap="true" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" Wrap="true" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>                    
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
