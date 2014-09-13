<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_List_History.aspx.vb" Inherits="plmOnApp.Body_List_History" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Body History</title>
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClear" runat="server" Message="NULL"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Body History Folder...</asp:label></td>
				</tr>
			</table>
			<asp:datalist id="Datalist1" runat="server" CssClass="font" Datakeyfield="BodyID" BorderWidth="1px"
				BorderStyle="Solid" BorderColor="Silver" BackColor="White" RepeatColumns="5" RepeatDirection="Horizontal"
				GridLines="Both">
				<HeaderTemplate>
				</HeaderTemplate>
				<ItemStyle Height="250px" VerticalAlign="Top" BorderColor="Silver" BorderWidth="1px"></ItemStyle>
				<ItemTemplate>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td valign="top" style="height: 240px">
								<table width="100%" class="TableHeader" cellpadding="0" cellspacing="0" border="0">
									<tr>
										<td>
											<cc1:BWImageButton id="btnImgNewWindow" runat="server" CommandName="Window"></cc1:BWImageButton>&nbsp;</td>
									</tr>
									<tr>
										<td valign="top" bgColor="#ffffff" height="150" style="height: 240px">
										<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton>
										</td>
									</tr>
								</table>
								<table width="100%">
									<tr>
										<td width="85"><FONT size="1"><B>Body No:</B></FONT></td>
										<td><FONT size="1"><%#Container.DataItem("BodyNo")%></FONT></td>
									</tr>
									<tr>
										<td width="85" style="height: 14px"><FONT size="1"><B>Description:</B></FONT></td>
										<td style="height: 14px"><FONT size="1"><%#Container.DataItem("Description")%></FONT></td>
									</tr>
								</table>
					<INPUT id="txtBodyNo" type=hidden value='<%# DataBinder.Eval(Container.DataItem, "BodyNo") %>' name="txtBodyNo" runat="server"></td>
						</tr>
					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</html>

