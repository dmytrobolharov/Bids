<%@ Control Language="vb" AutoEventWireup="false" Codebehind="LinePlan_Item_ProductColor.ascx.vb" Inherits="plmOnApp.LinePlan_Item_ProductColor" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:datalist id="Datalist1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
	Width="100%" RepeatColumns="4" RepeatLayout="Table" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1"
	ItemStyle-BorderColor="Gainsboro" ItemStyle-VerticalAlign="Top" CellSpacing="2" CellPadding="2">
	<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
	<ItemTemplate>
		<TABLE border="0" cellpadding="0" cellspacing="0">
			<TR>
				<TD valign="top">
					<asp:Image id="imgLineImage" runat="server"></asp:Image></TD>
			</TR>
			<TR>
				<TD>
					<asp:Label id="lblColorNo" runat="server"></asp:Label></TD>
			</TR>
			<TR>
				<TD>
					<asp:Label id="lblColorName" runat="server"></asp:Label></TD>
			</TR>
		</TABLE>
	</ItemTemplate>
</asp:datalist>
