<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calendar_Page_List_Copy.aspx.vb" Inherits="plmOnApp.Calendar_Page_List_Copy" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Calendar Search</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        .search-cell td
        {
            vertical-align:top;
        }
    </style>
</head>
<body>
    <form id="form1" method="post" runat="server" defaultbutton="imgBtnSearch">

    <asp:Panel runat="server" ID="pnlMain">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <cc1:bwimagebutton id="btnNew" runat="server" message="NONE"></cc1:bwimagebutton>
                </td>
            </tr>
        </table>
        <table width="100%" style="border-bottom: orange thin solid;" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" height="45">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>        
        <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
            <tr colspan="2"><td>&nbsp;</td></tr>
            <tr>
                <td class="search-cell"><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
                <td vAlign="top" width="100%">
                    <table height="45">
                        <tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
                    </table>
                </td>
            </tr>
        </table>        
        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
                </td>
                <td nowrap align="center" width="125">
                    <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgNext" runat="server"></asp:ImageButton>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgLast" runat="server" ToolTip="Last"></asp:ImageButton>
                </td>
                <td width="10">
                    &nbsp;
                </td>
                <td nowrap>
                    <asp:Label ID="RecordCount" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td class="fontHead" align="right" width="110">
                    <asp:Label ID="lblRecordsPerPage" runat="server"></asp:Label>
                </td>
                <td width="25">
                    <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                        <asp:ListItem Value="5">5</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="25">25</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="40">40</asp:ListItem>
                        <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td width="10">
                    <asp:button id="btnGo" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button>
                </td>
            </tr>
        </table>
        <asp:DataGrid ID="dgCalendar" runat="server" EnableViewState="true" AutoGenerateColumns="False" BorderColor="#E0E0E0"
            BorderStyle="Solid" BorderWidth="1px" DataKeyField="CalendarHeaderID" AllowSorting="true">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="False"></PagerStyle>            
			<Columns>
				<asp:TemplateColumn>
					<HeaderStyle Width="50px"></HeaderStyle>
					<ItemStyle Width="50px"></ItemStyle>
					<HeaderTemplate>
						<asp:label id="lblCopy" runat="server" CssClass="fontHead"><%#GetSystemText("Copy")%></asp:label>
					</HeaderTemplate>
					<ItemTemplate>
						<cc1:confirmedimagebutton id="imgBtnCopy" runat="server"  Message='<%#GetSystemText("Are you sure you want to copy this calendar?")%>'
								CommandName="Copy"></cc1:confirmedimagebutton>
						<asp:TextBox id="txtCalendarName" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container.DataItem, "CalendarName")%>'>
						</asp:TextBox>
					</ItemTemplate>
				</asp:TemplateColumn>
			</Columns>
        </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
    </asp:Panel>

            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
                </Scripts>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadScriptManager>
            <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
                <StyleSheets>
                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                </StyleSheets>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadStyleSheetManager>
            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

    </form>
</body>
</html>
