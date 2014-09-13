<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Change_Log.aspx.vb" Inherits="srmOnApp.Style_Change_Log" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Change Management Log</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onblur="this.focus();" onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td height="20"><cc1:confirmedimagebutton id="btnClose" runat="server" Message="Are you sure you want to do close this form?"
							></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:label id="lblChangeLog" runat="server">Change Log...</asp:label>&nbsp;
					</td>
				</tr>
			</table>
			<asp:DataGrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				AutoGenerateColumns="False" DataKeyField="StyleChangeID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<ItemStyle Width="20px"></ItemStyle>
						<HeaderTemplate>
							&nbsp;
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Image id="Image1" runat="server" ImageUrl='<%# LoadIconStatus(Container.DataItem("Active"))%>' Width="16px" Height="16px">
							</asp:Image>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<ItemStyle Width="35px"></ItemStyle>
						<HeaderTemplate>
							<asp:label id="lblAddress" runat="server"><%#GetSystemText("ID")%></asp:label>
						</HeaderTemplate>
						<ItemTemplate>
							<%#Container.DataItem("StyleChangeNo")%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<ItemStyle Width="75px"></ItemStyle>
						<HeaderTemplate>
							<asp:label id="lblAddress" runat="server"><%#GetSystemText("Status")%></asp:label>
						</HeaderTemplate>
						<ItemTemplate>
							<%#Container.DataItem("StyleChangeType")%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<ItemStyle Width="250px"></ItemStyle>
						<HeaderTemplate>
							<asp:label id="lblAddress" runat="server"><%#GetSystemText("Notes")%></asp:label>
						</HeaderTemplate>
						<ItemTemplate>
							<%# Replace(Container.DataItem("StyleChangeDescription"),VbCrLf,"<BR>")%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<ItemStyle Width="150px"></ItemStyle>
						<HeaderTemplate>
							<asp:label id="lblAddress" runat="server"><%#GetSystemText("Sent To")%></asp:label>
						</HeaderTemplate>
						<ItemTemplate>
							<%#Container.DataItem("StyleChangeNotifyTo")%>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:DataGrid>
		</form>
	</body>
</HTML>
