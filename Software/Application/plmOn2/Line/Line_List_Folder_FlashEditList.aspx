<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Line_List_Folder_FlashEditList.aspx.vb" Inherits="plmOnApp.Line_List_Folder_FlashEditList" %>
<%@ Register Src="Line_List_Header.ascx" TagName="Header" TagPrefix="hc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
		<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<TR vAlign="middle">
				<TD height="22px" vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<td>&nbsp;</td>
			</TR>
		</TABLE>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
			</tr>
		</table>
        <hc1:Header ID="LineListHeader" runat="server" />
        <br />
        <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
            <tr colspan="2"><td>&nbsp;</td></tr>
            <tr>
                <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
                <td vAlign="top" width="100%">
                    <table height="45">
                        <tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
                    </table>
                </td>
            </tr>
        </table>
		<TABLE cellSpacing="1" cellPadding="0" width="100%" border="0">
			<TR vAlign="top">
				<TD>
					<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
						<TR vAlign="middle">
							<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
							<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
							<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
							<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
							<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
							<TD width="10">&nbsp;</TD>
							<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
								<TD align="right" width="110"><asp:label id="RecordPerPage" runat="server" CssClass="font"></asp:label></TD>
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
					<asp:datagrid id="DataGrid1" runat="server" DataKeyField="LineListFlashEditID" AllowSorting="true">
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
					</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False" Text="LineListFlashEditSort"></asp:label></TD>
			</TR>
		</TABLE>
    </form>
</body>
</html>

