<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Message_Edit.aspx.vb" Inherits="plmOnApp.Image_Catalog_Message_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Image_Catalog_Image_Comment" Src="Image_Catalog_Image_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Image_User" Src="../Image/Image_User.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Catalog</title>
		
		
		
		
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSend" runat="server" Message="Are you sure you want to send this catalog?" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnDelete" runat="server" Message="Are you sure you want to remove this trading partner?" ></cc1:confirmedimagebutton></td>
				</TR>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"> Image Catalog...</asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="800" bgColor="#ffffff"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top" width="450" bgColor="#ffffff">
						<TABLE class="TableHeader" id="Table4" height="25" cellSpacing="0" cellPadding="0" width="100%"
							border="0" runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD><asp:Label ID="lblHdrMessage" runat="server">Message</asp:Label></TD>
							</TR>
						</TABLE>
						<asp:datalist id="dlTeam" runat="server" CellPadding="0" ShowFooter="False" DataKeyField="TeamID"
							ShowHeader="false" Width="100%">
							<ItemTemplate>
								<TABLE>
									<TR>
										<TD>&nbsp;&nbsp;</TD>
										<TD>
											<asp:CheckBox id="cbTeam" runat="server" Checked="true"></asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id="lblFullName" CssClass="font"><%# Container.DataItem("FirstName") & " " & Container.DataItem("LastName")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id="lblEmail" runat="server" CssClass="font" Font-Italic="true">
												<%# Container.DataItem("Email")%>
											</asp:Label></TD>
									</TR>
								</TABLE>
								<asp:TextBox id=txtEmail runat="server" Visible="false" Text='<%# Container.DataItem("Email")%>'>
								</asp:TextBox>
								<asp:TextBox id=txtFullName runat="server" Visible="false" Text='<%# Container.DataItem("FirstName") & " " & Container.DataItem("LastName")%>'>
								</asp:TextBox>
							</ItemTemplate>
							<HeaderStyle Height="24px" CssClass="TableHeaderOver"></HeaderStyle>
						</asp:datalist>
						<asp:datalist id="dlTradePartner" runat="server" Width="100%" ShowHeader="false" DataKeyField="TeamID"
							ShowFooter="False" CellPadding="0">
							<ItemTemplate>
								<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD class="fontHead">&nbsp;<%# DataBinder.Eval(Container.DataItem, "Company")%></TD>
									</TR>
								</TABLE>
								<TABLE>
									<TR id=TR1 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail1").ToString)%>'>
										<TD>&nbsp;&nbsp; <INPUT type=hidden value='<%# Container.DataItem("ContactEmail1")%>' name='Mail1-<%#Container.DataItem("TeamID").ToString%>'>
											<INPUT type=hidden value='<%# Container.DataItem("Company")%>' name='To1-<%#Container.DataItem("TeamID").ToString%>'>
										</TD>
										<TD><INPUT type=checkbox value=1 name='chkTrade1-<%#Container.DataItem("TeamID").ToString%>' checked>
										</TD>
										<TD class="font">
											<asp:Label id="ContactName1" CssClass="font"><%# DataBinder.Eval(Container.DataItem, "Contactname1")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id="ContactMail1" runat="server" CssClass="font">
												<%# Container.DataItem("ContactEmail1")%>
											</asp:Label></TD>
									</TR>
									<TR id=TR2 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail2").ToString)%>'>
										<TD>&nbsp;&nbsp; <INPUT type=hidden value='<%# Container.DataItem("ContactEmail2")%>' name='Mail2-<%#Container.DataItem("TeamID").ToString%>'>
											<INPUT type=hidden value='<%# Container.DataItem("Company")%>' name='To2-<%#Container.DataItem("TeamID").ToString%>'>
										</TD>
										<TD><INPUT type=checkbox value=1 name='chkTrade2-<%#Container.DataItem("TeamID").ToString%>'>
										</TD>
										<TD class="font">
											<asp:Label id=ContactName2 CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail2").ToString)%>'><%# DataBinder.Eval(Container.DataItem, "Contactname2")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id=ContactMail2 runat="server" CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail2").ToString)%>'>
												<%# Container.DataItem("ContactEmail2")%>
											</asp:Label></TD>
									</TR>
									<TR id=TR3 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail3").ToString)%>'>
										<TD>&nbsp;&nbsp; <INPUT type=hidden value='<%# Container.DataItem("ContactEmail3")%>' name='Mail3-<%#Container.DataItem("TeamID").ToString%>'>
											<INPUT type=hidden value='<%# Container.DataItem("Company")%>' name='To3-<%#Container.DataItem("TeamID").ToString%>'>
										</TD>
										<TD><INPUT type=checkbox value=1 name='chkTrade3-<%#Container.DataItem("TeamID").ToString%>'>
										</TD>
										<TD class="font">
											<asp:Label id=ContactName3 CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail3").ToString)%>'><%# DataBinder.Eval(Container.DataItem, "Contactname3")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id=ContactMail3 runat="server" CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail3").ToString)%>'>
												<%# Container.DataItem("ContactEmail3")%>
											</asp:Label></TD>
									</TR>
									<TR id=TR4 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail4").ToString)%>'>
										<TD>&nbsp;&nbsp; <INPUT type=hidden value='<%# Container.DataItem("ContactEmail4")%>' name='Mail4-<%#Container.DataItem("TeamID").ToString%>'>
											<INPUT type=hidden value='<%# Container.DataItem("Company")%>' name='To4-<%#Container.DataItem("TeamID").ToString%>'>
										</TD>
										<TD><INPUT type=checkbox value=1 name='chkTrade4-<%#Container.DataItem("TeamID").ToString%>'>
										</TD>
										<TD class="font">
											<asp:Label id=ContactName4 CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail4").ToString)%>'><%# DataBinder.Eval(Container.DataItem, "Contactname4")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id=ContactMail4 runat="server" CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail4").ToString)%>'>
												<%# Container.DataItem("ContactEmail4")%>
											</asp:Label></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
							<HeaderStyle Height="24px" CssClass="TableHeaderOver"></HeaderStyle>
						</asp:datalist><br>
						<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
							<TR>
								<TD width="10">&nbsp;</TD>
								<TD class="fontHead" width="50"><asp:Label ID="lblSubject" runat="server">Subject</asp:Label>:</TD>
								<TD><asp:textbox id="txtSubject" runat="server" Width="325px"></asp:textbox></TD>
							</TR>
							<TR>
								<TD width="10">&nbsp;</TD>
								<TD class="fontHead" vAlign="top" width="50">
									<table height="5" cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td></td>
										</tr>
									</table>
									<asp:Label ID="lblMessage" runat="server">Message</asp:Label>:</TD>
								<TD><asp:textbox id="txtMessage" runat="server" Width="325px" TextMode="MultiLine" Height="200px"></asp:textbox></TD>
							</TR>
							<TR>
								<TD width="10"></TD>
								<TD class="fontHead" vAlign="top" width="50">
									<table height="5" cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td></td>
										</tr>
									</table>
								</TD>
								<TD><asp:label id="txtMessageHistory" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD width="10"></TD>
								<TD class="fontHead" vAlign="top" width="50"></TD>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top">
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0"
							runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD><asp:label ID="lblHdrImageSel" runat="server">Image Selected...</asp:label></TD>
							</TR>
						</TABLE>
						<asp:datalist id="Datalist1" runat="server" Width="100%" CellPadding="0" CssClass="font" GridLines="Both"
							RepeatColumns="1" BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
							Datakeyfield="ImageCatalogItemID" CellSpacing="0" RepeatDirection="Horizontal">
							<HeaderTemplate>
							</HeaderTemplate>
							<ItemStyle Height="100px" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<TABLE id="TB_Data" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
									<TR>
										<TD>
											<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
												<TR>
													<TD vAlign="top" width="155">
														<TABLE class="TableHeaderOver" height="25" cellSpacing="0" cellPadding="0" width="100%"
															border="0">
															<TR vAlign="middle">
																<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
																<TD>
                                                                    <asp:Label ID="lblImage" runat="server"><%#GetSystemText("Image")%></asp:Label></TD>
															</TR>
														</TABLE>
														<TABLE width="100%">
															<TR>
																<TD>
																	<asp:Image id=ImgCatalog runat="server" ImageAlign="Middle">
																	</asp:Image></TD>
															</TR>
														</TABLE>
														<TABLE width="100%">
															<TR>
																<TD><FONT size="1"><%#Container.DataItem("ImageDescription")%></FONT></TD>
															</TR>
															<TR>
																<TD><FONT size="1"><%#Container.DataItem("ImageFile")%></FONT></TD>
															</TR>
														</TABLE>
														<asp:TextBox id=txtImageID runat="server" Visible="False" Text='<%#Container.DataItem("ImageID")%>'>
														</asp:TextBox></TD>
													<TD vAlign="top">
														<uc1:Image_Catalog_Image_Comment id=Image_Catalog_Image_Comment1 runat="server" ImageVersion='<%#Container.DataItem("ImageVersion")%>' ImageID='<%#Container.DataItem("ImageID")%>' ImageCatalogItemID='<%#Container.DataItem("ImageCatalogItemID")%>'>
														</uc1:Image_Catalog_Image_Comment><BR>
														<TABLE>
															<TR>
																<TD class="fonthead" width="75">
                                                                    <asp:Label ID="lbldateSentH" runat="server" ><%#GetSystemText("Date Sent")%></asp:Label>
																</TD>
																<TD>
																	<asp:TextBox id="txtSentDate" runat="server" Width="75px" MaxLength="10"></asp:TextBox><A id="aSentDate" runat="server"><IMG height="17" src="../System/Icons/icon_calendar.gif" width="18" border="0"></A></TD>
																<TD>&nbsp;</TD>
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
						</asp:datalist></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
