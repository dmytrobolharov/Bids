<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_UserProfile_Profile.aspx.vb" Inherits="plmOnApp.Control_UserProfile_Profile" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>User Profile</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
            height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;
                    <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                        ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="">
                </td>
                <td>
                    <cc1:confirmedimagebutton id="btnSave" runat="server" message="NONE"></cc1:confirmedimagebutton>                    
                </td>
                <td class="FontHead" align="right" width="75">&nbsp;</td>
                <td width="40">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table cellspacing="2" cellpadding="0" width="100%" border="0">
            <tr>
                <td width="75%">
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
                <td>
                    <input type="file" id="uplUserAvatar" runat="server" /><br />
                    <cc1:BWImageButton ID="imgAvatar" runat="server" /> <br />
                    <cc1:ConfirmedImageButton ID="btnRemoveAvatar" runat="server" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
