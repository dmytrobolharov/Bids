<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_Variation_Message.ascx.vb" Inherits="plmOnApp.Style.Quote.Style_Quote_Variation_Message" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:datalist id="DataList1" EnableViewState="True" RepeatColumns="1" runat="server">
	<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
		VerticalAlign="Top" BackColor="White"></ItemStyle>
	<ItemTemplate>
		<TABLE id="Table9" borderColor="silver" cellSpacing="0" cellPadding="0" width="200" bgColor="#ffffff"
			border="0">
			<TR>
				<TD vAlign="top">
					<TABLE class="TableHeaderOver" id="Table1" height="25" cellSpacing="0" cellPadding="0"
						width="125" border="0" runat="server">
						<TR vAlign="middle">
							<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<TD>
								<asp:Label id=lblSizeClass runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>'>
								</asp:Label></TD>
						</TR>
					</TABLE>
					<asp:ImageButton id="ImgQuoteVariationMessage" runat="server" CommandName="Link" >
					</asp:ImageButton>
					<TABLE id="Table10">
						<TR>
							<TD class="font">
								<asp:Label id=StyleNo runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>'>
								</asp:Label></TD>
						</TR>
						<TR>
							<TD class="font">
								<asp:Label id=lbImgDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'>
								</asp:Label></TD>
						</TR>
					</TABLE>
				</TD>
				<TD vAlign="top">
					<TABLE class="TableHeaderOver" id="Table5" height="25" cellSpacing="0" cellPadding="0"
						width="100%" border="0" runat="server">
						<TR vAlign="middle">
							<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<TD><%#GetSystemText("Comments")%>...</TD>
						</TR>
					</TABLE>
					<TEXTAREA style="WIDTH: 250px; HEIGHT: 70px" rows="10" cols="34" name='<%# DataBinder.Eval(Container.DataItem, "StyleQuoteVariationID").ToString %>'><%# DataBinder.Eval(Container.DataItem, "TeamComment") %></TEXTAREA>
					<TEXTAREA style="WIDTH: 250px; HEIGHT: 70px" rows="10" cols="34" name='TradeComment' readonly><%# DataBinder.Eval(Container.DataItem, "PartnerComment") %></TEXTAREA></TD>
			</TR>
		</TABLE>
	</ItemTemplate>
	<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
</asp:datalist>
