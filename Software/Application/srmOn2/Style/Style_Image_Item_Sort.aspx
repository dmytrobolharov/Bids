<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Image_Item_Sort.aspx.vb" Inherits="srmOnApp.Style_Image_Item_Sort" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Sort</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: red thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="30" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Medium"
							ForeColor="#E0E0E0">Sorting Images...</asp:label></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="False" Width="250px">
				<AlternatingItemStyle HorizontalAlign="Center" Height="20px" VerticalAlign="Middle" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle HorizontalAlign="Center" Height="20px" CssClass="font" VerticalAlign="Middle" BackColor="White"></ItemStyle>
				<HeaderStyle HorizontalAlign="Center" Height="20px" CssClass="TableHeader" VerticalAlign="Middle"></HeaderStyle>
				<Columns>
					
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Image")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Image id="imgFile"  runat="server">
							</asp:Image>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Sort")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox id="txtSort" runat="server" Font-Size="X-Large" Width="75px" Height="50px" MaxLength="5" Text="">
							</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
		</form>
	</body>
</html>
