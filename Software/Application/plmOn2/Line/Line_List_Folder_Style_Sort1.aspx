<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_Style_Sort1.aspx.vb" Inherits="plmOnApp.Line_List_Folder_Style_Sort1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Image Sort</title>
		
		
		
		
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	    <style type="text/css">
            .style1
            {
                width: 75px;
            }
        </style>
	</HEAD>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></TD>
						<TD vAlign="middle" align="left" width="400">
						<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Image Catalog Sort</asp:label></td>
				</tr>
			</table>
			<table border="0">
				<tr>
					<td width="100">&nbsp;</td>
					<td>
<!---------------------->					
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
    <tr vAlign="middle">
    <td ><span class="fontHead" ><asp:Label ID="lblSortBy" runat="server" 
            Text="Sort by"></asp:Label>:
&nbsp;</span><asp:DropDownList runat="server" ID="ddlSortBy" CssClass="font" ></asp:DropDownList><cc1:confirmedimagebutton id="btnSort" 
    runat="server"  Message="NONE"></cc1:confirmedimagebutton><br></td>
    </tr>
	<TR vAlign="top">
		<TD>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="16"><asp:checkbox id="cbThumbnail" AutoPostBack="True" runat="server"></asp:checkbox></TD>
					<TD class="fontHead" width="100"><asp:Label ID="lblQryThumbnail" runat="server" 
                            Text="Thumbnail?"></asp:Label>
                    </TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></TD>
					<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></TD>
					<TD width="10">&nbsp;</TD>
					<TD noWrap class="style1"><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
					<TD class="fontHead" align="right" width="110">
                        <asp:Label ID="lblRecordsPerPage" runat="server" Text="Records per Page"></asp:Label>:
                        </TD>
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
					<TD width="10"><asp:button id="Button1"  runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
				</TR>
			</TABLE>

			<asp:datagrid id="DataGrid1" runat="server" DataKeyField="ImageCatalogItemID" AllowSorting="True" AutoGenerateColumns="False" Width="100%"> 
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
				<Columns >
				    <asp:TemplateColumn >
				        <HeaderTemplate><asp:Label ID="lblImageHdr" runat="server"><%# GetUserText("Image")%></asp:Label></HeaderTemplate>
				        <ItemStyle Width="50px" />
				        <ItemTemplate><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></ItemTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn >
				        <HeaderTemplate><asp:Label ID="lblImageSortHdr" runat="server"><%#GetUserText("Sort")%></asp:Label></HeaderTemplate>
				        <ItemStyle Width="20px" />
				        <ItemTemplate>
				            <asp:TextBox  runat="server" ID="txtSort" Width="60px"></asp:TextBox>
				        </ItemTemplate>
				    </asp:TemplateColumn>
				    
				</Columns>
				
			</asp:datagrid>
			<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
	</TR>
</TABLE>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" />						
<!---------------------->						
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
