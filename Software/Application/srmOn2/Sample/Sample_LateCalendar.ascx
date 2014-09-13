<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Sample_LateCalendar.ascx.vb" Inherits="srmOnApp.Sample_LateCalendar" %>
<TABLE class="tableHeaderred" cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD width="50%" height="20" align="left"><IMG src="../System/Icons/icon_alarm.gif">&nbsp;&nbsp;<asp:label id="lblLate" runat="server">Late</asp:label></TD>
        <td width="50%"  align="right" ><asp:label ID="lblViewAll" runat="server" CssClass="fontHead">View all (0)</asp:label></td>
	</TR>
</TABLE>
<asp:datalist id="dlLate" runat="server" Width="100%">
	<ItemTemplate>
		<%# GetCalendarLateLink(Container.DataItem("PKeyId").ToString, Container.DataItem("CalendarLinkId").ToString, Container.DataItem("CalendarLinkSubId").ToString, Container.DataItem("CalendarDate").ToString, Container.DataItem("CalendarType").ToString, Container.DataItem("CalendarStatus").ToString, Container.DataItem("CalendarDescription").ToString, Container.DataItem("CalendarSN").ToString) %>
	</ItemTemplate>
</asp:datalist>

