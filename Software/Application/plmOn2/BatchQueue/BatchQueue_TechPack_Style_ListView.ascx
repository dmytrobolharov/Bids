<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BatchQueue_TechPack_Style_ListView.ascx.vb" Inherits="plmOnApp.BatchQueue_TechPack_Style_ListView" %>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr vAlign="top">
		<td>
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="16"><asp:checkbox id="cbThumbnail" AutoPostBack="True" runat="server"></asp:checkbox></td>
					<td class="fontHead" width="100"><asp:Label ID="lblThumbnail" runat="server" ></asp:Label></td>
					<td width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></td>
					<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></td>
					<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
					<td width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></td>
					<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></td>
					<td width="10">&nbsp;</td>
					<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
					<td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
					<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							<asp:ListItem Value="5">5</asp:ListItem>
							<asp:ListItem Value="10">10</asp:ListItem>
							<asp:ListItem Value="15">15</asp:ListItem>
							<asp:ListItem Value="20">20</asp:ListItem>
							<asp:ListItem Value="25">25</asp:ListItem>
							<asp:ListItem Value="30">30</asp:ListItem>
							<asp:ListItem Value="40">40</asp:ListItem>
							<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						</asp:dropdownlist>
					</td>
					<td width="10"><asp:button id="Button1" runat="server" CssClass="fontHead"></asp:button></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleID" EnableViewState="False">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</td>
	</tr>
</table>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;
