<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlanColorItem.ascx.vb" Inherits="plmOnApp.Image_List_Image" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR class="fontHead">
		<TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
		<TD height="25">
			<DIV align="left">&nbsp;
				<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="24" Visible="False" Runat="server">25</asp:label></DIV>
		</TD>
		<TD width="20" height="25">
			<DIV align="center"><A id="First" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowFirstPage" runat="server"><IMG height="16" alt="First Record" src="../System/Icons/icon_first.gif" width="16" border="0"></A></DIV>
		</TD>
		<TD width="20" height="25">
			<DIV align="center"><A id="Previous" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowPreviousPage"
					runat="server"><IMG height="16" alt="Previous Record" src="../System/Icons/icon_Previous.gif" width="16"
						border="0"></A></DIV>
		</TD>
		<TD width="125" height="25">
			<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
		</TD>
		<TD width="20" height="25">
			<DIV align="center"><A id="Next" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowNextPage" runat="server"><IMG height="16" alt="Next Record" src="../System/Icons/icon_next.gif" width="16" border="0"></A></DIV>
		</TD>
		<TD width="20" height="25">
			<DIV align="center"><A id="Last" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowLastPage" runat="server"><IMG height="16" alt="Last Record" src="../System/Icons/icon_last.gif" width="16" border="0"></A></DIV>
		</TD>
		<TD height="25">
			<DIV align="left"><B><asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;Records 
					Found</B></DIV>
			</TD>
		<TD height="25">
			<P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
				<asp:dropdownlist id="ddlSortBy" runat="server">
					<asp:ListItem Value="ASC">ASC</asp:ListItem>
					<asp:ListItem Value="DESC">DESC</asp:ListItem>
				</asp:dropdownlist>
				<asp:ImageButton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton></P>
		</TD>
	</TR>
</TABLE>
<TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	<TR>
		<TD vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="ImageID" RepeatLayout="Table" RepeatColumns="4"
				RepeatDirection="Horizontal" EnableViewState="false" >
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
					VerticalAlign="Top" BackColor="White" Width="100%"></ItemStyle>
				<ItemTemplate>
				    <table id="tbItem" runat="server" bordercolor='#CCCCCC'  border="1" cellpadding="0" cellspacing="0" width="100%" ><tr>
				    <td><table class="TableHeader" cellpadding="0"  cellspacing="0" width="100%" ><tr>
				    <td><asp:CheckBox runat="server" ID="chkSelect" Text="Select"  CssClass="font" /></td></tr></table></td></tr>
				    <tr height="250" ><td ><asp:Image id="imgDesign" runat="server"></asp:image></td>
				    </tr><tr><td> <asp:PlaceHolder ID="pnlHeader" runat="server" >
				    </asp:PlaceHolder></td></tr></table>
				    <input type="hidden" id="ImageVersion" runat="server" /><br/>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></TD>
	</TR>
</TABLE>
