<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_New_Message.aspx.vb" Inherits="plmOn2Report.Style_New_Message" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title id="PageTitle" runat="server"></title>								
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="800" bgColor="#ffffff" border="0">
				<tr>
					<td>
						<asp:Label id="lblHeader" runat="server" Font-Size="Large"></asp:Label>
					</td>
					<td align="right"><IMG src="../logo.png"></td>
				</tr>
			</table>
			<table width="800" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><uc1:Style_Header id="Style_Header1" runat="server"></uc1:Style_Header></td>
				</tr>
			</table>
			<br>
			<asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="False" Width="800px">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle BackColor="WhiteSmoke" CssClass="fontHead"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Height="20px" Width="200px"></HeaderStyle>
						<HeaderTemplate>
							<asp:Label id="lblHeaderWorkflow" runat="server"><%#GetSystemText("Workflow")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblWorkflow" runat="server"></asp:Label><INPUT id="txtWorkflow" type="hidden" runat="server" NAME="txtWorkflow">
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle Height="20px" Width="200px"></HeaderStyle>
						<HeaderTemplate>
							<asp:Label id="lblHeaderStatus" runat="server"><%#GetSystemText("Status")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblStatus" runat="server"></asp:Label><INPUT id="Hidden1" type="hidden" runat="server" NAME="txtWorkflow">
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle Height="20px" Width="200px"></HeaderStyle>
						<HeaderTemplate>
							<asp:Label id="lblHeaderAssignedTo" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblAssignedTo" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns> 
			</asp:datagrid>
			<BR>
			&nbsp;<IMG src="../System/Icons/icon_link.gif"><asp:hyperlink id="hlReturn" runat="server" CssClass="fonthead" ForeColor="Blue" Font-Size="12px"
				Font-Underline="true" Target="_self">Click here to view style...</asp:hyperlink>
		</form>
	</body>
</html>
