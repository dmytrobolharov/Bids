<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Workflow_Material_New.aspx.vb" Inherits="plmOnApp.Control_Workflow_Material_New" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>New material workflow</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
    <meta name="vs_defaultClientScript" content="JavaScript" />
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td width="80">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <div align="right">
                                <asp:Label ID="lblNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0"></asp:Label></div>
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
                <table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" background="../System/Images/MiddleFill.jpg">
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
