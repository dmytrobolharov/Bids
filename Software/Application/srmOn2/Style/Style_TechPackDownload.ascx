<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_TechPackDownload.ascx.vb" Inherits="srmOnApp.Style_TechPackDownload" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<TABLE class="TableHeader" cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD width="50%" height="20" align="left"><IMG src="../System/Icons/icon_package.gif">&nbsp;&nbsp;<asp:label id="lblNewTechPack" runat="server">New Tech Pack</asp:label></TD>
		<TD width="50%"  align="right"><asp:label ID="lblVwTechPack" runat="server" CssClass="fontHead">View all (0)</asp:label></TD>
	</TR>
</TABLE>
<asp:DataGrid id="dgTechPack" runat="server" DataKeyField="TechPackId" BorderColor="Silver" BorderStyle="Solid"
	BorderWidth="1px" OnItemDataBound="dlTechPack_ItemDataBound" Width="100%" AutoGenerateColumns="False"
	ShowHeader="true">
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	<Columns>
		<asp:TemplateColumn>
			<ItemStyle Width="25px"></ItemStyle>
			<ItemTemplate>
				<div align="center">
					<asp:Label id="lblTechPackIconUrl" runat="server" />
				</div>
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
			<HeaderTemplate>
				<asp:Label id="lblTechPackDateHeader" runat="server"><%#GetSystemText("TP Date")%></asp:Label>
			</HeaderTemplate>
			<ItemTemplate>
				<asp:Label id="lblTechPackDate" runat="server" />
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

