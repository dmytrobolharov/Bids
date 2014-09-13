<%@ Control Language="vb" AutoEventWireup="false" Codebehind="QuoteItem_New.ascx.vb" Inherits="plmOnApp.QuoteItem_New" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:DataGrid id="dgQuote" runat="server" DataKeyField="StyleQuoteItemId" BorderColor="Silver" BorderStyle="Solid"
	BorderWidth="1px" OnItemDataBound="dgQuote_ItemDataBound" Width="400px" AutoGenerateColumns="False"
	ShowHeader="true">
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	<Columns>
		<asp:TemplateColumn>
			<ItemStyle Width="25px"></ItemStyle>
			<ItemTemplate>
				<div align="center">
					<asp:Image id="imgQuote" runat="server" ImageUrl="../System/Icons/icon_quote.gif"></asp:Image>
				</div>
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
			<HeaderTemplate>
				<asp:Label id="lblQuoteVendorHeader" runat="server">Vendor</asp:Label>
			</HeaderTemplate>
			<ItemTemplate>
				<asp:Label id="lblQuoteVendor" runat="server" />
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
			<HeaderTemplate>
				<asp:Label id="lblQuoteDateHeader" runat="server">Date</asp:Label>
			</HeaderTemplate>
			<ItemTemplate>
				<asp:Label id="lblQuoteDate" runat="server" />
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
			<HeaderTemplate>
				<asp:Label id="lblStyleHeader" runat="server"></asp:Label>
			</HeaderTemplate>
			<ItemTemplate>
				<asp:Label id="lblStyle" runat="server"></asp:Label>
			</ItemTemplate>
		</asp:TemplateColumn>
	</Columns>
</asp:DataGrid>
