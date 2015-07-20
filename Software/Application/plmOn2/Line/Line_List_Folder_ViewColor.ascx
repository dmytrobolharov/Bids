<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_ViewColor.ascx.vb" Inherits="plmOnApp.Line_List_Folder_ViewColor" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table width="100%">
<tr>
<td height="75">
<asp:datalist id="Datalist1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
 RepeatColumns="5" RepeatLayout="Table" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1"
	ItemStyle-BorderColor="Gainsboro" ItemStyle-VerticalAlign="Top" 
    CellSpacing="2" CellPadding="2">
	<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" HorizontalAlign="Left"></ItemStyle>
	<ItemTemplate>
		<TABLE border="0" cellpadding="0" cellspacing="0" width="50">
			<TR>
				<TD valign="top">
					<asp:Image id="imgLineImage" runat="server"></asp:Image></TD>
			</TR>
			<!--<TR>
				<TD>
					<asp:Label id="lblColorNo" runat="server"></asp:Label></TD>
			</TR>-->
			<TR>
				<TD>
					<asp:Label id="lblColorName" runat="server"></asp:Label></TD>
			</TR>
		</TABLE>
	</ItemTemplate>
</asp:datalist>



</td>


</tr>

</table>
