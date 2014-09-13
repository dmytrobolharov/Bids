<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_ViewStyle2.ascx.vb" Inherits="plmOnApp.Line_List_Folder_ViewStyle2" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ys001" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<table class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<tr class="fontHead">
		<td align="center" width="10" height="25"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
		<td height="25">
			<div align="left">&nbsp;
				<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="10" Visible="False" Runat="server">10</asp:label></div>
		</td>
        <td width="75" runat="server" id="tdThumbnail" visible="false">
            <asp:CheckBox runat="server" id="chbThumbnail" AutoPostBack="true" />
        </td>
		<td width="20"><asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton></td>
		<td width="20"><asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton></td>					
		<td noWrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></td>
		<td width="20"><asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton></td>
		<td width="20"><asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton></td>
		<td width="10">&nbsp;</td>
		<td noWrap height="25"><div align="left"><b>
               <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
               <%--<asp:label id="lblRecordFound" Runat="server" />--%>
             </b>
             <asp:HiddenField ID="hdnRecordCount" runat="server" Value='' />
             </div>
        </td>
        <td width="300" align="right">
            <asp:RadioButtonList ID="rbViewType" Repeatdirection="Horizontal" runat="server" AutoPostBack="true">
                <asp:ListItem Text="Thumb View" Value="T" Selected="true"></asp:ListItem>
                <asp:ListItem Text="List View" Value="L"></asp:ListItem>
            </asp:RadioButtonList>
        </td>
		<%--<td height="25">
			<P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
				<asp:dropdownlist id="ddlSortBy" runat="server">
					<asp:ListItem Value="ASC">ASC</asp:ListItem>
					<asp:ListItem Value="DESC">DESC</asp:ListItem>
				</asp:dropdownlist>
				<asp:ImageButton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton></P>
		</td>--%>
        <td align="right"><asp:label id="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:label></td>
		<td width="25" align="right"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
                <asp:ListItem Value="5">5</asp:ListItem>
				<asp:ListItem Value="10">10</asp:ListItem>
				<asp:ListItem Value="15">15</asp:ListItem>
				<asp:ListItem Value="20">20</asp:ListItem>
				<asp:ListItem Value="25">25</asp:ListItem>
				<asp:ListItem Value="30">30</asp:ListItem>
				<asp:ListItem Value="40">40</asp:ListItem>
				<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
			</asp:dropdownlist></td>
		<td width="10" align="right"><asp:button id="btnGo" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
	</tr>
</table>

<table borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	<tr>
		<td vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="lineFolderItemId" RepeatLayout="Table" RepeatColumns="1"
				Repeatdirection="Horizontal" EnableViewState="false">
				<ItemStyle Wrap="false" HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>

				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			</asp:datalist>
            <asp:PlaceHolder ID="plhStylesGrid" runat="server"></asp:PlaceHolder>
        </td>
	</tr>
</table>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" />&nbsp;&nbsp;
