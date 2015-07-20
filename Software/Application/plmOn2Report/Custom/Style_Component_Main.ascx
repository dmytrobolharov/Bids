<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Main.ascx.vb" Inherits="plmOn2Report.Style_Component_Main" targetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" enableViewState="False"%>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
    <tr><td>
        <font face="Tahoma" size="1"><asp:label ID="lblComments" visible="False" runat ="server" ></asp:label></font>
    </td></tr>
</table>
<asp:HiddenField id="hdnCommentSortOrder" value="MDate DESC" runat="server" />
<asp:datagrid id="DataGrid2" PageSize="200" AutoGenerateColumns="False" GridLines="Horizontal" runat="server" EnableViewState="False" Width="100%">
	<AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></AlternatingItemStyle>
	<ItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderWidth="0px" BorderStyle="Solid" BorderColor="Black"></ItemStyle>
	<HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" CssClass="fontHead" BackColor="WhiteSmoke"></HeaderStyle>
</asp:datagrid>
<asp:Panel id="Panel1" runat="server">
	<table borderColor="gold" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffff99" border="1">
		<tr><td>
            <font face="Tahoma" size="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblMaterialNotFound" runat="server"></asp:Label></font>
        </td></tr>
	</table>
</asp:Panel>
<asp:Panel id="Panel2" runat="server">
    <table cellSpacing="0" cellPadding="0" width="100%" border="0">
	    <tr>
		    <td><font face="Tahoma" size="1"><asp:label ID="lblMainMaterial"  runat ="server" ></asp:label> </font></td>
	    </tr>
    </table>
    <asp:HiddenField id="hdnSortOrder" value="MaterialSort, MaterialNo" runat="server" />
	<asp:datagrid id="dgMainMaterial" runat="server" EnableViewState="False" AutoGenerateColumns="False" GridLines="Horizontal" Width="100%" DataKeyField = "StyleMaterialID" style="border: 3px solid black;">
		<FooterStyle ForeColor="#000066"></FooterStyle>
		<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedItemStyle>
		<AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma"></AlternatingItemStyle>
		<ItemStyle Font-Size="6pt" Font-Names="Tahoma"></ItemStyle>
		<HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" CssClass="fontHead" BackColor="WhiteSmoke"></HeaderStyle>
	</asp:datagrid>
</asp:Panel>