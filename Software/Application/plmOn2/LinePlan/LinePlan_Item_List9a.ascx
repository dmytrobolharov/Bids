<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_List9a.ascx.vb" Inherits="plmOnApp.LinePlan_Item_List9a" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="top">
		<TD>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
					<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
					<TD width="10">&nbsp;</TD>
					<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
					<TD align="right" width="110"><asp:label id="RecordPerPage" runat="server" CssClass="font"></asp:label></TD>
					<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							<asp:ListItem Value="5">5</asp:ListItem>
							<asp:ListItem Value="10">10</asp:ListItem>
							<asp:ListItem Value="15">15</asp:ListItem>
							<asp:ListItem Value="20">20</asp:ListItem>
							<asp:ListItem Value="25">25</asp:ListItem>
							<asp:ListItem Value="30">30</asp:ListItem>
							<asp:ListItem Value="40">40</asp:ListItem>
							<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						</asp:dropdownlist></TD>
					<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
				</TR>
			</TABLE>
			
			<table border="0">
			<tr><td>
			        <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			        <tr>
			            <td align="right" >&nbsp;</td>
			            <td align="left" width="100"><%#GetSystemText("Units")%>:&nbsp;&nbsp; <asp:label ID="lblUnits" runat="server" ></asp:label></td>
			            <td align="right" width="100"><%#GetSystemText("Total")%>:&nbsp;&nbsp; <asp:label ID="lblTotal" runat="server" ></asp:label></td>
			        </tr>
			        </table>
			</td>
			</tr>
			<tr><td><asp:datagrid id="DataGrid1" runat="server" DataKeyField="LinePlanShowroomStyleColorID" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				AutoGenerateColumns="false"  >
			    <HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
			    <PagerStyle Visible="False"></PagerStyle>				
			    <Columns>
		             <asp:TemplateColumn>
	                    <ItemTemplate>
	                        <asp:Image runat="server" ID="imgDesign"   />
	                    </ItemTemplate>
	                </asp:TemplateColumn>
		            <asp:TemplateColumn>
		                <ItemStyle Width = "30"  HorizontalAlign="Center"/>
		                <ItemTemplate>
		                    <asp:Image runat="server" ID="imgColor"  />
		                </ItemTemplate>
		            </asp:TemplateColumn>
	                
			    </Columns>
			</asp:datagrid>
			</td></tr>
			</table>
            <asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
	</TR>
</TABLE>