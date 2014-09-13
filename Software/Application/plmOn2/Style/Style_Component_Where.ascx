<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Where.ascx.vb" Inherits="plmOnApp.Style.Material.ctrl_Style_Component_Where" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:datalist id="DataList1" GridLines="Both" RepeatDirection="Horizontal" RepeatColumns="4" BackColor="White"
	BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100%" CssClass="font" runat="server"
	DataKeyField="StyleID">
	<ItemStyle Height="100px" Width="200px"></ItemStyle>
	<ItemTemplate>
		<DIV align="center">
			<cc1:BWImageButton id="imgStyleFile" runat="server" >
			</cc1:BWImageButton></DIV>
		<BR>
		
		
		<TABLE>
			<TR>
				<TD class="font">
					<asp:Label id=Label1 runat="server" Text='<%# Container.DataItem( "StyleNo") %>'>
					</asp:Label></TD>
			</TR>
			<TR>
				<TD class="font">
					<asp:Label id=lbImgDescription runat="server" Text='<%# Container.DataItem( "Description") %>'>
					</asp:Label></TD>
			</TR>
			<TR>
				<TD class="font">
					<asp:Label id=Label2 runat="server" Text='<%# Container.DataItem( "SizeClass") %>'>
					</asp:Label></TD>
			</TR>
			<TR>
				<TD class="font">
					<asp:Label id=Label3 runat="server" Text='<%# Container.DataItem("SizeRange") %>'>
					</asp:Label></TD>
			</TR>
			
			<TR>
				<TD class="font">
					<asp:Label id="Label4" runat="server" Text='<%# Container.DataItem(strFieldSeason) %>'>
					</asp:Label></TD>
			</TR>
			<TR>
				<TD class="font">
					<asp:Label id="Label5" runat="server" Text='<%# Container.DataItem(strFieldYear) %>'>
					</asp:Label></TD>
			</TR>
			
			<TR>
				<TD class="font">
					<asp:Label id="Label7" runat="server" Text='<%# Container.DataItem( "MaterialName") %>'>
					</asp:Label></TD>
			</TR>			
			

		</TABLE>
		
		
	</ItemTemplate>
</asp:datalist>
