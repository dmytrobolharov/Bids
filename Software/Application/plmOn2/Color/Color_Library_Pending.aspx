<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_Library_Pending.aspx.vb" Inherits="plmOnApp.Color_Library_Pending" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title runat="server" id="PageTitle">Palette</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10" height="25"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
		            <td><asp:Label ID="lblColorPalette" runat="server" Text=""></asp:Label></td>
	            </tr>
            </table>		
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table height="45">
							<tr><td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td></tr>
						</table>
					</td>
				</tr>
			</table>            

			<table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></td>
					<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></td>
					<td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fonthead"></asp:label></td>
					<td width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></td>
					<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></td>
					<td width="10">&nbsp;</td>
					<td><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>				
					<td class="fonthead" align="right" nowrap="nowrap"><asp:label id="lblRecordsPerPage" runat="server" CssClass="fonthead">Records per Page:</asp:label></td>
					<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fonthead">
							<asp:ListItem Value="5">5</asp:ListItem>
							<asp:ListItem Value="10">10</asp:ListItem>
							<asp:ListItem Value="15">15</asp:ListItem>
							<asp:ListItem Value="20">20</asp:ListItem>
							<asp:ListItem Value="25">25</asp:ListItem>
							<asp:ListItem Value="30">30</asp:ListItem>
							<asp:ListItem Value="40">40</asp:ListItem>
							<asp:ListItem Value="50" Selected="true">50</asp:ListItem>
						</asp:dropdownlist></td>
					<td width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
					<td>&nbsp;</td>
				</tr>
			</table>
            <asp:datagrid id="DataGrid1" runat="server" DataKeyField="ColorPaletteID">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                </AlternatingItemStyle>
                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                <PagerStyle Visible="False"></PagerStyle>
            </asp:datagrid>
		</form>
	</body>
</HTML>
