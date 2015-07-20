<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Color_PaletteSeason.ascx.vb" Inherits="plmOnApp.Color_PaletteSeason" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<asp:datagrid id="DataGrid1" runat="server"  EnableViewState="False" DataKeyField="ColorPaletteID">
    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
    </AlternatingItemStyle>
    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
    <headerStyle Height="20px" CssClass="TableHeader"></headerStyle>
    <PagerStyle Visible="False"></PagerStyle>
</asp:datagrid>
