﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkflowItemNew.aspx.vb" Inherits="srmOnApp.Style_WorkflowItemNew" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title>New Workflow Item</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>

				<td nowrap="nowrap" width="650">
				    <cc1:confirmedimagebutton id="btnAddItem" runat="server"  Message="NONE"></cc1:confirmedimagebutton>&nbsp;                    
				    <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
				</td>

			</tr>
		</table>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">New</asp:label></td>
			</tr>
		</table>
		<br />
        <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
	
		
    </form>
</body>
</html>
