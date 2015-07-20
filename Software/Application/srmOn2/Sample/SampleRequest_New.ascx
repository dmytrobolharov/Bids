<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_New.ascx.vb" Inherits="srmOnApp.SampleRequest_New" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE class="TableHeader" id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD width="50%" height="20" align="left"><img src="../System/Icons/icon_ball_blue.gif" />&nbsp;&nbsp;<asp:label id="lblNewSample" runat="server">New Sample</asp:label></TD>
		<td width="50%"  align="right"><asp:label ID="lblViewAll" runat="server" CssClass="fontHead">View all (0)</asp:label></td>
	</TR>
</TABLE>
<asp:DataGrid id="dgQuote" runat="server" DataKeyField="SampleRequestTradeID" BorderColor="Silver"
	BorderStyle="Solid" BorderWidth="1px"  Width="100%"
	AutoGenerateColumns="False" ShowHeader="true">
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	<Columns>
		<asp:TemplateColumn>
			<ItemStyle Width="25px"></ItemStyle>
			<ItemTemplate>
				<div align="center">
					<asp:Image id="imgQuote" runat="server" ></asp:Image>
				</div>
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
			<HeaderTemplate>
				<asp:Label id="lblQuoteVendorHeader" runat="server"><%# GetSystemText(If(NewPartnerManagement, "Trade partner", "Vendor"))%></asp:Label>
			</HeaderTemplate>
			<ItemTemplate>
				<asp:Label id="lblQuoteVendor" runat="server" />
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
			<HeaderTemplate>
				<asp:Label id="lblQuoteDateHeader" runat="server"><%#GetSystemText("Date")%></asp:Label>
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
