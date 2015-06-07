<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sample_LateCalendar.aspx.vb" Inherits="srmOnApp.Sample_LateCalendar1" %>

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

		<TABLE class="TableHeaderRed" cellSpacing="1" cellPadding="1" width="100%" border="0">
			<TR>
				<TD width="20" height="20"><IMG src="../System/Icons/icon_alarm.gif"></TD>
				<TD><asp:label id="lblLate" runat="server">Late</asp:label></TD>
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
	    <TD noWrap align="center" width="90">
            <asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
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

<asp:datagrid id="dlLate" runat="server" AllowSorting="False" Width="100%">
    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <Columns>
        <asp:TemplateColumn >
            <ItemTemplate>
                <%# GetCalendarLateLink(Container.DataItem("PKeyId").ToString, Container.DataItem("CalendarLinkId").ToString, Container.DataItem("CalendarLinkSubId").ToString, Container.DataItem("CalendarDate").ToString, Container.DataItem("CalendarType").ToString, Container.DataItem("CalendarStatus").ToString, Container.DataItem("CalendarDescription").ToString, Container.DataItem("CalendarSN").ToString) %>
            </ItemTemplate>
        </asp:TemplateColumn>
    </Columns>
</asp:datagrid> 
	
					    
</div>
</form>
</body>
</html>
