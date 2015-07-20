<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_TechPackDownload.aspx.vb" Inherits="srmOnApp.Style_TechPackDownload1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">srmOn</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link  href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Calendar.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

	    <TABLE class="TableHeader" cellSpacing="1" cellPadding="1" width="100%" border="0">
		    <TR>
			    <TD width="20" height="20"><IMG src="../System/Icons/icon_package.gif"></TD>
			    <TD><asp:label id="lblNewTechPack" runat="server">New Tech Pack</asp:label></TD>
		    </TR>
	    </TABLE>

<asp:Panel ID="pnlNavigation" runat="server" >
<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
	border="0">
	<TR vAlign="middle">
		<TD vAlign="middle" align="center" width="10">
            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
		<TD class="fontHead" width="100"></TD>
		<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
		<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
		<TD align="center" width="75">
            <asp:label id="lblPageCount" runat="server" CssClass="fontHead" style="white-space:nowrap;"></asp:label></TD>
		<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
		<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
		<TD width="10">&nbsp;</TD>
		<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
		<TD class="fontHead" align="right" width="110"><asp:label id="lblRecordsPerPage" runat="server">Records per Page:</asp:label></TD>
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


</asp:Panel>

<asp:DataGrid id="dgTechPack" runat="server" DataKeyField="TechPackId" BorderColor="Silver" BorderStyle="Solid"
	BorderWidth="1px" Width="100%" AutoGenerateColumns="False" AllowSorting="true" AllowPaging="true"  ShowHeader="true">
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	<Columns>
		<asp:TemplateColumn>
			<ItemStyle Width="25px"></ItemStyle>
			<ItemTemplate>
				<div align="center">
					<asp:Image id="imgPdf" runat="server" ImageUrl="../System/Icons/icon_pdf.gif"></asp:Image>
				</div>
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
			<HeaderTemplate>
				<asp:Label id="lblTechPackDateHeader" runat="server"><%#GetSystemText("TP Date")%></asp:Label>
			</HeaderTemplate>
			<ItemTemplate>
				<asp:Label id="lblTechPackDate" runat="server" />
			</ItemTemplate>
		</asp:TemplateColumn>
		<asp:TemplateColumn>
			<HeaderTemplate>
				<asp:Label id="lblStyleHeader" runat="server"></asp:Label>
			</HeaderTemplate>
			<ItemTemplate>
				<asp:Label id="lblStyle" runat="server"></asp:Label>
			</ItemTemplate>
		</asp:TemplateColumn>
	</Columns>
	<PagerStyle Visible="False"></PagerStyle>
</asp:DataGrid>
<asp:label id="SortOrder" runat="server" Visible="False"></asp:label>


    
    </div>
    </form>
</body>
</html>
