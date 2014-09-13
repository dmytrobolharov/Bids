<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_ShareMain.aspx.vb" Inherits="plmOnApp.Style_ShareMain" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Share</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400">
							<cc1:bwimagebutton id="btnTeamAdd" runat="server"  Visible="False"></cc1:bwimagebutton>
							<cc1:bwimagebutton id="btnAgentAdd" runat="server" ></cc1:bwimagebutton>
							<cc1:confirmedimagebutton id="btnNewTask" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						</td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table height="10" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblPageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Sharing...</asp:label>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="top"><asp:datalist id="dlTechPackSize" runat="server" RepeatDirection="Horizontal">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table class="TableHeader" id="tbTechPackSize" height="25" cellSpacing="0" cellpadding="0"
									width="250" border="0" runat="server">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:Label id="lblSizeClass" runat="server" CssClass="fontHead"></asp:Label></td>
									</tr>
								</table>
								<asp:DataGrid id="dlTeam" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
									OnItemDataBound="dlTeam_ItemDataBound" Width="250px" AutoGenerateColumns="False" Visible="false">
									<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
									<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
									<HeaderStyle Height="20px" CssClass="TableHeaderBlue"></HeaderStyle>
									<Columns>
										<asp:TemplateColumn>
											<ItemStyle Width="25px"></ItemStyle>
											<HeaderTemplate>
												&nbsp;
											</HeaderTemplate>
											<ItemTemplate>
												<div align="center">
													<asp:Image id="imgPdf" runat="server" ImageUrl="../System/Icons/icon_team.gif"></asp:Image>
												</div>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderTemplate>
												<%#GetSystemText("Team")%>
											</HeaderTemplate>
											<ItemTemplate>
												<asp:Label id="lblTeam" runat="server" />
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:DataGrid>
								<asp:DataGrid id="dlAgent" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
									OnItemDataBound="dlAgent_ItemDataBound" Width="250px" AutoGenerateColumns="False">
									<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
									<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
									<HeaderStyle Height="20px" CssClass="TableHeaderYellow"></HeaderStyle>
									<Columns>
										<asp:TemplateColumn>
											<ItemStyle Width="25px"></ItemStyle>
											<HeaderTemplate>
												&nbsp;
											</HeaderTemplate>
											<ItemTemplate>
												<div align="center">
													<asp:Image id="iconAgent" runat="server" ImageUrl="../System/Icons/icon_trade.gif"></asp:Image>
												</div>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn>
											<HeaderTemplate>
												<%#GetSystemText("Agent")%>
											</HeaderTemplate>
											<ItemTemplate>
												<asp:Label id="lblAgent" runat="server" />
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:DataGrid>
							</ItemTemplate>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
	</body>
</html>
