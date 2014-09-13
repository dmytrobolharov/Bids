<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Trade.ascx.vb" Inherits="plmOnApp.Image_Catalog_Trade" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:datagrid id="dgTrade" Width="100%" CellPadding="0" runat="server" AllowSorting="false" DataKeyField="TeamID"
	AutoGenerateColumns="false" PageSize="50" BorderWidth="0">
	<SelectedItemStyle BorderStyle="None"></SelectedItemStyle>
	<EditItemStyle BorderStyle="None"></EditItemStyle>
	<AlternatingItemStyle Height="20px" BorderStyle="None" CssClass="font" BackColor="AliceBlue"></AlternatingItemStyle>
	<ItemStyle Height="20px" BorderStyle="None" CssClass="font" BackColor="#ffffff"></ItemStyle>
	<HeaderStyle Height="25px" BorderStyle="None" CssClass="TableHeaderOver"></HeaderStyle>
	<FooterStyle BorderStyle="None"></FooterStyle>
	<Columns>
		<asp:TemplateColumn>
            <HeaderTemplate>
			    <asp:Label id="lblHdrCustomer" Text='<%#GetSystemText("Customer") %>' runat="server" />
			</HeaderTemplate>		
			<ItemTemplate>
				<asp:Label id="lblCustomer" runat="server" Width="200"></asp:Label>
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
		    <HeaderTemplate>
			    <asp:Label id="lblHdrDateSent" Text='<%#GetSystemText("Date Sent") %>' runat="server" />
			</HeaderTemplate>		
			<ItemTemplate>
				<asp:Label id="lblImageCatalogStatusDate" runat="server"></asp:Label>
			</ItemTemplate>
		</asp:TemplateColumn>
	</Columns>
	<PagerStyle Visible="False" BorderStyle="None"></PagerStyle>
</asp:datagrid>
