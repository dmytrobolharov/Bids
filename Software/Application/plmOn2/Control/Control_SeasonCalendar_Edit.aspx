<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SeasonCalendar_Edit.aspx.vb" Inherits="plmOnApp.Control_SeasonCalendar_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Partner Type Edit</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
</head>
<body>
	<form id="Form1" method="post" runat="server">
		<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
				<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
				</cc1:ConfirmedImageButton><cc1:ConfirmedImageButton id="btmImgDelete" runat="server"  CausesValidation="false"></cc1:ConfirmedImageButton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
			</tr>
		</table>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
			</tr>
		</table>
		<table cellspacing="2" cellpadding="0" width="100%" border="0" bgcolor="#ffffff" style="BORDER-TOP: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white">
			<tr>
				<td><br />
					<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
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
