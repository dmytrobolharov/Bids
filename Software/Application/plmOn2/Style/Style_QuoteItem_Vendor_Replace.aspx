<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_QuoteItem_Vendor_Replace.aspx.vb" Inherits="plmOnApp.Style.Quote.Style_QuoteItem_Vendor_Replace" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Replace Vendor</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
			<table height="35" cellSpacing="1" cellpadding="1" width="375" border="0">
				<tr>
					<td class="fontHead" style="WIDTH: 58px">
						<P align="center"><asp:Label ID="lblSrch" runat="server" Text="Search:"></asp:Label></P>
					</td>
					<td width="200"><asp:textbox id="txtSearch" runat="server" Width="250px"></asp:textbox></td>
					<td><asp:imagebutton id="btnSearch" runat="server" ></asp:imagebutton></td>
				</tr>
			</table>
			<asp:datagrid id="dgPartnerVendor" runat="server" Width="400" DataKeyField="TradePartnerVendorID"
				AutoGenerateColumns="false">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate" BackColor="White"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Width="25px"></HeaderStyle>
						<ItemTemplate>
							<cc1:ConfirmedImageButton id="btnSelect" runat="server"  Message='<%#GetSystemText("Are you sure you want to select this vendor?")%>'
								CommandName="Select"></cc1:ConfirmedImageButton>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderVendorCode" runat="server" CssClass="fontHead"><%#GetSystemText("Vendor Code")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblVendorCode" runat="server" CssClass="font"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderVendorName" runat="server" CssClass="fontHead"><%#GetSystemText("Vendor Name")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblVendorName" runat="server" CssClass="font"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderVendorCountry" runat="server" CssClass="fontHead"><%#GetSystemText("Country")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblVendorCountry" runat="server" CssClass="font"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid></form>
	</body>
</html>
