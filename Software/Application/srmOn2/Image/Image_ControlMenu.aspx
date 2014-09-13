<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Image_ControlMenu.aspx.vb" Inherits="srmOnApp.Image_ControlMenu" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Image Menu</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <cc1:YsTreeView ID="YSTreeView1" runat="server"></cc1:YsTreeView>
        <table cellpadding="0" cellspacing="0" style="margin-top:15px;" width="100%">
            <tr><td align="center" style="padding-bottom:10px;"><img runat="server" id="imgImage" src="" alt="" /></td></tr>
            <tr><td align="center"><asp:Label runat="server" ID="txtCode"></asp:Label></td></tr>
            <tr><td align="center"><asp:Label runat="server" ID="txtDesc"></asp:Label></td></tr>
        </table>
    </form>
</body>
</html>
