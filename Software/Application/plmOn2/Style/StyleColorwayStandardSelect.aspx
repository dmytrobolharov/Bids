<%@ Page Language="vb" AutoEventWireup="false" Codebehind="StyleColorwayStandardSelect.aspx.vb" Inherits="plmOnApp.StyleColorwayStandardSelect"   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Combo</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
			function SelectColor(sColor,sTxtBox) 
			{
			opener.document.Form1[sTxtBox].value = sColor;
			self.close();
			}
		</script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="Medium" Font-Names="Tahoma,Verdana">Select Color...</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="top">
					<td>
						<table id="NavBar" height="30" cellSpacing="1" cellpadding="1" width="100%" bgColor="ghostwhite"
							border="0" runat="server">
							<tr valign="middle">
								<td class="fontHead" width="50">
									<DIV align="right"><asp:label id="lblSearch" runat="server" CssClass="fontHead">Search:</asp:label></DIV>
								</td>
								<td width="75"><asp:textbox id="txtSearch" runat="server" CssClass="font"></asp:textbox></td>
								<td width="10"><asp:imagebutton id="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif"></asp:imagebutton></td>
								<td><asp:dropdownlist id="ps" runat="server" CssClass="fontHead" Visible="False">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50">50</asp:ListItem>
										<asp:ListItem Value="75">75</asp:ListItem>
										<asp:ListItem Value="100" Selected="True">100</asp:ListItem>
									</asp:dropdownlist></td>
								<td><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO" Visible="false"></asp:button></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<table>
							<tr>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></td>
								<td noWrap align="center" width="100"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleColorStandardID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
