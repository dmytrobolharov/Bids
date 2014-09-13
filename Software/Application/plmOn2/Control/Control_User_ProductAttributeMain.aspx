<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_User_ProductAttributeMain.aspx.vb" Inherits="plmOnApp.Control_User_ProductAttributeMain" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>

		<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td><cc1:confirmedimagebutton id="btnSave" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_save.gif&PL=EN-US"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnDelete" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_delete.gif" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_close.gif" Message="NONE" Visible="False"></cc1:confirmedimagebutton></td>
				<td class="FontHead" align="right" width="75"></td>
				<td width="40"></td>
				<td></td>
			</tr>
		</table>
		
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                        Font-Size="X-Large" ForeColor="#999999"></asp:label></td>
			</tr>
		</table>
		<table cellSpacing="2" cellPadding="0" width="100%" border="0" style="background-color: #FFFFFF">
			<tr>
				<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				<td></td>
			</tr>
		</table>
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="top"></td>
			</tr>
		</table>
					    
    </div>
    </form>
</body>
</html>
