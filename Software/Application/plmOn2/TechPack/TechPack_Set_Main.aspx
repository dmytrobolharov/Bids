<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Set_Main.aspx.vb" Inherits="plmOnApp.TechPack_Set_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Tech Pack</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left"><cc1:bwimagebutton id="btnNew" runat="server" ></cc1:bwimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
							ForeColor="#E0E0E0">Tech Pack</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="top"><asp:datagrid id="dlTechPack" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
							 Width="825px" AutoGenerateColumns="False" ShowHeader="True">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn ItemStyle-Width="25">
									<HeaderStyle Width="25px" CssClass="TableHeader"></HeaderStyle>
									<ItemTemplate>
										<div align="center">
											<asp:Image id="imgPdf" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
										</div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label Runat="server" ID="lblTechPackNameHeader" CssClass="fontHead" Text='<%#GetSystemText("Tech Pack Name") %>'></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechPack" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Width="300px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label Runat="server" ID="lblCommentsHeader" CssClass="fontHead" Text='<%#GetSystemText("Comments") %>'></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label Runat="server" ID="lblComments" CssClass="font"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Width="150px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label Runat="server" ID="lblCUserHeader" CssClass="fontHead" Text='<%#GetSystemText("Created By") %>'></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label Runat="server" ID="lblCUser" CssClass="font"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Width="150px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label Runat="server" ID="lblCDateHeader" CssClass="fontHead" Text='<%#GetSystemText("Created Date") %>'></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label Runat="server" ID="lblCDate" CssClass="font"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
