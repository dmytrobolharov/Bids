<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_UserProfile_Password.aspx.vb" Inherits="plmOnApp.Control_UserProfile_Password" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Change Password</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;
                <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="">
            </td>
            <td width="100%">
                <cc1:confirmedimagebutton id="btnSave" runat="server" message="NONE"></cc1:confirmedimagebutton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:Label ID="lblMsg" CssClass="fontRed" runat="server"></asp:Label>
    <table cellspacing="0" cellpadding="0" width="270" border="0">
        <tr>
            <td width="120">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="fontHead" width="120">
                <asp:Label ID="lblCurrentPassword" runat="server"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtCurrentPassword" TextMode="Password" runat="server" CssClass="font" MaxLength="25" Width="150px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="fontHead" style="height: 20px" width="120">
                <asp:Label ID="lblPassword" runat="server"></asp:Label>
            </td>
            <td style="height: 20px">
                <asp:TextBox ID="txtPassword1" onfocus="this.select();" runat="server" CssClass="font" MaxLength="15"
                    Width="150px" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="fontHead" width="120">
                <asp:Label ID="lblConfirmPassword" runat="server"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPassword2" onfocus="this.select();" runat="server" CssClass="font" MaxLength="15"
                    Width="150px" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="fontHead" id="AutoGenerate" colspan="2" runat="server">
                <asp:Label ID="lblAutogenerate" runat="server"></asp:Label>
                <input id="chkAutoPwd" onclick="Check(this);" type="checkbox" runat="server" />
            </td>
        </tr>
    </table>
    </form>
    <script type="text/javascript">
        function Check(obj) {
            document.form1["txtPassword1"].disabled = obj.checked;
            document.form1["txtPassword2"].disabled = obj.checked;
        }
    </script>
</body>
</html>
