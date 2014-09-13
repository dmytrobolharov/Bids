<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calendar_Page_FrameMenu.aspx.vb" Inherits="plmOnApp.Calendar_Page_FrameMenu" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Calendar Menu</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" /> 
</head>
<body>
    <form id="form1" runat="server">
    <div class="wrapper">
    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="middle" align="left">
                <div>
                    &nbsp;
                    <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif" OnClientClick="parent.location.href = 'Calendar_List.aspx';"></asp:ImageButton>
                    &nbsp;
                    <asp:ImageButton ID="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:ImageButton></div>
            </td>
        </tr>
    </table>

    <cc1:YsTreeView ID="YSTreeView1" runat="server"></cc1:YsTreeView>

    </form>
</body>
</html>
