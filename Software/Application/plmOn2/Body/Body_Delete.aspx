<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_Delete.aspx.vb" Inherits="plmOnApp.Body_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="htmlHeader" runat=server ></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">

			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="#ffffff">
				<TR>
					<TD width="10"></TD>
					<TD width="50" height="50"><IMG src="../System/Icons/icon_critical32.gif"></TD>
					<TD>
						<asp:Label id="lblHeader" runat="server" CssClass="fontHead">You are about to delete this body</asp:Label></TD>
				</TR>
			</TABLE>
			<HR>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD width="50"></TD>
					<TD>
						<asp:Label id="lblWarning" runat="server" CssClass="font"></asp:Label></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD width="50"></TD>
					<TD>&nbsp;</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD width="50"></TD>
					<TD>
						<cc1:confirmedimagebutton id="btnDelete" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="ntnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
					<TD></TD>
				</TR>
			</TABLE>
			
    </form>
</body>
</html>
