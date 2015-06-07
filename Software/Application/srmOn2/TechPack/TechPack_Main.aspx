<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Main.aspx.vb" Inherits="srmOnApp.TechPack_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../Style/Style_Header.ascx" tagname="Style_Header" tagprefix="uc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Tech Pack</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblStyleHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
							ForeColor="#E0E0E0">Tech Pack</asp:label></td>
				</tr>
			</table>
			<uc1:Style_Header ID="Style_Header1" runat="server" />
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="top">
						<asp:DataGrid id="dgTechPack" runat="server" ShowHeader="true" AutoGenerateColumns="False" Width="800px"
							OnItemDataBound="dlTechPack_ItemDataBound" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver"
							DataKeyField="TechPackId">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemStyle Width="25px"></ItemStyle>
									<ItemTemplate>
										<div align="center">
											<asp:Image id="imgPdf" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
										</div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Tech Pack No")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechPackNo" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label2"><%#GetSystemText("Tech Pack Name")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechPackName" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label3"><%#GetSystemText("Tech Pack Date")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechPackDate" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label4"><%#GetSystemText("Downloaded")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechpackDownload" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label5"><%#GetSystemText("Season")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechPackSeason" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="Year">
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label6"><%#GetSystemText("Year")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechPackYear" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
								<ItemStyle Width="125px"></ItemStyle>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label7"><%# GetSystemText("Measurements")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechPackMeas" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
								<ItemStyle Width="125px"></ItemStyle>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label8"><%#GetSystemText("Bom")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblTechPackBom" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid></td>
				</tr>
			</table>
		    
		</form>
	</body>
</HTML>
