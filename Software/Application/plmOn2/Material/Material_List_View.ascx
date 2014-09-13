<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Material_List_View.ascx.vb" Inherits="plmOnApp.Material_List_View" %>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr valign="top">
		<td>
            <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
	            border="0">
	            <tr valign="middle">
		            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="16"><asp:checkbox id="cbThumbnail" runat="server" AutoPostBack="True"></asp:checkbox></td>
		            <td class="fontHead" width="100"><asp:Label ID="lblThumbnail" runat="server" Text="Thumbnail?"></asp:Label></td>
		            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
		            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
		            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
		            <td width="10">&nbsp;</td>
		            <td nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
		            <td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></td>
		            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
				            <asp:ListItem Value="5">5</asp:ListItem>
				            <asp:ListItem Value="10">10</asp:ListItem>
				            <asp:ListItem Value="15">15</asp:ListItem>
				            <asp:ListItem Value="20">20</asp:ListItem>
				            <asp:ListItem Value="25">25</asp:ListItem>
				            <asp:ListItem Value="30">30</asp:ListItem>
				            <asp:ListItem Value="40">40</asp:ListItem>
				            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
			            </asp:dropdownlist></td>
		            <td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" Text="GO"></asp:button></td>
	            </tr>
            </table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="MaterialID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</td>
	</tr>
</table>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;