<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Body_List_Image.ascx.vb" Inherits="plmOnApp.Body_List_Image" %>
<%@ Register TagPrefix="ys001" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR class="fontHead">
		<TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></TD>
		<TD height="25">
			<DIV align="left">&nbsp;
				<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Visible="False" Runat="server">25</asp:label></DIV>
		</TD>
		<TD width="20" height="25">
			<div align="center">
			    <asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton>
			    <%--<a id="First" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowFirstPage" runat="server"><IMG height="16" alt="First Record" src="../System/Icons/icon_first.gif" width="16" border="0"/></A>--%>
			</div>
		</TD>
		<TD width="20" height="25">
			<div align="center">
			    <asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton>
			    <%--<a id="Previous" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowPreviousPage" runat="server"><IMG height="16" alt="Previous Record" src="../System/Icons/icon_Previous.gif" width="16" border="0"/></a>--%>
		    </div>
		</TD>
		<TD width="125" height="25">
			<div align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></div>
		</TD>
		<TD width="20" height="25">
			<div align="center">
			    <asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton>
			    <%--<a id="Next" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowNextPage" runat="server"><IMG height="16" alt="Next Record" src="../System/Icons/icon_next.gif" width="16" border="0"></A>--%>
			</div>
		</TD>
		<TD width="20" height="25">
			<div align="center">
			    <asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton>
			    <%--<a id="Last" href="pagingdatalist.aspx#BookMark" OnServerClick="ShowLastPage" runat="server"><IMG height="16" alt="Last Record" src="../System/Icons/icon_last.gif" width="16" border="0"></A>--%>
			</div>
		</TD>
		<TD height="25">
			<div align="left">
			    <b>
			        <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
			        <asp:label id="lblRecordFound" Text="Records Found" Runat="server" />
			    </b>
			</div>
		</TD>
		<TD height="25">
			<P align="right">
			    <asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
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
		<TD vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="BodyID" RepeatLayout="Table" RepeatColumns="1"
				RepeatDirection="Horizontal" EnableViewState="false">
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>

				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			</asp:datalist></TD>
	</TR>
</TABLE>