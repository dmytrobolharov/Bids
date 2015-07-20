<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Quote_Late.aspx.vb" Inherits="plmOnApp.Quote_Late" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Late</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Calendar.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<TR>
						<TD height="50">&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Quote Folder...</asp:label>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview>
			<TABLE class="TableHeaderRed" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD class="FontHead"><asp:label id="lblTitle" Runat="server">Late Sample Submit(s)</asp:label></TD>
				</TR>
			</TABLE>
			<table id="tbSearch" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0"
				runat="server">
				<TR>
					<TD style="HEIGHT: 19px" width="10">&nbsp;</TD>
					<TD style="HEIGHT: 19px"><asp:label id="lblAgent" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD style="HEIGHT: 19px"><asp:label id="lblVendor" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD style="HEIGHT: 19px"></TD>
					<TD style="HEIGHT: 19px">&nbsp;</TD>
					<TD style="HEIGHT: 19px"></TD>
					<TD style="HEIGHT: 19px"></TD>
				</TR>
				<tr>
					<td width="10" height="25"></td>
					<TD width="155" height="25"><asp:dropdownlist id="ddlAgent" runat="server" AutoPostBack="True" Width="150px"></asp:dropdownlist></TD>
					<TD width="125" height="25"><asp:dropdownlist id="ddlVendor" runat="server" AutoPostBack="True" Width="150px"></asp:dropdownlist></TD>
					<TD height="25"><asp:button id="Button1" runat="server" CssClass="fontHead" Text="Search"></asp:button></TD>
					<td height="25"></td>
					<TD height="25"></TD>
					<TD height="25"></TD>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="top"><asp:datalist id="dlSampleWorkflow" runat="server" RepeatDirection="Horizontal">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR vAlign="middle">
										<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
										<TD>
											<asp:Label id=lblSampleWorkflow runat="server" Text='<%# string.Concat(DataBinder.Eval(Container.DataItem, "GroupName").ToString) %>' CssClass="fontHead">
											</asp:Label></TD>
									</TR>
								</TABLE>
								<asp:Label id="lblSubmitList" runat="server" Text='<%# GetLaterSubmitLink(DataBinder.Eval(Container.DataItem, "SampleWorkflowId").ToString) %>' CssClass="fontHead">
								</asp:Label>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
