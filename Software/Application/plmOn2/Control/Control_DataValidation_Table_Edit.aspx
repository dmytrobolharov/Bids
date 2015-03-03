<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DataValidation_Table_Edit.aspx.vb" Inherits="plmOnApp.Control_DataValidation_Table_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
    <head>
        <title runat="server" id="PageTitle">Edit Lookup Table Item</title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
        <meta content="JavaScript" name="vs_defaultClientScript" />
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    </head>
    <body>
        <form id="Form1" method="post" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager" runat="server" />
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveNew" runat="server" Message="NONE" ></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnDelete" runat="server"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                </td>
                <td class="FontHead" align="right" width="75">
                </td>
                <td width="40">
                </td>
                <td>
                </td>
            </tr>
        </table>
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <table cellspacing="2" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top">
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
