<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_Variation_Selected.ascx.vb" Inherits="plmOnApp.Style.Quote.Style_Quote_Variation_Selected" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:datalist id="DataList1" BorderColor="Silver" BorderWidth="0px" EnableViewState="True" RepeatDirection="Horizontal"
	RepeatColumns="6" runat="server">
	<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
		VerticalAlign="Top" BackColor="Gainsboro"></ItemStyle>
	<ItemTemplate>
		<TABLE class="TableHeader" id="Table5" height="28" cellSpacing="0" cellPadding="0" width="100%"
			border="0">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10" height="28"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD>
					<cc1:confirmedimagebutton id="btnAddVendor" runat="server"  CommandName="AddVendor" 
								Message="NONE" >
					</cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnEditVariation" runat="server"  CommandName="EditVariation" 
 Message="NONE"  >
					</cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnDeleteRequest" runat="server" 
 CommandName="DeleteVariation" Message='<%#GetSystemText("Are you sure you want to delete this variation?")%>'>
					</cc1:confirmedimagebutton></TD>
			</TR>
		</TABLE>
		<TABLE class="TableHeaderBlue" id="Table6" height="25" cellSpacing="0" cellPadding="0"
			width="100%" border="0" runat="server">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD>
					<asp:Label id=lblVariationSize runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>'>
					</asp:Label></TD>
			</TR>
		</TABLE> <!--
		<TABLE id="tbCosting" borderColor="limegreen" cellSpacing="0" cellPadding="0" width="100%"
			bgColor="#ccff99" border="1" runat="server">
			<TR>
				<TD>
					<TABLE id="Table15" height="25" cellSpacing="0" cellPadding="0" border="0">
						<TR>
							<TD width="10"></TD>
							<TD class="fontHead" width="20">
								<asp:Image id="Image1" runat="server" ImageUrl="../System/Icons/icon_costing.gif"></asp:Image></TD>
							<TD class="fontHead">
								<cc1:BWHyperLink id="lnkCosting" runat="server" CssClass="fontHead" ForeColor="SeaGreen">Costing not found...</cc1:BWHyperLink></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
		
		<TABLE id="tbTechPack" borderColor="gold" cellSpacing="0" cellPadding="0" width="100%"
			bgColor="#ffff99" border="1" runat="server">
			<TR>
				<TD>
					<TABLE id="Table16" height="25" cellSpacing="0" cellPadding="0" border="0">
						<TR>
							<TD width="10"></TD>
							<TD class="fontHead" width="20">
								<asp:Image id="imgBlock" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image></TD>
							<TD class="fontHead">&nbsp;
								<cc1:BWHyperLink id="lnkPdfFile" runat="server" ForeColor="Red" CssClass="fontHead">Pdf file not found...</cc1:BWHyperLink></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
		-->
		<TABLE id="Table7" borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
			border="0">
			<TR>
				<TD vAlign="top">
					<DIV align="center">
						<asp:Image id=imgStyle runat="server"  ImageAlign="Middle">
						</asp:Image></DIV>
				</TD>
			</TR>
			<TR>
				<TD>
					<TABLE id="Table8" cellSpacing="0" cellPadding="0" width="100%" border="0">
						<TR>
							<TD class="font">
								<DIV align="center">
									<asp:Label id=StyleNo runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>'>
									</asp:Label></DIV>
							</TD>
						</TR>
						<TR>
							<TD class="font">
								<DIV align="center">
									<asp:Label id=lbImgDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'>
									</asp:Label></DIV>
							</TD>
						</TR>
					</TABLE>
					<INPUT id=txtStyleId type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleId").toString%>' name=txtStyleId runat="server">
					<INPUT id=txtStyleDevelopmentId type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleDevelopmentId").toString%>' name=txtStyleDevelopmentId runat="server">
					<INPUT id=txtStyleQuoteVariationId type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleQuoteVariationId").toString%>' runat="server"></TD>
			</TR>
		</TABLE>
		<asp:DataGrid id="DataGrid1" runat="server" OnItemCreated="DataGrid1_ItemCreated" Width="300"
			AutoGenerateColumns="false">
			<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			<ItemStyle CssClass="ItemTemplate"></ItemStyle>
			<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
			<Columns>
				<asp:TemplateColumn ItemStyle-Width="16px">
					<HeaderTemplate>
					</HeaderTemplate>
					<ItemTemplate>
						<asp:Image id="imgQuoteStatus" runat="server" ImageUrl='<%# "../System/icons/" & DataBinder.Eval(Container.DataItem, "QuoteStatusIcon") %>'>
						</asp:Image>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn ItemStyle-Width="75px">
					<HeaderTemplate>
						<asp:Label id="lblHeaderQuoteStatus" runat="server" text='<%#GetSystemText("Status")%>'></asp:Label>
					</HeaderTemplate>
					<ItemTemplate>
						<asp:Label id="lblQuoteStatus" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "QuoteStatus") %>'>
						</asp:Label>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn ItemStyle-Width="125px">
					<HeaderTemplate>
						<asp:Label id="lblHeaderVendorName" runat="server" text='<%#GetSystemText("Vendor Name")%>'></asp:Label>
					</HeaderTemplate>
					<ItemTemplate>
						<asp:Label id="lblVendorName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "VendorName") %>'>
						</asp:Label><INPUT id="hdnStyleId" type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleId").toString%>' name=hdnStyleId runat="server">
					</ItemTemplate>
				</asp:TemplateColumn>
			</Columns>
		</asp:DataGrid>
	</ItemTemplate>
	<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
</asp:datalist>
