<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Feature_Edit.aspx.vb" Inherits="plmOnApp.Style_Feature_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style Feature</title>
		
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table cellspacing="2" cellpadding="0" width="100%" border="0" bgColor="#ffffff">
				<tr>
					<td width="900">
						<uc1:Style_Header id="Style_Header1" runat="server"></uc1:Style_Header></td>
					<td></td>
				</tr>
			</table>
			<br>
			<uc1:Style_Comment id="Style_Comment1" runat="server"></uc1:Style_Comment></td>
			<br>
			<table cellspacing="2" cellpadding="0" width="100%" border="0" bgColor="#ffffff">
				<tr>
					<td></td>
				</tr>
			</table>
			<table cellspacing="2" cellpadding="0" width="100%" border="0" bgColor="#ffffff">
				<tr>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
					<td></td>
				</tr>
			</table>
			<table cellspacing="2" cellpadding="0" width="100%" border="0" bgColor="#ffffff" height="200">
				<tr>
					<td></td>
				</tr>
			</table>
		</form>
	</body>
</html>
