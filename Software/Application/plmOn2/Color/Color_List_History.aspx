<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_List_History.aspx.vb" Inherits="plmOnApp.Color_List_History" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Color History</title>
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
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
            <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="ColorFolderID" AutoGenerateColumns="False" BorderWidth="1">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                            <asp:TemplateColumn>
                            <HeaderTemplate>
                               <asp:Label ID="Label1" runat="server" ><%# GetSystemText("Palette Type")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                            <asp:label runat="server" ID="lblColorTypeDescription"><%#Container.DataItem("ColorTypeDescription")%></asp:label>
                            </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                            <HeaderTemplate>
                               <asp:Label runat="server" ><%# GetSystemText("Palette Name")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                            <asp:label runat="server" ID="lblColorFolderDescription"><%#Container.DataItem("ColorFolderDescription")%></asp:label>
                            </ItemTemplate>
                            </asp:TemplateColumn>
                            </Columns>
						</asp:datagrid>
			</form>
	</body>
</html>
