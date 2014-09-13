<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_FitVideo_Popup.aspx.vb" Inherits="plmOnApp.SampleRequest_FitVideo_Popup" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title><% GetSystemText("View Video")%></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="top">
                <cc1:ConfirmedImageButton ID="btnDownload" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.close();"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <asp:Literal ID="lVideo" runat="server"></asp:Literal>
    </form>
</body>
</html>
