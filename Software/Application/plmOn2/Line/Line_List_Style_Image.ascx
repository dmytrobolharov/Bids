<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Line_List_Style_Image.ascx.vb" Inherits="plmOnApp.Line_List_Style_Image" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ys001" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR class="fontHead">
		<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
		<TD height="25">
			<DIV align="left">&nbsp;
				<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="10" Visible="False" Runat="server">10</asp:label></DIV>
		</TD>
		<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
		<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
		<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
		<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
		<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
		<TD width="10">&nbsp;</TD>
		<TD noWrap height="25"><div align="left"><b>
               <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
               <asp:label id="lblRecordFound" Text="Records Found" Runat="server" />
             </b></div>
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
		<TD vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="styleId" RepeatLayout="Table" RepeatColumns="1"
				RepeatDirection="Horizontal" EnableViewState="false">
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<table borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
						<tr>
							<td>
								<asp:CheckBox id="cbSelectStyle" runat="server" Text='<%# GetSystemText("Click here to select style")& "..." %>' CssClass="font"></asp:CheckBox>
							</td>
						</tr>
					</table> 	
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			</asp:datalist></TD>
	</TR>
</TABLE>
