<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_TechPack.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_TechPack" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</HEAD>
	<body MS_POSITIONING="GridLayout">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td height="20"><cc1:confirmedimagebutton id="btnSend" runat="server" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnPreview" runat="server" ></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnTechLog" runat="server"></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnTechDelete" runat="server" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" width="50%">
						<table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>
                                    <asp:Label ID="lblTechPackH" runat="server"></asp:Label></td>
							</tr>
						</table>
						<table cellSpacing="1" cellPadding="0" width="100%" bgColor="#e4e4e4" border="0">
							<tr bgColor="#ffffff">
								<td width="15">&nbsp;</td>
								<td class="fontHead" width="100"><asp:Label ID="lblTechPackNumH" runat="server"></asp:Label>
								</td>
								<td class="font">&nbsp;
									<asp:label id="txtTechPackNo" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td>&nbsp;</td>
								<td class="fontHead"><asp:Label ID="lblTechPackNameH" runat="server"></asp:Label>
								</td>
								<td class="font">&nbsp;
									<asp:label id="txtTechPackName" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15">&nbsp;</td>
								<td class="fontHead" width="100">&nbsp;</td>
								<td class="font">&nbsp;
								</td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15">&nbsp;</td>
								<td class="fontHead" width="100"><asp:Label ID="lblCreatedByH" runat="server"></asp:Label>
								</td>
								<td class="font">&nbsp;
									<asp:label id="txtCUser" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15">&nbsp;</td>
								<td class="fontHead" width="100"><asp:Label ID="lblCreatedDateH" runat="server"></asp:Label></td>
								<td class="font">&nbsp;
									<asp:label id="txtCDate" runat="server"></asp:label></td>
							</tr>
							<tr bgColor="#ffffff">
								<td>&nbsp;</td>
								<td class="fontHead">&nbsp;</td>
								<td class="font">&nbsp;</td>
							</tr>
							<tr bgColor="#ffffff">
								<td>&nbsp;</td>
								<td class="fontHead" colSpan="2"><asp:radiobuttonlist id="rbSendMethod" runat="server" RepeatDirection="Horizontal" CssClass="fontHead"
										Width="250px">
									
									</asp:radiobuttonlist></td>
							</tr>
							<tr bgColor="#ffffff">
								<td>&nbsp;</td>
								<td class="fontHead">&nbsp;</td>
								<td class="font">&nbsp;</td>
							</tr>
							<tr bgColor="#ffffff">
								<td width="15">&nbsp;</td>
								<td class="fontHead" vAlign="top" width="100">
									<TABLE height="5" cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TR>
											<TD height="5"></TD>
										</TR>
									</TABLE>
									<asp:Label ID="lblMessageH" runat="server"></asp:Label>
								</td>
								<td class="font">&nbsp;
									<asp:textbox id="txtMessage" runat="server" CssClass="font" Width="296px" TextMode="MultiLine"
										Height="160px"></asp:textbox></td>
							</tr>
						</table>
						<asp:datagrid id="dgTechMessage" runat="server" Width="100%" ShowHeader="False" BorderColor="#E0E0E0"
							BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="False">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemStyle Width="25px"></ItemStyle>
									<ItemTemplate>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemTemplate>
										<%#Container.DataItem("TechPackMessage")%>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemStyle Width="150px"></ItemStyle>
									<ItemTemplate>
										<%#Container.DataItem("CUser")%>
										&nbsp;<%#Container.DataItem("CDate")%>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
					</td>
					<td vAlign="top" width="50%">
						<table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td><asp:Label ID="lblTechPackPagesH" runat="server"></asp:Label>
								</td>
							</tr>
						</table>
						<asp:datagrid id="dgTechPage" runat="server" Width="100%" AutoGenerateColumns="False" PageSize="100"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0" ShowHeader="False">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Width="100%"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemStyle Width="20px"></ItemStyle>
									<ItemTemplate>
										<div align="center">
											<asp:Image id="Image1" runat="server"></asp:Image>
											<asp:Image id="Image2" runat="server"></asp:Image>
											<asp:Image id="Image3" runat="server"></asp:Image>
											<asp:Image id="Image4" runat="server"></asp:Image>
										</div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemTemplate>
										<asp:label id="lbTechPackPageName" runat="server"></asp:label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
						<table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td><asp:Label ID="lblSentToH" runat="server"></asp:Label>&nbsp;...
								</td>
							</tr>
						</table>
						<asp:datalist id="dlTeam" runat="server" Width="100%" BorderWidth="0" BorderStyle="None" CellSpacing="1"
							CellPadding="0" ShowFooter="False" DataKeyField="TeamID">
							<HeaderTemplate>
								<table>
									<tr>
										<td colspan="3" class="fontHead">&nbsp;<asp:Label ID="lblSelectTeamH" runat="server"><%#GetSystemText("Select Team ..")%></asp:Label></td>
									</tr>
								</table>
							</HeaderTemplate>
							<AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="AliceBlue"></ItemStyle>
							<ItemTemplate>
								<TABLE>
									<TR>
										<TD width="10">&nbsp;</TD>
										<TD width="20">
											<asp:CheckBox id=chkTeam runat="server" Visible='<%#DisplayVisible(Container.DataItem("Email").ToString)%>'>
											</asp:CheckBox></TD>
										<TD class="font"><%#Container.DataItem("FirstName")%>&nbsp;<%#Container.DataItem("LastName")%></TD>
										<TD class="font"><%#Container.DataItem("Email")%><INPUT id=Mail type=hidden value='<%# Container.DataItem("Email")%>' name=Mail runat="server">
											<INPUT id=To type=hidden value='<%#Container.DataItem("FirstName") &amp; " " &amp; Container.DataItem("LastName")%>' name=To runat="server">
										</TD>
									</TR>
								</TABLE>
							</ItemTemplate>
							<HeaderStyle Height="24px" CssClass="TableHeader"></HeaderStyle>
						</asp:datalist><asp:datalist id="dlTradePartner" runat="server" Width="100%" CellPadding="0" ShowFooter="False"
							DataKeyField="TeamID">
							<HeaderTemplate>
								&nbsp;<asp:Label ID="lblSelectTradePartnerH" runat="server"><%#GetSystemText("Select Trade Partner...")%></asp:Label>
							</HeaderTemplate>
							<AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="AliceBlue"></ItemStyle>
							<ItemTemplate>
								<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD class="fontHead">&nbsp;<%# DataBinder.Eval(Container.DataItem, "Company")%></TD>
									</TR>
								</TABLE>
								<TABLE>
									<TR id=TR1 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail1").ToString)%>'>
										<TD>&nbsp;&nbsp; <INPUT id="Mail1" type="hidden" runat="server" NAME="Mail1" value='<%# Container.DataItem("ContactEmail1")%>'>
											<INPUT id="To1" type="hidden" runat="server" NAME="To1" value='<%# Container.DataItem("Company")%>'>
										</TD>
										<TD>
											<asp:CheckBox id=chkTradePartner1 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail1").ToString)%>'>
											</asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id=ContactName1 CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail1").ToString)%>'><%# DataBinder.Eval(Container.DataItem, "Contactname1")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id=ContactMail1 runat="server" CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail1").ToString)%>'>
												<%# Container.DataItem("ContactEmail1")%>
											</asp:Label></TD>
									</TR>
									<TR id=TR2 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail2").ToString)%>'>
										<TD>&nbsp;&nbsp; <INPUT id="Mail2" type="hidden" runat="server" NAME="Mail2" value='<%# Container.DataItem("ContactEmail2")%>'>
											<INPUT id="To2" type="hidden" runat="server" NAME="To2" value='<%# Container.DataItem("Company")%>'>
										</TD>
										<TD>
											<asp:CheckBox id=chkTradePartner2 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail2").ToString)%>'>
											</asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id=ContactName2 CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail2").ToString)%>'><%# DataBinder.Eval(Container.DataItem, "Contactname2")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id=ContactMail2 runat="server" CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail2").ToString)%>'>
												<%# Container.DataItem("ContactEmail2")%>
											</asp:Label></TD>
									</TR>
									<TR id=TR3 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail3").ToString)%>'>
										<TD>&nbsp;&nbsp; <INPUT id="Mail3" type="hidden" runat="server" NAME="Mail3" value='<%# Container.DataItem("ContactEmail3")%>'>
											<INPUT id="To3" type="hidden" runat="server" NAME="To3" value='<%# Container.DataItem("Company")%>'>
										</TD>
										<TD>
											<asp:CheckBox id=chkTradePartner3 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail3").ToString)%>'>
											</asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id=ContactName3 CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail3").ToString)%>'><%# DataBinder.Eval(Container.DataItem, "Contactname3")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id=ContactMail3 runat="server" CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail3").ToString)%>'>
												<%# Container.DataItem("ContactEmail3")%>
											</asp:Label></TD>
									</TR>
									<TR id=TR4 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail4").ToString)%>'>
										<TD>&nbsp;&nbsp; <INPUT id="Mail4" type="hidden" runat="server" NAME="Mail4" value='<%# Container.DataItem("ContactEmail4")%>'>
											<INPUT id="To4" type="hidden" runat="server" NAME="To4" value='<%# Container.DataItem("Company")%>'>
										</TD>
										<TD>
											<asp:CheckBox id=chkTradePartner4 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail4").ToString)%>'>
											</asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id=ContactName4 CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail4").ToString)%>'><%# DataBinder.Eval(Container.DataItem, "Contactname4")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id=ContactMail4 runat="server" CssClass="font" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail4").ToString)%>'>
												<%# Container.DataItem("ContactEmail4")%>
											</asp:Label></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
							<HeaderStyle Height="24px" CssClass="TableHeader"></HeaderStyle>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
