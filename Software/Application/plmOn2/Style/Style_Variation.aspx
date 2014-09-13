<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Variation" Src="Style_Variation.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Variation.aspx.vb" Inherits="plmOnApp.Style_Variation" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Variation</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<asp:datalist id="dlVariation" runat="server" Width="300px" RepeatDirection="Horizontal">
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<table class="TableHeader" height="24" cellSpacing="0" cellpadding="0" width="100%" border="0">
						<tr valign="middle">
							<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
							<td>
								<asp:Label id=lblVariation runat="server" Text='<%# string.Concat("Variation " + DataBinder.Eval(Container.DataItem, "Variation").ToString) %>' CssClass="fontHead">
								</asp:Label></td>
						</tr>
					</table>

					<asp:PlaceHolder id="pnlVariation" runat="server"></asp:PlaceHolder>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</html>
