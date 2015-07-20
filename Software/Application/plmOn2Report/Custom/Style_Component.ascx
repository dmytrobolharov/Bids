<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component.ascx.vb" Inherits="plmOn2Report.Style_Component2" targetSchema="http://schemas.microsoft.com/mobile/html32template" enableViewState="False"%>
<asp:HiddenField id="hdnSortOrder" value="MaterialSort, MaterialNo" runat="server" />
<asp:datagrid id="DataGrid1" PageSize="200" AutoGenerateColumns="False" GridLines="Horizontal" runat="server" EnableViewState="False" Width="100%" DataKeyField="StyleMaterialID">
	<AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></AlternatingItemStyle>
	<ItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderWidth="0px" BorderStyle="Solid" BorderColor="Black"></ItemStyle>
	<HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" CssClass="fontHead" BackColor="WhiteSmoke"></HeaderStyle>
</asp:datagrid>
