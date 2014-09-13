<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQueue_TechPack_Style_Search.aspx.vb" Inherits="plmOnApp.BatchQueue_TechPack_Style_Search1" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_List_Image" Src="../Style/Style_List_Image.ascx" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle">Style Search</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>

	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10">
					    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
					</td>
					<td>
					    <asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton>
						<cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE" Visible="False"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				</tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<asp:PlaceHolder id="phStyle" runat="server"></asp:PlaceHolder>
			<asp:PlaceHolder id="phStyleGrid" runat="server"></asp:PlaceHolder>
		</form>
	</body>
</html>
