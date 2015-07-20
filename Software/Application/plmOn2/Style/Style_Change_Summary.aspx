<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Change_Summary.aspx.vb" Inherits="plmOnApp.Style.Change.Style_Change_Summary" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left"><cc1:bwimagebutton id="btnNew" runat="server" ></cc1:bwimagebutton></td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table height="10" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblStyleHeaderNew" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Tech Pack</asp:label></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="top"><asp:datalist id="dlTechPackSize" runat="server">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table class="TableHeader" id="tbTechPackSize" height="25" cellspacing="0" cellpadding="0"
									width="825" border="0" runat="server">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:Label id="lblSizeClass" runat="server" CssClass="fontHead"></asp:Label>&nbsp;
											<asp:Label id="lblDueDate" runat="server" CssClass="fontHead"></asp:Label></td>
									</tr>
								</table>
								<asp:DataGrid id="dlTechPack" runat="server" ShowHeader="True" AutoGenerateColumns="False" Width="825px"
									OnItemDataBound="dlTechPack_ItemDataBound" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
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
											<ItemTemplate>
												<asp:Label id="lblTechPack" runat="server" />
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderStyle Width="300px" CssClass="TableHeader"></HeaderStyle>
											<HeaderTemplate>
												<asp:Label Runat="server" ID="lblCommentsHeader" CssClass="fontHead"><%#GetSystemText("Comments")%></asp:Label>
											</HeaderTemplate>
											<ItemTemplate>
												<asp:Label Runat="server" ID="lblComments" CssClass="font"></asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderStyle Width="150px" CssClass="TableHeader"></HeaderStyle>
											<HeaderTemplate>
												<asp:Label Runat="server" ID="lblCUserHeader" CssClass="fontHead"><%#GetSystemText("Created By")%></asp:Label>
											</HeaderTemplate>
											<ItemTemplate>
												<asp:Label Runat="server" ID="lblCUser" CssClass="font"></asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderStyle Width="150px" CssClass="TableHeader"></HeaderStyle>
											<HeaderTemplate>
												<asp:Label Runat="server" ID="lblCDateHeader" CssClass="fontHead"><%#GetSystemText("Created Date")%></asp:Label>
											</HeaderTemplate>
											<ItemTemplate>
												<asp:Label Runat="server" ID="lblCDate" CssClass="font"></asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:DataGrid>
								<BR>
							</ItemTemplate>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
	</body>
</html>
