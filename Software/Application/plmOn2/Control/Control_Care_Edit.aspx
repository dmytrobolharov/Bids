<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Care_Edit.aspx.vb"
    Inherits="plmOnApp.Control_Care_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Care Template</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" 
                    Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:confirmedimagebutton id="btnSaveNew" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                <cc1:ConfirmedImageButton ID="btmImgDeletePOM"
                        runat="server"  CausesValidation="false"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" OnClientClick="return btnClose_Click()"
                         Message="NONE" CausesValidation="false"></cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <br>
    <table cellspacing="2" cellpadding="0" width="100%" border="0" bgcolor="#ffffff"
        style="border-top: orange thin solid; border-left-style: none; background-color: white">
        <tr>
            <td width="900">
                <br>
                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
            </td>
            <td>
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
