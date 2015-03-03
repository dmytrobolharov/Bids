<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_SizeRange.aspx.vb" Inherits="plmOnApp.Style_SizeRange" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Select...</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" OnClientClick="return btnClose_Click()"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="100%" class="fontHead" height="35">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<asp:label id="lblAvailableSizeRange" runat="server" CssClass="fontHead">Availabe Size Range...</asp:label>
					</td>
				</tr>
			</table>
			<table id="Table1" cellSpacing="1" cellpadding="1" width="100%" border="0">
				<tr>
					<td width="25"></td>
					<td>
						<asp:Label id="lblWarning" runat="server" CssClass="font"></asp:Label></td>
					<td></td>
				</tr>
			</table>
			<BLOCKQUOTE>
				<asp:RadioButtonList id="rbSizeRange" runat="server" CssClass="fontHead"></asp:RadioButtonList></BLOCKQUOTE>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
