<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LineAttributeMain.aspx.vb" Inherits="plmOnApp.LineAttributeMain" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td width="50" height="50">
                &nbsp;
            </td>
            <td nowrap>
                <asp:Label ID="lblHeader" runat="server" CssClass="fonthead"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                <table cellspacing="0" cellpadding="0" width="100%" align="center" bgcolor="#ffffff"
                    border="0">
                    <tr>
                        <td width="50">
                            &nbsp;
                        </td>
                        <td align="center" width="200">
                            <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fonthead">
                                <asp:Label ID="lblAvailable" runat="server"></asp:Label></b></font>
                        </td>
                        <td width="50">
                        </td>
                        <td align="center" width="200">
                            <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fonthead">
                                <asp:Label ID="lblSelected" runat="server"></asp:Label></b></font>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="center" width="200">
                            <asp:ListBox ID="lstSelect" BorderStyle="Outset" SelectionMode="Multiple" Height="250px"
                                Width="250px" CssClass="fonthead" runat="server"></asp:ListBox>
                        </td>
                        <td align="center" width="50">
                            <asp:ImageButton ID="btnaddall" runat="server"></asp:ImageButton><br />
                            <asp:ImageButton ID="btnadditem" runat="server"></asp:ImageButton><br />
                            <cc1:ConfirmedImageButton ID="btnremoveitem" runat="server" /><br />
                            <cc1:ConfirmedImageButton ID="btnremoveall" runat="server" /><br />
                        </td>
                        <td align="center" width="200">
                            <asp:ListBox ID="lstSelected" SelectionMode="Multiple" Height="250px" Width="250px"
                                CssClass="fonthead" runat="server"></asp:ListBox>
                        </td>
                        <td align="center" width="50">
                            <asp:ImageButton ID="btnColmoveup" runat="server"></asp:ImageButton><br />
                            <asp:ImageButton ID="btnColmovedwn" runat="server"></asp:ImageButton>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table style="border-top: gray thin solid; border-left-style: none; background-color: gainsboro"
        height="35" cellspacing="0" cellpadding="0" width="100%" bgcolor="gainsboro"
        border="0">
        <tr>
            <td align="center" width="50">
                &nbsp;
            </td>
            <td align="center" width="500">
                <asp:ImageButton ID="btnSave" runat="server"></asp:ImageButton>
                <asp:ImageButton ID="btnClose" runat="server" Visible="false"></asp:ImageButton>
            </td>
            <td align="center">
                &nbsp;
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
