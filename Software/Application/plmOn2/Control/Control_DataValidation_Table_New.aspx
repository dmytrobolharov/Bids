<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DataValidation_Table_New.aspx.vb" Inherits="plmOnApp.Control_DataValidation_Table_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title runat="server" id="PageTitle">New Lookup Table Item</title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    </head>
    <body ms_positioning="GridLayout">
        <form id="Form1" method="post" runat="server">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="80">
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                </td>
            </tr>
        </table>
        <table height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee"
            border="0">
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table height="90%" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top" bgcolor="#ffffff">
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td>
                                <div align="right">
                                    <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="pnlMaterial" runat="server">
                        <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr valign="top">
                                <td width="10">
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table height="100" cellspacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg" border="0">
                        <tr valign="top">
                            <td width="33%">
                            </td>
                            <td width="33%">
                            </td>
                            <td width="33%">
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="10%" bgcolor="#f5f5f5">
                    &nbsp;
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
