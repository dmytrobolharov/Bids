<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Sourcing_Page_Style_List_Image.ascx.vb" Inherits="plmOnApp.Sourcing_Page_Style_List_Image" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ys001" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR class="fontHead">
		<TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></TD>
		<TD height="25">
			<DIV align="left">&nbsp;
				<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="24" Visible="False" Runat="server">25</asp:label></DIV>
		</TD>
		<TD width="20" height="25">
			<DIV align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></DIV>
		</TD>
		<TD width="20" height="25">
			<DIV align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></DIV>
		</TD>
		<TD width="125" height="25">
			<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
		</TD>
		<TD width="20" height="25">
			<DIV align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></DIV>
		</TD>
		<TD width="20" height="25">
			<DIV align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></DIV>
		</TD>
		<TD height="25">
			<DIV align="left"><b><asp:label id="lblRecordCount" Visible="False" Runat="server"></asp:label>&nbsp;<asp:Label
                    ID="RecordCount" runat="server" ></asp:Label></b></DIV>
			</B></TD>
		<TD height="25">
			<P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
				<asp:dropdownlist id="ddlSortBy" runat="server">
					
				</asp:dropdownlist>
				<asp:ImageButton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton></P>
		</TD>
	</TR>
</TABLE>

<TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	<TR>
		<TD vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="styleId" RepeatLayout="Table" RepeatColumns="1"
				RepeatDirection="Horizontal" EnableViewState="false">
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			</asp:datalist></TD>
	</TR>
</TABLE>
