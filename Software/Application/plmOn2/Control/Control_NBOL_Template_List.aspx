<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_NBOL_Template_List.aspx.vb" Inherits="plmOnApp.Control_NBOL_Template_List" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Template Types</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/jquery.tablescroll.css" type="text/css" rel="stylesheet">

	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
		
		<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>
					<asp:imagebutton id="Imagebutton1" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
						Height="0px" />
					<cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>    
		
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
			</tr>
		</table>

        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr vAlign="top">
				<td>
					<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<tr vAlign="middle">
							<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
							<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
							<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
							<td width="10">&nbsp;</td>
							<td noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
							<td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
							<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
									<asp:ListItem Value="5">5</asp:ListItem>
									<asp:ListItem Value="10">10</asp:ListItem>
									<asp:ListItem Value="15">15</asp:ListItem>
									<asp:ListItem Value="20">20</asp:ListItem>
									<asp:ListItem Value="25">25</asp:ListItem>
									<asp:ListItem Value="30">30</asp:ListItem>
									<asp:ListItem Value="40">40</asp:ListItem>
									<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
								</asp:dropdownlist></td>
							<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
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
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="true" >
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

        <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
        <script type="text/javascript">

            $.fn.tableScroll.defaults =
            {
                flush: false, // makes the last thead and tbody column flush with the scrollbar
                width: null, // width of the table (head, body and foot), null defaults to the tables natural width
                height: 100, // height of the scrollable area
                containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
            };

            jQuery(document).ready(function ($) {

                var table = $('#DataGrid1');
                // Creating <thead> element for the first row
                var head = document.createElement("thead");
                var body = table.find("tbody");
                head.appendChild(table[0].rows[0]);
                body.before(head);
                // Adding the scrollbar
                var tableWidth = table.width();
                var tableHeight = $(window).height() - $("#form1").height() + table.height() - $(head).height() - 15;
                table.tableScroll({ height: tableHeight});

            });
        </script>
</html>