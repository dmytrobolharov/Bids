<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_Message.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_Message" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		 <title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td><cc1:confirmedimagebutton id="btnSend" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnDelete" runat="server" WindowName="Delete"></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"> </asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="800" bgColor="#ffffff"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></TD>
				</TR>
			</TABLE>
			<!--
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top" width="450" bgColor="#ffffff">
						<TABLE class="TableHeader" id="Table4" height="25" cellSpacing="0" cellPadding="0" width="100%"
							border="0" runat="server">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD>Message</TD>
							</TR>
						</TABLE>
						<br>
						<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
							<TR>
								<TD width="10">&nbsp;</TD>
								<TD class="fontHead" width="50">Subject:</TD>
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
									Message:</TD>
								<TD><asp:textbox id="txtMessage" runat="server" Width="325px" Height="200px" TextMode="MultiLine"></asp:textbox></TD>
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
								<TD>Select Send To...</TD>
							</TR>
						</TABLE>
						<asp:datalist id="dlTradePartner" runat="server" Width="100%" CellPadding="0" ShowFooter="False"
							DataKeyField="TradePartnerID">
							<HeaderTemplate>
								&nbsp;Select Trade Partner...
							</HeaderTemplate>
							<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<ItemTemplate>
								<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD class="fontHead">&nbsp;<%# DataBinder.Eval(Container.DataItem, "TradePartnerName")%></TD>
									</TR>
								</TABLE>
								<asp:DataGrid id=dgTradeContact runat="server" Width="100%" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="TradePartnerContactId" DataSource='<%# TradePartnerContactDataTable(DataBinder.Eval(Container.DataItem, "TradePartnerId").ToString) %>' ShowHeader="False">
									<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
									<ItemStyle CssClass="ItemTemplate"></ItemStyle>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
									<Columns>
										<asp:TemplateColumn ItemStyle-Width="20px">
											<HeaderTemplate>
											</HeaderTemplate>
											<ItemTemplate>
												<INPUT type="checkbox" name='<%#Container.DataItem("TradePartnerContactID").Tostring%>' value='<%#Container.DataItem("TradePartnerContactID").Tostring%>'>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn ItemStyle-Width="125px">
											<HeaderTemplate>
											</HeaderTemplate>
											<ItemTemplate>
												<asp:Label id="lblContactName" runat="server"><%#Container.DataItem("FirstName")%>&nbsp;<%#Container.DataItem("LastName")%></asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderTemplate>
											</HeaderTemplate>
											<ItemTemplate>
												<asp:Label id="lblContactEmail" runat="server">
													<%#Container.DataItem("Email").ToString%>
												</asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:DataGrid>
							</ItemTemplate>
							<HeaderStyle Height="24px" CssClass="TableHeader"></HeaderStyle>
						</asp:datalist>
						<!--
							<br><asp:datalist id="dlTeam" runat="server" Width="100%" ShowHeader="false" DataKeyField="TeamID"
							ShowFooter="False" CellPadding="0">
							<ItemTemplate>
								<TABLE>
									<TR>
										<TD>&nbsp;&nbsp;</TD>
										<TD>
											<asp:CheckBox id="cbTeam" runat="server"></asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id="lblFullName" CssClass="font"><%# DataBinder.Eval(Container.DataItem, "FullName")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id="lblEmail" runat="server" CssClass="font" Font-Italic="true">
												<%# Container.DataItem("Email")%>
											</asp:Label></TD>
									</TR>
								</TABLE>
								<asp:TextBox id=txtEmail runat="server" Visible="false" Text='<%# Container.DataItem("Email")%>'>
								</asp:TextBox>
								<asp:TextBox id=txtFullName runat="server" Visible="false" Text='<%# Container.DataItem("FullName")%>'>
								</asp:TextBox>
							</ItemTemplate>
							<HeaderStyle Height="24px" CssClass="TableHeaderOver"></HeaderStyle>
						</asp:datalist>
						</TD>
				</TR>
			</TABLE>
			-->
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
                        <asp:Label ID="lblHeaderAgent" runat="server" ></asp:Label></TD>
				</TR>
			</TABLE>
			<asp:datalist id="dlAgent" runat="server" Width="100%" DataKeyField="TradePartnerID" ShowFooter="False"
				CellPadding="0">
				<AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<ItemTemplate>
					<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
						<TR>
							<TD width='20px'>
								<asp:CheckBox id="cbAgent" runat="server"></asp:CheckBox></TD>
							<TD class="fontHead">(<%# DataBinder.Eval(Container.DataItem, "TradePartnerCode")%>)&nbsp;<%# DataBinder.Eval(Container.DataItem, "TradePartnerName")%></TD>
							<td>
								<asp:TextBox id=txtTradePartnerId runat="server" Visible="false" Text='<%# Container.DataItem("TradePartnerId").ToString%>'>
								</asp:TextBox></td>
						</TR>
					</TABLE>
					<asp:datalist id="dlVendor" runat="server" Width="100%" ShowFooter="False" CellPadding="0">
						<ItemTemplate>
							<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD width='25px'>&nbsp;</TD>
									<TD class="font">(<%# DataBinder.Eval(Container.DataItem, "VendorCode")%>)&nbsp;<%# DataBinder.Eval(Container.DataItem, "VendorName")%></TD>
									<td>&nbsp;</td>
								</TR>
							</TABLE>
						</ItemTemplate>
					</asp:datalist>
				</ItemTemplate>
			</asp:datalist>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
