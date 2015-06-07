<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TradePartnerEdit.aspx.vb" Inherits="srmOnApp.ControlTradePartnerEdit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Trading Partner</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="100%"><cc2:confirmedimagebutton id="btnSaveUser" runat="server" Message="NONE"></cc2:confirmedimagebutton><cc2:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc2:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="top" colSpan="2" height="75"><asp:label id="lblTradeName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
										ForeColor="#E0E0E0"></asp:label>&nbsp;</td>
								<TD vAlign="top" height="75"></TD>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="top" width="300">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td style="WIDTH: 12px" width="12">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:label id="lblPartnerName" runat="server">Partner Name</asp:label></td>
											<td>&nbsp;
												<asp:textbox id="txtAgentName" runat="server" Width="200px"></asp:textbox></td>
										</tr>
										<tr>
											<td style="WIDTH: 12px" width="12">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:label id="lblAddress" runat="server">Address</asp:label></td>
											<td>&nbsp;
												<asp:textbox id="txtAddress1" runat="server" Width="200px"></asp:textbox></td>
										</tr>
										<tr>
											<td style="WIDTH: 12px" width="12">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;</td>
											<td>&nbsp;
												<asp:textbox id="txtAddress2" runat="server" Width="200px"></asp:textbox></td>
										</tr>
										<tr>
											<td style="WIDTH: 12px" width="12">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:label id="lblCity" runat="server">City</asp:label></td>
											<td>&nbsp;
												<asp:textbox id="txtCity" runat="server" Width="200px"></asp:textbox></td>
										</tr>
										<tr>
											<td style="WIDTH: 12px" width="12">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:label id="lblState" runat="server">State</asp:label></td>
											<td>&nbsp;
												<asp:textbox id="txtState" runat="server" Width="200px"></asp:textbox></td>
										</tr>
										<tr>
											<td style="WIDTH: 12px" width="12">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:label id="lblPostalCode" runat="server">Postal Code</asp:label></td>
											<td>&nbsp;
												<asp:textbox id="txtPostalCode" runat="server" Width="200px"></asp:textbox></td>
										</tr>
										<tr>
											<td style="WIDTH: 12px" width="12">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:label id="lblCountry" runat="server">Country</asp:label></td>
											<td>&nbsp;
												<asp:dropdownlist id="ddlCountry" runat="server" Width="200px"></asp:dropdownlist></td>
										</tr>
									</table>
								</td>
								<TD vAlign="top" width="250">
									<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TR>
											<TD style="WIDTH: 9px" width="9">&nbsp;</TD>
											<td class="fontHead" width="75">&nbsp;<asp:label id="lblPhoneNo" runat="server">Phone No.</asp:label></td>
											<td>&nbsp;
												<asp:textbox id="txtPhone" runat="server" Width="150px"></asp:textbox></td>
										</TR>
										<TR>
											<TD style="WIDTH: 9px" width="9"></TD>
											<TD class="fontHead" width="75">&nbsp;<asp:label id="lblFaxNo" runat="server">Fax No.</asp:label></TD>
											<TD>&nbsp;
												<asp:textbox id="txtFax" runat="server" Width="150px"></asp:textbox></TD>
										</TR>
										<TR>
											<TD style="WIDTH: 9px" width="9"></TD>
											<TD class="fontHead" width="75">&nbsp;<asp:label id="lblComments" runat="server">Comments</asp:label></TD>
											<TD>&nbsp;
												<asp:textbox id="txtComments" runat="server" Width="150px" TextMode="MultiLine" Height="50px"></asp:textbox></TD>
										</TR>
										<tr>
											<td style="WIDTH: 9px" width="9">&nbsp;</td>
											<td class="fontHead" width="75">&nbsp;<asp:label id="lblUserName" runat="server">User Name</asp:label></td>
											<td>&nbsp;
												<asp:textbox id="txtUserName" runat="server"></asp:textbox></td>
										</tr>
										<TR>
											<TD style="WIDTH: 9px" width="9"></TD>
											<TD class="fontHead" width="75">&nbsp;<asp:label id="lblPassword" runat="server">Password</asp:label></TD>
											<TD>&nbsp;
												<asp:textbox id="txtPassword" runat="server" TextMode="Password"></asp:textbox></TD>
										</TR>
										<TR>
											<TD style="WIDTH: 9px" width="10"></TD>
											<TD class="fontHead" width="75">&nbsp;<asp:label id="lblActive" runat="server">Active</asp:label></TD>
											<TD>&nbsp;
												<asp:checkbox id="cbActive" runat="server"></asp:checkbox></TD>
										</TR>
									</TABLE>
								</TD>
								<TD vAlign="top" width="300">
									<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TR>
											<TD style="WIDTH: 9px" width="9">&nbsp;</TD>
											<TD class="fontHead" width="100">&nbsp;<asp:label id="lblPartnerType" runat="server">Partner Type</asp:label></TD>
											<TD><asp:radiobuttonlist id="rdbTradePartnerType" runat="server" RepeatDirection="Horizontal" CssClass="font">
													<asp:ListItem Value="Agent">Agent</asp:ListItem>
													<asp:ListItem Value="Vendor">Vendor</asp:ListItem>
												</asp:radiobuttonlist>
											</TD>
										</TR>
										<TR>
											<TD style="WIDTH: 9px; HEIGHT: 20px" width="9"></TD>
											<TD class="fontHead" style="HEIGHT: 20px" width="100">&nbsp;<asp:label id="lblPartnerClass" runat="server">Partner Class</asp:label></TD>
											<TD style="HEIGHT: 18px">&nbsp;
												<asp:DropDownList id="ddlPartnerClass" runat="server" CssClass="font">
													<asp:ListItem Value="1">Import</asp:ListItem>
													<asp:ListItem Value="D">Domestic</asp:ListItem>
													<asp:ListItem Value="N">Indirect</asp:ListItem>
													<asp:ListItem Value="B">Domestic/Indirect</asp:ListItem>
												</asp:DropDownList>
											</TD>
										</TR>
										<TR>
											<TD style="WIDTH: 9px" width="9"></TD>
											<TD class="fontHead" width="100">&nbsp;<asp:label id="lblCommisionPercent" runat="server">Commision %</asp:label></TD>
											<TD>&nbsp;
												<asp:TextBox id="txtCommission" runat="server" CssClass="font" Width="50px"></asp:TextBox>
											</TD>
										</TR>
										<TR>
											<TD style="WIDTH: 9px" width="9">&nbsp;</TD>
											<TD class="fontHead" width="100">&nbsp;<asp:label id="lblLCRequired" runat="server">LC Required?</asp:label></TD>
											<TD>&nbsp;
												<asp:CheckBox id="cbLC" runat="server"></asp:CheckBox>
											</TD>
										</TR>
										<TR>
											<TD style="WIDTH: 9px" width="9"></TD>
											<TD class="fontHead" width="100">&nbsp;</TD>
											<TD>&nbsp;
											</TD>
										</TR>
										<TR>
											<TD style="WIDTH: 9px" width="10"></TD>
											<TD class="fontHead" width="100"></TD>
											<TD>&nbsp;
											</TD>
										</TR>
									</TABLE>
								</TD>
								<TD vAlign="top">&nbsp;</TD>
							</tr>
						</table>
						<BR>
						<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview></td>
				</tr>
			</table>
			<asp:panel id="pnlContact" runat="server">
				<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD width="100%">
							<cc2:bwimagebutton id="btnAddContact" runat="server"></cc2:bwimagebutton></TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="top" colSpan="2">
							<asp:datalist id="ContactDataList" runat="server" Width="800" OnDeleteCommand="ContactDataList_DeleteCommand"
								OnCancelCommand="ContactDataList_CancelCommand" OnUpdateCommand="ContactDataList_UpdateCommand"
								OnEditCommand="ContactDataList_EditCommand" DataKeyField="TradePartnerContactID" BackColor="White"
								BorderWidth="0px">
								<HeaderTemplate>
									<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0" height="22">
										<tr class="TableHeaderOver">
											<td class="fontHead" width="20">&nbsp;</td>
											<td class="fontHead" width="200"><%#GetSystemText("Contact Name")%></td>
											<td class="fontHead" width="100"><%#GetSystemText("Title")%></td>
											<td class="fontHead" width="100"><%#GetSystemText("Phone No.")%></td>
											<td class="fontHead" width="100"><%#GetSystemText("Mobile No.")%></td>
											<td class="fontHead" width="100"><%#GetSystemText("Email")%></td>
										</tr>
									</table>
								</HeaderTemplate>
								<EditItemStyle BorderWidth="0px"></EditItemStyle>
								<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
								<FooterTemplate>
								</FooterTemplate>
								<ItemStyle BackColor="White"></ItemStyle>
								<ItemTemplate>
									<TABLE width="100%">
										<TR>
											<TD class="fontHead" width="20">
												<asp:linkbutton id="Linkbutton1" runat="Server" CommandName="edit" Text='<IMG border="0" alt="edit" src="../System/Icons/icon_edit.gif">'></asp:linkbutton></TD>
											<TD class="font" width="205"><%#Container.DataItem("FULLNAME")%></TD>
											<TD class="font" width="105"><%#Container.DataItem("Title")%></TD>
											<TD class="font" width="105"><%#Container.DataItem("PhoneNumber")%></TD>
											<TD class="font" width="105"><%#Container.DataItem("MobileNumber")%></TD>
											<TD class="font" width="100"><%#Container.DataItem("Email")%></TD>
										</TR>
									</TABLE>
								</ItemTemplate>
								<EditItemTemplate>
									<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TR>
											<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
											<TD width="500">
												<asp:linkbutton id="Linkbutton2" runat="Server" CommandName="update" NAME="Linkbutton2"></asp:linkbutton>
												<cc2:ConfirmedLinkButton id="Linkbutton4" runat="Server" Message="Are you sure you want to delete this contact?" CommandName="delete"  NAME="Linkbutton4"></cc2:ConfirmedLinkButton>
												<asp:linkbutton id="Linkbutton3" runat="Server" CommandName="cancel" NAME="Linkbutton3"></asp:linkbutton></TD>
											<TD>&nbsp;</TD>
										</TR>
									</TABLE>
									<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="gray" border="0">
										<TR>
											<TD width="10">&nbsp;</TD>
											<TD class="fontHead"><FONT color="white">Edit Contact:
													<asp:Label id=lblContactName runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FullName").ToString  %>'> </asp:Label></FONT></TD>
										</TR>
									</TABLE>
									<TABLE cellSpacing="1" cellPadding="1" width="800" border="0">
										<TR>
											<TD width="10">&nbsp;</TD>
											<TD class="fontHead" width="125">First Name</TD>
											<TD>
												<asp:TextBox id=txtFirstName tabIndex=1 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FirstName").ToString  %>'> </asp:TextBox></TD>
											<TD width="10">&nbsp;</TD>
											<TD class="fontHead" width="125">Phone No.</TD>
											<TD>
												<asp:TextBox id=txtPhoneNumber tabIndex=4 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PhoneNumber").ToString  %>'> </asp:TextBox></TD>
										</TR>
										<TR>
											<TD width="10">&nbsp;</TD>
											<TD class="fontHead" width="125">Last Name</TD>
											<TD>
												<asp:TextBox id=txtLastName tabIndex=2 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Lastname").ToString  %>'> </asp:TextBox></TD>
											<TD width="10">&nbsp;</TD>
											<TD class="fontHead" width="125">Mobile No.</TD>
											<TD>
												<asp:TextBox id=txtMobileNumber tabIndex=5 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MobileNumber").ToString  %>'> </asp:TextBox></TD>
										</TR>
										<TR>
											<TD width="10">&nbsp;</TD>
											<TD class="fontHead" width="125">Title</TD>
											<TD>
												<asp:TextBox id=txtTitle tabIndex=3 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Title").ToString  %>'> </asp:TextBox></TD>
											<TD width="10">&nbsp;</TD>
											<TD class="fontHead" width="125">Email</TD>
											<TD>
												<asp:TextBox id=txtEmail tabIndex=6 runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Email").ToString  %>'> </asp:TextBox></TD>
										</TR>
									</TABLE>
								</EditItemTemplate>
							</asp:datalist></TD>
					</TR>
				</TABLE>
			</asp:panel><asp:panel id="pnlVendor" runat="server">
				<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD width="100%">
							<cc2:bwimagebutton id="btnAddVendor" runat="server"></cc2:bwimagebutton></TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
				<asp:datalist id="VendorDatalist" runat="server" Width="800" DataKeyField="TradePartnerVendorID"
					BackColor="White" BorderWidth="0px" OnItemDataBound="VendorDatalist_ItemDataBound">
					<HeaderTemplate>
						<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0" height="22">
							<tr class="TableHeaderOver">
								<td class="fontHead" width="50">&nbsp;</td>
								<td class="fontHead" width="200"><%#GetSystemText("Vendor")%></td>
								<td class="fontHead" width="100"><%#GetSystemText("City")%></td>
								<td class="fontHead" width="100"><%#GetSystemText("State")%></td>
								<td class="fontHead" width="100"><%#GetSystemText("Country")%></td>
								<td class="fontHead" width="100"><%#GetSystemText("Phone Number")%></td>
							</tr>
						</table>
					</HeaderTemplate>
					<EditItemStyle BorderWidth="0px"></EditItemStyle>
					<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
					<FooterTemplate>
					</FooterTemplate>
					<ItemStyle BackColor="White"></ItemStyle>
					<ItemTemplate>
						<TABLE width="100%">
							<TR>
								<TD class="fontHead" width="50">
									<cc2:bwimagebutton id="btnEditVendor" runat="server"></cc2:bwimagebutton></TD>
								<TD class="font" width="205"><%#Container.DataItem("VendorName")%></TD>
								<TD class="font" width="105"><%#Container.DataItem("City")%></TD>
								<TD class="font" width="105"><%#Container.DataItem("State")%></TD>
								<TD class="font" width="105"><%#Container.DataItem("Country")%></TD>
								<TD class="font" width="100"><%#Container.DataItem("PhoneNumber")%></TD>
							</TR>
						</TABLE>
					</ItemTemplate>
				</asp:datalist>
			</asp:panel></form>
	</body>
</HTML>
