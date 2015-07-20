<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Menu.aspx.vb" Inherits="plmOnApp.Image_Catalog_Menu" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Menu</title>
		
		
		
		
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="left">
							<cc2:confirmedimagebutton id="btnNew" runat="server" ImageUrl="../System/icons/icon_form_new.gif" Message="NONE"
								ToolTip="Click here to add new catalog..."></cc2:confirmedimagebutton>&nbsp;
							<asp:imagebutton id="btnSearch" runat="server" ImageUrl="../System/icons/icon_search.gif"></asp:imagebutton>&nbsp;
							<asp:imagebutton id="btnRefresh" runat="server" ImageUrl="../System/icons/icon_refresh.gif"></asp:imagebutton>&nbsp;
							<asp:imagebutton id="btnImage" runat="server" ImageUrl="../System/icons/icon_image.gif" AlternateText="Click here to add image to folder..."></asp:imagebutton>&nbsp;
							<cc2:BWImageButton id="btnTrade" runat="server" ImageUrl="../System/Icons/icon_trade.gif"></cc2:BWImageButton>
						</div>
					</td>
				</tr>
			</table>
			<table class="TableHeaderOver" height="24" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="fontHead">
						<div align="center"><asp:Label id="lblHeader" runat="server" >Image Catalog</asp:Label>
						</div>
					</td>
				</tr>
			</table>
			<cc1:YSTreeView id="YSTreeView1" runat="server"></cc1:YSTreeView>
		</form>
	</body>
</HTML>
