<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Material_Link_Item.ascx.vb" Inherits="plmOnApp.Material_Link_Item" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:datagrid id="DataGrid1" runat="server" Width="100%">
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
	<Columns>
		<asp:TemplateColumn HeaderStyle-Width="75">
			<ItemTemplate>
				<TABLE cellSpacing="0" cellPadding="0" width="25" border="0">
					<TR>
						<TD>
							<asp:Image id="ImgComment" runat="server" ImageUrl="../System/Icons/icon_comment.gif" ToolTip='<%#GetSystemText("Material Comments")%>...'></asp:Image></TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="25" border="0">
					<TR>
						<td>
							<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton></td>
					</TR>
				</TABLE>
			</ItemTemplate>
		</asp:TemplateColumn>
	</Columns>
</asp:datagrid>
