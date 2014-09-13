<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DetailGrid_Delete.aspx.vb" Inherits="plmOnApp.Style.DetailGrid.Style_DetailGrid_Delete"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Delete</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td valign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnDelete" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
						<td></td>
					</tr>
				</TBODY>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Delete Size</asp:label></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
				BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="StyleDetailGridID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle CssClass="TableHeaderRed" Width="20"></HeaderStyle>
						<ItemStyle BackColor="Pink"></ItemStyle>
						<HeaderTemplate>
							<!--<INPUT id="checkAll1" onclick="CheckAll(this);" type="checkbox" CHECKED runat="server">-->
							<img  id="checkAll" src="../System/Icons/icon_delete.gif" />
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server" ToolTip='<%#GetSystemText("Remove item")%>...'></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="lblSize" runat="server"><%#GetSystemText("Size")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<%#DataBinder.Eval(Container.DataItem,"StyleDetailCustom1").tostring%>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
		</form>
	</body>
</html>
