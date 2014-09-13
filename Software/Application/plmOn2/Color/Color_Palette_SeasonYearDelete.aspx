﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_Palette_SeasonYearDelete.aspx.vb" Inherits="plmOnApp.Color_Palette_SeasonYearDelete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    		<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<td width="1"><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton></td>
				<td valign="top">
				    <asp:ImageButton runat="server" ID="btnRemove" />
				    <asp:ImageButton runat="server" ID="btnClose" />
                </td>
				<td width="75">&nbsp;</td>
				<td align="right"></td>
			</TR>
		</TABLE>

        <table cellSpacing="0" cellPadding="0" width="100%" border="0" class="TableHeader">
			<tr>
				<td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>&nbsp;<asp:Label ID="lblColorSearch" runat="server" Text="">Season & Year </asp:Label></td>
			</tr>
		</table>

		<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			<tr>
				<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
				<td vAlign="top" width="100%">
					<table height="45">
						<tr>
							<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
								<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD class="fontHead" align="right"><asp:label id="lblRecordsPerPage" runat="server" CssClass="fontHead" Text="Records per Page:"></asp:label></TD>
								<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
							</TR>
						</TABLE>
						<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="ColorFolderSeasonYearID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
				    
							<Columns>
							    <asp:TemplateColumn>
							        <ItemTemplate>
							            <asp:CheckBox  runat="server" ID="chkSelect" />
							        </ItemTemplate>
							    </asp:TemplateColumn>
							</Columns>
							
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
    </form>
</body>
</html>
