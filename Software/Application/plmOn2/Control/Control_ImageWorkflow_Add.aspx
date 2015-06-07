<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_ImageWorkflow_Add.aspx.vb" Inherits="plmOnApp.Control_ImageWorkflow_Add" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title runat="server" id="PageTitle">Add Workflow Type</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tbody>
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td valign="middle" align="left" width="400">
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.close(); return false;"></cc1:ConfirmedImageButton>
                </td>
                <td>
                </td>
            </tr>
        </tbody>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td colspan="4">
                <table width="100%" align="center">
                    <tr>
                        <td align="center" width="40%">
                            <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fonthead">
                                <asp:Label ID="lblAvailable" runat="server"></asp:Label></b></font>
                        </td>
                        <td width="10%">
                        </td>
                        <td align="center" width="40%">
                            <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fonthead">
                                <asp:Label ID="lblSelected" runat="server"></asp:Label>
                            </b></font>
                        </td>
                        <td width="10%">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="40%">
                            <asp:ListBox ID="lstSelect" runat="server" BorderStyle="Outset" SelectionMode="Multiple" Height="250px"
                                Width="250px" CssClass="fonthead"></asp:ListBox>
                        </td>
                        <td align="center" width="10%" class="fonthead">
                            (+/-)<br>
                            <br>
                            <asp:ImageButton ID="btnaddall" runat="server"></asp:ImageButton><br>
                            <asp:ImageButton ID="btnadditem" runat="server"></asp:ImageButton><br>
                            <asp:ImageButton ID="btnremoveitem" runat="server"></asp:ImageButton><br>
                            <asp:ImageButton ID="btnremoveall" runat="server"></asp:ImageButton><br>
                        </td>
                        <td align="center" width="40%">
                            <asp:ListBox ID="lstSelected" Width="250px" Height="250px" SelectionMode="Multiple" runat="server" CssClass="fonthead">
                            </asp:ListBox>
                        </td>
                        <td align="center" width="10%" class="fonthead">
                            <asp:Label ID="lblSort" runat="server"></asp:Label><br>
                            <br>
                            <asp:ImageButton ID="btnColmoveup" runat="server" /><br>
                            <asp:ImageButton ID="btnColmovedwn" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>