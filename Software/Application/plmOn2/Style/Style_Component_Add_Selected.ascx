<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Add_Selected.ascx.vb" Inherits="plmOnApp.Style.Material.ctrl_Style_Component_Add_Selected" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<asp:datagrid id="DataGrid1" runat="server">
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
</asp:datagrid>
