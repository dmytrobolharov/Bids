<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_List_View.ascx.vb" Inherits="srmOnApp.Style_List_View" %>

<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="top">
		<TD>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="16"><asp:checkbox id="cbThumbnail" AutoPostBack="True" runat="server"></asp:checkbox></TD>
					<TD class="fontHead" width="100"><asp:label id="lblThumbnail" runat="server">Thumbnail?</asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
					<td width="125" height="25"><div align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></div></td>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
                    <td height="25"><div align="left"><b><asp:label id="lblRecordsFound" Runat="server" Visible="true"></asp:label></div></td>
                    <TD  align="right"><asp:label id="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:label></TD>
				</TR>
			</TABLE>
			<asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleID" EnableViewState="False">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid>
            <asp:HiddenField id="CurrentPage" runat="server" Value="0" />
            <asp:HiddenField id="SortOrder" runat="server" />
            </TD>
	</TR>
</TABLE>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;
