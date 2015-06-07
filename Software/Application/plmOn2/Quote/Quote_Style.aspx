<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Quote_Style.aspx.vb" Inherits="plmOnApp.Quote_Style" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Quote</title>
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
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0">Quote Folder</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="top">
						<asp:DataGrid id="dgQuote" runat="server" ShowHeader="true" AutoGenerateColumns="False" Width="600px"
							OnItemDataBound="dgQuote_ItemDataBound" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver"
							DataKeyField="StyleQuoteItemId">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemStyle Width="25px"></ItemStyle>
									<ItemTemplate>
										<div align="center">
											<asp:Image id="imgQuote" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
										</div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
            						<HeaderTemplate>
            							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Quote No")%></asp:Label>
            						</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblQuoteNo" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
            						<HeaderTemplate>
            							<asp:Label runat="server" CssClass="fontHead" ID="label2"><%#GetSystemText("Quote Status")%></asp:Label>
            						</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblQuoteStatus" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
            						<HeaderTemplate>
            							<asp:Label runat="server" CssClass="fontHead" ID="label3"><%#GetSystemText("Vendor Name")%></asp:Label>
            						</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblQuoteVendorName" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
            						<HeaderTemplate>
            							<asp:Label runat="server" CssClass="fontHead" ID="label4"><%#GetSystemText("Quote Due Date")%></asp:Label>
            						</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblQuoteDueDate" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
