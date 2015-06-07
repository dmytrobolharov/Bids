<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Variation_New.aspx.vb" Inherits="plmOnApp.Style_Variation_New" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />
<html>
	<head>
		<title>New Set</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" OnClientClick="return btnClose_Click()" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="100%"></td>
				</tr>
			</table>
			<table bgColor="#ffffff" border="0" width="100%">
				<tr>
					<td width="50">&nbsp;</td>
					<td>&nbsp;
						<asp:label id="lblOptions" runat="server" CssClass="fontHead">Please select options...</asp:label><BR>
						<asp:radiobuttonlist id="rbSetType" runat="server" CssClass="fontHead" AutoPostBack="True">
							<asp:ListItem Value="N">New Set</asp:ListItem>
							<asp:ListItem Value="C">Copy Set</asp:ListItem>
						</asp:radiobuttonlist></td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
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
