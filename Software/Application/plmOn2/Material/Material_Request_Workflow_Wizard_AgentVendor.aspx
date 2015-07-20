<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Request_Workflow_Wizard_AgentVendor.aspx.vb" Inherits="plmOnApp.Material_Request_Workflow_Wizard_AgentVendor" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title></title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />    
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <link href="../System/CSS/jquery.tablescroll.css" type="text/css" rel="stylesheet">
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" ></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" Visible="false"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server"></asp:label></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%" Visible="false">
				<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc2:Material_Header id="Material_Header1" runat="server"></uc2:Material_Header></td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                            Font-Size="X-Large" ForeColor="Gray">Material Request</asp:label></td>
				</tr>
			</table>
			
		    <table  style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	            height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	            <TR>
		            <TD align="center" width="50">&nbsp;</TD>
		            <TD align="center" width="500">
			            <asp:imagebutton id="btnBack" runat="server" 
                             Visible="False"  ></asp:imagebutton>
			            <asp:imagebutton id="btnNext" runat="server"></asp:imagebutton>
		            </TD>
		            <TD align="center">&nbsp;</TD>
	            </TR>
            </table>

            <TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
	            <tr>
		            <TD>
			            <TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
				            <TR vAlign="top">
					            <TD>
						            <TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
							            bgColor="#ffffff" border="0">
							            <TR vAlign="middle">
								            <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								            <TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								            <TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								            <TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								            <TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								            <TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
								            <TD width="10">&nbsp;</TD>
								            <TD noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></TD>
								            <TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></TD>
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
								            <TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" Text="GO"></asp:button></TD>
							            </TR>
						            </TABLE>
						            <TABLE id="Table5" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white"
							            border="0">
							            <TR>
								            <td>
									            <table id="Table7" cellSpacing="1" cellPadding="1" width="100%" border="0">
										            <tr><td><asp:placeholder id="plhSearchControl" 
										                runat="server" EnableViewState="False"></asp:placeholder></td>
										            </tr>
									            </table>
								            </td>
								            <TD vAlign="top" width="100%">
									            <TABLE id="Table6" height="45">
										            <TR>
											            <TD><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
										            </TR>
									            </TABLE>
								            </TD>
							            </TR>
						            </TABLE>
						                <asp:datagrid id="DataGrid1" runat="server" PageSize="50" AllowSorting="True" DataKeyField="TradePartnerVendorId">
							                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							                <PagerStyle Visible="False"></PagerStyle>
                                            <Columns > 
                                                <asp:TemplateColumn>
                                                    <ItemTemplate>
                                                        <asp:CheckBox runat="server" ID="chkSelect" />
                                                        <asp:HiddenField runat="server" ID="hdnTradePartnerRelationshipLevelID" />
                                                        <asp:HiddenField runat="server" ID="hdnTradePartnerIDChain" />
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
						                </asp:datagrid>
						            <asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				            </TR>
			            </TABLE>
		            </TD>
	            </tr>
            </TABLE>

    </form>

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
                var tableHeight = $(window).height() - $("#form1").height() + table.height() - $(head).height() - 35;
                table.tableScroll({ height: tableHeight });

            });
        </script>
</body>
</html>
