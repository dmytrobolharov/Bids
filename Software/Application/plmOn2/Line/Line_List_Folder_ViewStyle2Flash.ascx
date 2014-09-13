<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_ViewStyle2Flash.ascx.vb" Inherits="plmOnApp.Line_List_Folder_ViewStyle2Flash" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="ys001" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	border="0">
	<TR class="fontHead">
		<TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></TD>
		<TD height="25">
			<DIV align="left">&nbsp;
				<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label></DIV>
		</TD>
		<TD width="20"><asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton></TD>
		<TD width="20"><asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton></TD>					
		<TD noWrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></TD>
		<TD width="20"><asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton></TD>
		<TD width="20"><asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton></TD>
		<TD width="10">&nbsp;</TD>
		<TD noWrap height="25"><div align="left"><b>
               <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
               <asp:label id="lblRecordFound" Runat="server" />
             </b></div>
        </TD>	
		<td width="25">
                <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                    <asp:ListItem Value="5">5</asp:ListItem>
                    <asp:ListItem Value="10">10</asp:ListItem>
                    <asp:ListItem Value="12" Selected="true">12</asp:ListItem>
                    <asp:ListItem Value="15">15</asp:ListItem>
                    <asp:ListItem Value="20">20</asp:ListItem>
                    <asp:ListItem Value="25">25</asp:ListItem>
                    <asp:ListItem Value="30">30</asp:ListItem>
                    <asp:ListItem Value="40">40</asp:ListItem>
                    <asp:ListItem Value="50" >50</asp:ListItem>
                    <asp:ListItem Value="75">75</asp:ListItem>
                    <asp:ListItem Value="100">100</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td width="10">
                <asp:Button ID="btnRepage" runat="server" CssClass="fontHead"></asp:Button>
            </td>				
	</TR>
</TABLE>

<TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	<TR>
		<TD vAlign="top" id="style-list-container"><asp:datalist id="Datalist1" runat="server" DataKeyField="lineFolderItemId" RepeatLayout="Flow" 
				RepeatDirection="Horizontal" EnableViewState="true">
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"  VerticalAlign="Top" BackColor="White" CssClass="droppable StyleDiv" ></ItemStyle>
				<ItemTemplate>
                 
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			</asp:datalist></TD>
	</TR>
</TABLE>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;
