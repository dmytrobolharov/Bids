<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Desk_Trade.ascx.vb" Inherits="plmOnApp.SampleRequest_Desk_Trade" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:DataGrid id="dgTrade" runat="server" DataKeyField="SampleRequestID">
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
	<PagerStyle Visible="False"></PagerStyle>
</asp:DataGrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
