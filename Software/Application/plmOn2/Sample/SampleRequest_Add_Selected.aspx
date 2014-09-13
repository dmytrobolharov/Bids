<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Add_Selected.aspx.vb" Inherits="plmOnApp.SampleRequest_Add_Selected" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</HEAD>
	<body bgColor="#ffffff">
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server" ID="Table3">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
                       <asp:Label ID="lblHeader" runat="server" ></asp:Label></TD>
				</TR>
			</TABLE>
			<asp:datalist id="Datalist1" runat="server" CssClass="font" Datakeyfield="StyleID" BorderWidth="1px"
				BorderStyle="Solid" BorderColor="Silver" BackColor="White" RepeatColumns="4" RepeatDirection="Horizontal"
				GridLines="Both" Width="100%">
				<HeaderTemplate>
				</HeaderTemplate>
				<ItemStyle Height="250px" VerticalAlign="Top"></ItemStyle>
				<ItemTemplate>
					<TABLE width="200">
						<TR>
							<TD vAlign="top">
								<TABLE width="100%">
									<TR>
										<TD align="center"></TD>
									</TR>
								</TABLE>
								<TABLE width="100%">
									<TR>
										<TD align="center">
											<asp:Image id="ImgSampleSelected" runat="server" ImageAlign="Middle" ></asp:Image>
								        </TD>
									</TR>
								</TABLE>
								<TABLE width="100%">
									<TR>
										<TD width="85"><FONT size="1"><B><asp:Label ID="lblStyleNoH" runat="server"><%#GetSystemText("Style No")%>:</asp:Label></B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("StyleNo")%></FONT></TD>
									</TR>
									<TR>
										<TD width="85"><FONT size="1"><B><asp:Label ID="lblStyleName" runat="server"><%#GetSystemText("Style Name")%>:</asp:Label></B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("Description")%></FONT></TD>
									</TR>
									<TR>
										<TD width="85"><FONT size="1"><B><asp:Label ID="lblConceptStatus" runat="server"><%#GetSystemText("Concept Status")%>:</asp:Label></B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("StyleStatus")%></FONT></TD>
									</TR>
								</TABLE>
								</TD>
						</TR>
					</TABLE>
					<INPUT id=txtQuoteFolderItemID type=hidden value='<%#DataBinder.Eval(Container.DataItem,"QuoteFolderItemID").tostring%>' name=txtQuoteFolderItemID runat="server">
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</HTML>
