<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_UserProfileMenu.aspx.vb" Inherits="plmOnApp.Control_UserProfileMenu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Control</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        form {
        	margin:0;
        	padding:0;
        }
    </style>
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table style="height: 95%">
        <tr>
            <td valign="top">
                <cc1:YsTreeView ID="YSTreeView1" runat="server"></cc1:YsTreeView>
            </td>
        </tr>
        <tr>
            <td valign="bottom">
                <cc2:BWImageButton ID="imgUserAvatar" runat="server" />                
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label ID="lblUserFullname" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
