<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Main.aspx.vb" Inherits="plmOnApp.Style_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Variation" Src="Style_Variation.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Variation</title>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">		
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</head>
	<BODY>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="100%">&nbsp;
						<cc1:confirmedimagebutton id="btnEdit" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:BWImageButton id="btnCopy" runat="server"  Message="NONE"></cc1:BWImageButton>
                    </td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="10" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="top"><asp:datalist id="dlVariation" runat="server" RepeatDirection="Horizontal">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:Label id=lblVariation runat="server" CssClass="fontHead">
											</asp:Label></td>
									</tr>
								</table>
								<uc1:Style_Variation id=Style_Variation1 runat="server" StyleDevelopmentID='<%# string.Concat(DataBinder.Eval(Container.DataItem, "StyleDevelopmentID").ToString) %>' StyleVariation='<%# string.Concat(DataBinder.Eval(Container.DataItem, "Variation").ToString) %>'>
								</uc1:Style_Variation>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
	</BODY>
</html>
