<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component2_Image.ascx.vb" Inherits="plmOn2Report.Style_Component2_Image" targetSchema="http://schemas.microsoft.com/mobile/html32template" enableViewState="False"%>
<asp:datagrid id="DataGrid1" PageSize="200" AutoGenerateColumns="False" GridLines="Horizontal"
	BackColor="White" runat="server" EnableViewState="False" Width="100%">
	<AlternatingItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderStyle="Solid" BorderColor="Black"></AlternatingItemStyle>
	<ItemStyle Font-Size="6pt" Font-Names="Tahoma" BorderWidth="0px" BorderStyle="Solid" BorderColor="Black"></ItemStyle>
	<HeaderStyle Font-Size="6pt" Font-Names="Tahoma" Font-Bold="True" ForeColor="Black" CssClass="fontHead"
		BackColor="WhiteSmoke"></HeaderStyle>
	<Columns>
		<asp:TemplateColumn  ItemStyle-BorderStyle="Solid" ItemStyle-BorderColor="#000000"
			HeaderStyle-BorderStyle="Solid" HeaderStyle-BorderWidth="1" HeaderStyle-BorderColor="#000000" ItemStyle-BorderWidth="1">
			<HeaderStyle Width="75px"></HeaderStyle>
			<HeaderTemplate>
                <asp:Label ID="lblImage" runat="server" ></asp:Label></HeaderTemplate>
			<ItemTemplate>
				<TABLE cellSpacing="0" cellPadding="0" width="25" border="0">
					<TR>
						<TD>
							<asp:Image id="imgDesign" runat="server"></asp:Image></TD>
					</TR>
				</TABLE>
			</ItemTemplate>
		</asp:TemplateColumn>
	</Columns>
</asp:datagrid>
