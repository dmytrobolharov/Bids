﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_BOL_Add_Exception.aspx.vb" Inherits="plmOnApp.Style.BOL.Style_BOL_Add_Exception" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
		<title>Control</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnAddClose" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_add.gif" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnAddNew" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_add_and_new.gif" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_close.gif" Message="NONE"
							CausesValidation="False"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			    
			<table height="90%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>
									<div align="right"><asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"></asp:label></div>
								</td>
							</tr>
						</table>
						
						<table height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr vAlign="top">
								<td width="10">&nbsp;</td>
								<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
							</tr>
						</table>
					
						<table height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr vAlign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>			    
    
    </div>
    </form>
</body>
</html>
