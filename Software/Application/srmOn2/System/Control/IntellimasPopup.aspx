<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IntellimasPopup.aspx.vb" Inherits="srmOnApp.IntellimasPopup" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Select</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="../CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../CSS/Grid.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        function SelectWindowCustom(sValue, sTxtBox) {

            var destForm = window.opener.document["Form1"] | window.opener.document["form1"];

            if (destForm != null) {
                destForm[sTxtBox].value = "";
                destForm[sTxtBox].value = sValue;
            }

        }
    </script>
    <style type="text/css">
        .intellimas-links {
        	margin: 0px;
            font-weight: bold;
            font-size: 10pt;
            padding: 20px;
            list-style-type: none;
        }
        
        .intellimas-links li {
            margin-bottom: 10pt;
        }
    </style>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table id="Table1" style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Intellimas</asp:Label>
            </td>
        </tr>
    </table>
    <ul class="intellimas-links">
        <li>
            <asp:HyperLink runat="server" ID="hypIntellimasClient" Text="Client" Target="_blank"></asp:HyperLink></li>
        <li>
            <asp:HyperLink runat="server" ID="hypIntellimasAdmin" Text="Administration" Target="_blank"></asp:HyperLink></li>
        <li>
            <asp:HyperLink runat="server" ID="hypIntellimasLicense" Text="Apply License" Target="_blank"></asp:HyperLink></li>
    </ul>
    </form>
</body>
	<script type="text/javascript">
		function btnClose_Click() {
			<%= strExitScript %>
			return false;
		}
	</script>
</html>
