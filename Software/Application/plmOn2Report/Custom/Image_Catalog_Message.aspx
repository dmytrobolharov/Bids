<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Message.aspx.vb" Inherits="plmOn2Report.Image_Catalog_Message" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
		
		
		
		
		<LINK href="../System/CSS/Mail.css" type="text/css" rel="stylesheet">
		<style type="text/css">.Header { FONT-SIZE: large; FONT-FAMILY: Geneva, Arial, Helvetica, sans-serif }
	.Label { FONT-WEIGHT: bold; FONT-SIZE: x-small; FONT-FAMILY: Geneva, Arial, Helvetica, sans-serif }
	.Field { FONT-WEIGHT: normal; FONT-SIZE: x-small; FONT-FAMILY: Geneva, Arial, Helvetica, sans-serif }
		</style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="800" bgColor="#ffffff" border="0">
				<tr>
					<td><FONT size="5">
                        <asp:Label ID="lblHeader" runat="server" ></asp:Label></FONT>&nbsp;
					</td>
					<td align="right"><IMG height="35" src="../logo.png"></td>
				</tr>
			</table>
			<BR>
			<IMG src="../System/Icons/icon_link.gif">
			<asp:hyperlink id="hlReturn" runat="server" CssClass="fonthead" ForeColor="Blue" Font-Size="12px"
				Font-Underline="true"></asp:hyperlink>
			<br>
			<br>
			<table id="Table1" cellspacing="0" cellpadding="0" width="800" border="0">
				<tr>
					<td>
						<table id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="100" class="Label">
                                    <asp:Label ID="lblSubjectH" runat="server" ></asp:Label></td>
								<td class="Field">
									<asp:Label ID="txtSubject" runat="server"></asp:Label></td>
								<td></td>
							</tr>
							<tr>
								<td width="100" class="Label"></td>
								<td class="Field">
									<asp:Label ID="txtMessage" runat="server"></asp:Label></td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
			<asp:datalist id="Datalist1" runat="server" GridLines="Both" RepeatColumns="6" BackColor="White"
				BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Datakeyfield="ImageCatalogItemID"
				CellSpacing="0" RepeatDirection="Horizontal" CssClass="font" CellPadding="0" Width="800px"
				Visible="true">
				<ItemStyle Height="100px" VerticalAlign="Top"></ItemStyle>
				<ItemTemplate>
					<asp:textbox id="txtQuoteAvailable" runat="server" Width="75px" Visible="false" MaxLength="5"></asp:textbox>
					<TABLE id="TB_Data" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
						<TR>
							<TD>
								<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD vAlign="top" width="100">
											<TABLE width="100%">
												<TR>
													<TD>
														<asp:Image id="imgDesign" runat="server" ImageAlign="Middle"></asp:Image></TD>
												</TR>
											</TABLE>
											<TABLE>
						<TR>
							<TD class="font">
								<asp:Label id=lbImgDescription runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription") %>' CssClass="fonthead">
								</asp:Label></TD>
						</TR>
					</TABLE>
											
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</html>
