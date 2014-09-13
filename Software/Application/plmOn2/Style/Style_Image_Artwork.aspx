<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Image_Artwork.aspx.vb" Inherits="plmOnApp.Style.Artwork.Style_Image_Artwork"   %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title></title>	
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Menu.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<body MS_POSITIONING="GridLayout">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
			<asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert2" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment>
			<asp:datalist id="Datalist1" runat="server" CssClass="font" Datakeyfield="StyleMaterialID" BorderWidth="1px"
				BorderStyle="Solid" BorderColor="Silver" BackColor="White" RepeatColumns="4" RepeatDirection="Horizontal"
				GridLines="Both" Width="100%">
				<HeaderTemplate>
				</HeaderTemplate>
				<ItemStyle Height="250px" VerticalAlign="Top"></ItemStyle>
				<ItemTemplate>
					<table width="100%">
						<tr>
							<td valign="top">
								<table width="100%">
									<tr>
										<td align="center">
											<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton>
										</td>
									</tr>
								</table>
								<table width="100%">
									<tr>
										<td width="85"><FONT size="1"><B><%#GetSystemText("Material No")%>:</B></FONT></td>
										<td><FONT size="1"><%#Container.DataItem("MaterialNo")%></FONT></td>
									</tr>
									<tr>
										<td width="85"><FONT size="1"><B><%#GetSystemText("Material Name")%>:</B></FONT></td>
										<td><FONT size="1"><%#Container.DataItem("MaterialName")%></FONT></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</html>
