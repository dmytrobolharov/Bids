<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_History.aspx.vb" Inherits="plmOnApp.Sourcing_History" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Color History</title>
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form2" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClear" runat="server"  ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
            <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="SourcingHeaderID" AutoGenerateColumns="False" BorderWidth="1">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                            <asp:TemplateColumn>
                            <HeaderTemplate>
                               <asp:Label ID="Label1" runat="server" ><%# GetSystemText("Sourcing Type")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                            <asp:label runat="server" ID="lblColorTypeDescription"><%# Container.DataItem("SourcingTypeName")%></asp:label>
                            </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                            <HeaderTemplate>
                               <asp:Label ID="Label1" runat="server" ><%# GetSystemText("Sourcing Name")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                            <asp:label runat="server" ID="lblColorFolderDescription"><%# Container.DataItem("SourcingName")%></asp:label>
                            </ItemTemplate>
                            </asp:TemplateColumn>
                            </Columns>
						</asp:datagrid>
			</form>
	</body>
</html>

