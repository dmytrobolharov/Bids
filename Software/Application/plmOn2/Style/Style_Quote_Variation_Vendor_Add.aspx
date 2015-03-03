<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_Variation_Vendor_Add.aspx.vb" Inherits="plmOnApp.Style.Quote.StyleQuoteVariationVendorAdd"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Add Vendors</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
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
			<asp:datagrid id="dgPartnerVendor" runat="server" AutoGenerateColumns="false" Width="400" DataKeyField="TradePartnerVendorID">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate" BackColor="White"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<INPUT id="checkAll" onclick="CheckAll(this);" type="checkbox" name="checkAll" runat="server">
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkSelect" runat="server"></asp:CheckBox>
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
		<SCRIPT language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkSelect") != -1 )
			e.checked= actVar ;
		}
		}
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
