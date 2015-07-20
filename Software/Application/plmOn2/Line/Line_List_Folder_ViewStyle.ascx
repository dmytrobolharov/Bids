<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_ViewStyle.ascx.vb" Inherits="plmOnApp.Line_List_Folder_ViewStyle" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	<TR>
		<TD vAlign="top"><asp:datalist id="Datalist1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
				RepeatColumns="1" RepeatLayout="Table" DataKeyField="LineFolderItemId">
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
					VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></TD>
	</TR>
</TABLE>
