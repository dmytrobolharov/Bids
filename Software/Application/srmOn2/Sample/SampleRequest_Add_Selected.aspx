<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Quote_Style_User" Src="Quote_Style_User.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Image_User" Src="../Image/Image_User.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Add_Selected.aspx.vb" Inherits="srmOnApp.SampleRequest_Add_Selected" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Concept_Folder_View</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body bgColor="#ffffff">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server" ID="Table3">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:label id="lblStyleSelectedForQuote" runat="server">Style Selected for Quote...</asp:label></TD>
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
											<asp:Image id=Image1 runat="server" ImageAlign="Middle">
											</asp:Image></TD>
									</TR>
								</TABLE>
								<TABLE width="100%">
									<TR>
										<TD width="85"><FONT size="1"><B><asp:label id="lblAddress" runat="server"><%#GetSystemText("Style No")%>:</asp:label></B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("StyleNo")%></FONT></TD>
									</TR>
									<TR>
										<TD width="85"><FONT size="1"><B><asp:label id="Label1" runat="server"><%#GetSystemText("Style Name")%>:</asp:label></B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("Description")%></FONT></TD>
									</TR>
									<TR>
										<TD width="85"><FONT size="1"><B><asp:label id="Label2" runat="server"><%#GetSystemText("Concept Status")%>:</asp:label></B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("StyleStatus")%></FONT></TD>
									</TR>
								</TABLE>
								<uc1:Quote_Style_User id=Quote_Style_User1 runat="server" QuoteFolderItemID='<%#Container.DataItem("QuoteFolderItemID")%>'>
								</uc1:Quote_Style_User></TD>
						</TR>
					</TABLE>
					<INPUT id=txtQuoteFolderItemID type=hidden value='<%#DataBinder.Eval(Container.DataItem,"QuoteFolderItemID").tostring%>' name=txtQuoteFolderItemID runat="server">
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</HTML>
