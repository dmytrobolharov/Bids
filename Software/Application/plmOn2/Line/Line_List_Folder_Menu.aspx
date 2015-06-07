<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_Menu.aspx.vb" Inherits="plmOnApp.Line_List_Folder_Menu" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Production_Menu</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="left">&nbsp;
							<asp:imagebutton id="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif"></asp:imagebutton>&nbsp;
							<asp:imagebutton id="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:imagebutton></div>
					</td>
				</tr>
			</table>
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
		</form>
	</body>
</HTML>
