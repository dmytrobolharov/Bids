<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Add_Toolbar.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Add_Toolbar" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style_Component_Add_Toolbar</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80">
                        <cc1:BWImageButton id="btnMaterialNew" runat="server" Message="NONE"></cc1:BWImageButton>
                    </td>
					<td width="80"></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>
	</body>
</html>
