<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Search.aspx.vb" Inherits="plmOnApp.Search" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="frmSearch" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <table width="100%" height="27" border="0" cellpadding="0" cellspacing="0" class="TableHeader">
        <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td align="left" width="325">&nbsp;</td>
            </tr>
    </table>
    <table height="10" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td width="10">&nbsp;</td>
            <td width="700"><asp:TextBox ID="txtSearch" runat="server" Width="700px" Height="20px"></asp:TextBox></td>
            <td><telerik:RadComboBox runat="server" ID="cmbCulture" autopostback="true" height="150px" MarkFirstMatch="true" HighlightTemplatedItems="true" OnItemDataBound="cmbCulture_ItemDataBound">
                <ItemTemplate>
                    <div class="col1"><%#DataBinder.Eval(Container.DataItem, "CultureLanguage")%></div>
                </ItemTemplate>
                </telerik:RadComboBox>
            </td>
            <td><cc1:ConfirmedImageButton ID="btnSearch" runat="server" Message="NONE" ToolTip="Search"></cc1:ConfirmedImageButton></td>
        </tr>
        <tr>
            <td width="10">&nbsp;</td>
            <td width="800" colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td width="10">&nbsp;</td>
            <td width="800" colspan="3"><asp:Label ID="lblResult" runat="server" Text="" Width="800"></asp:Label></td>
        </tr>
    </table>
    </form>
</body>
</html>
