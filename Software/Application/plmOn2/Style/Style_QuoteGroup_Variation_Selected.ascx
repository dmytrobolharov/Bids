<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_QuoteGroup_Variation_Selected.ascx.vb" Inherits="plmOnApp.Style.Quote.Style_QuoteGroup_Variation_Selected" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<asp:datalist id="DataList1" BorderColor="Silver" BorderWidth="0px" EnableViewState="True" RepeatDirection="Horizontal"
	RepeatColumns="6" runat="server">
	<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
		VerticalAlign="Top" BackColor="Gainsboro"></ItemStyle>
	<ItemTemplate>
		<TABLE class="TableHeader" id="Table5" height="28" cellSpacing="0" cellPadding="0" width="100%"
			border="0">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10" height="28"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD></TD>
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
		</TABLE>
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
					</TD>
			</TR>
		</TABLE>
	</ItemTemplate>
	<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
</asp:datalist>
