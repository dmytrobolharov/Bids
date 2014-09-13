<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Material_Style_Custom_Where.ascx.vb" Inherits="plmOnApp.Material_Style_Custom_Where" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<asp:datalist id="DataList1" GridLines="Both" RepeatDirection="Horizontal" RepeatColumns="4" BackColor="White"
	BorderWidth="0px" Width="100%" runat="server"
	DataKeyField="StyleID">
	<ItemStyle VerticalAlign="Top"></ItemStyle>
	<ItemTemplate>
		<asp:PlaceHolder ID="plhCustomItem" runat="server" ></asp:PlaceHolder>
	</ItemTemplate>
</asp:datalist>