<%@ Register TagPrefix="uc1" TagName="Line_List_Folder_Header" Src="Line_List_Folder_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_Message.aspx.vb" Inherits="plmOnApp.Line_List_Folder_Message" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Message</title>
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
					<td><cc1:confirmedimagebutton id="btnSend" runat="server"  Message=""></cc1:confirmedimagebutton></td>
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
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"> Line List Message...</asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="800" bgColor="#ffffff"><uc1:line_list_folder_header id="Line_List_Folder_Header1" runat="server"></uc1:line_list_folder_header></TD>
				</TR>
			</TABLE>
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
						<asp:datalist id="dlTeam" runat="server" CellPadding="0" ShowFooter="False" DataKeyField="TeamID"
							ShowHeader="false" Width="100%">
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
						</asp:datalist><asp:datalist id="dlTradePartner" runat="server" CellPadding="0" ShowFooter="False" DataKeyField="TeamID"
							ShowHeader="false" Width="100%">
							<ItemTemplate>
								<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD class="fontHead">&nbsp;<%# DataBinder.Eval(Container.DataItem, "Company")%></TD>
									</TR>
								</TABLE>
								<TABLE>
									<TR id=TR1 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail1").ToString)%>'>
										<TD>&nbsp;&nbsp;</TD>
										<TD>
											<asp:CheckBox id="cbTeam1" runat="server"></asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id="ContactName1" CssClass="font"><%# DataBinder.Eval(Container.DataItem, "Contactname1")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id="ContactMail1" runat="server" CssClass="font" Font-Italic="true">
												<%# Container.DataItem("ContactEmail1")%>
											</asp:Label></TD>
									</TR>
									<asp:TextBox id="txtEmail1" runat="server" Visible="false" Text='<%# Container.DataItem("ContactEmail1")%>'>
									</asp:TextBox>
									<asp:TextBox id="txtCompany1" runat="server" Visible="false" Text='<%# Container.DataItem("Contactname1")%>'>
									</asp:TextBox>
									<TR id=TR2 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail2").ToString)%>'>
										<TD>&nbsp;&nbsp;</TD>
										<TD>
											<asp:CheckBox id="cbTeam2" runat="server"></asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id="ContactName2" CssClass="font"><%# DataBinder.Eval(Container.DataItem, "Contactname2")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id="ContactMail2" runat="server" CssClass="font" Font-Italic="true">
												<%# Container.DataItem("ContactEmail2")%>
											</asp:Label></TD>
									</TR>
									<asp:TextBox id="txtEmail2" runat="server" Visible="false" Text='<%# Container.DataItem("ContactEmail2")%>'>
									</asp:TextBox>
									<asp:TextBox id="txtCompany2" runat="server" Visible="false" Text='<%# Container.DataItem("Contactname2")%>'>
									</asp:TextBox>
									<TR id=TR3 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail3").ToString)%>'>
										<TD>&nbsp;&nbsp;</TD>
										<TD>
											<asp:CheckBox id="cbTeam3" runat="server"></asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id="ContactName3" CssClass="font"><%# DataBinder.Eval(Container.DataItem, "Contactname3")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id="ContactMail3" runat="server" CssClass="font" Font-Italic="true">
												<%# Container.DataItem("ContactEmail3")%>
											</asp:Label></TD>
									</TR>
									<asp:TextBox id="txtEmail3" runat="server" Visible="false" Text='<%# Container.DataItem("ContactEmail3")%>'>
									</asp:TextBox>
									<asp:TextBox id="txtCompany3" runat="server" Visible="false" Text='<%# Container.DataItem("Contactname3")%>'>
									</asp:TextBox>
									<TR id=TR4 runat="server" Visible='<%#DisplayVisible(Container.DataItem("ContactEmail4").ToString)%>'>
										<TD>&nbsp;&nbsp;</TD>
										<TD>
											<asp:CheckBox id="cbTeam4" runat="server"></asp:CheckBox></TD>
										<TD class="font">
											<asp:Label id="ContactName4" CssClass="font"><%# DataBinder.Eval(Container.DataItem, "Contactname4")%>&nbsp;</asp:Label></TD>
										<TD class="font">
											<asp:Label id="ContactMail4" runat="server" CssClass="font" Font-Italic="true">
												<%# Container.DataItem("ContactEmail4")%>
											</asp:Label></TD>
									</TR>
									<asp:TextBox id="txtEmail4" runat="server" Visible="false" Text='<%# Container.DataItem("ContactEmail4")%>'>
									</asp:TextBox>
									<asp:TextBox id="txtCompany4" runat="server" Visible="false" Text='<%# Container.DataItem("Contactname4")%>'>
									</asp:TextBox>
								</TABLE>
							</ItemTemplate>
							<HeaderStyle Height="24px" CssClass="TableHeaderOver"></HeaderStyle>
						</asp:datalist></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
