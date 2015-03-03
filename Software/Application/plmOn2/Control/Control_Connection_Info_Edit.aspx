<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Connection_Info_Edit.aspx.vb"
    Inherits="plmOnApp.Control_Connection_Info_Edit" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Control</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="top">
            <td>
                <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
                    border="0" runat="server">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td>
                             <cc1:ConfirmedImageButton ID="btnSave" Visible="true" runat="server" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                             <cc1:ConfirmedImageButton ID="btnClose" OnClientClick="return btnClose_Click()" Visible="true" runat="server" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
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
