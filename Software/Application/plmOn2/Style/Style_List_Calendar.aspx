<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSCalendar" Assembly="YSCalendar" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_List_Calendar.aspx.vb" Inherits="plmOnApp.Style_List_Calendar" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Calendar</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Calendar.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
        <asp:HiddenField ID="selectedDate" runat="server" />
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="300">
					    <cc1:bwimagebutton id="btnNew" runat="server"  Message="NONE" CausesValidation="False"></cc1:bwimagebutton>
					    <cc1:bwimagebutton id="btnCopy" runat="server"  Message="NONE" CausesValidation="False"></cc1:bwimagebutton>
				    </td>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<tr>
						<td height="50">&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label>
						</td>
					</tr>
				</TBODY>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td class="FontHead">
						<cc1:confirmedimagebutton id="btnCalMonth" runat="server" CausesValidation="False" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCalWeek" runat="server" CausesValidation="False" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCalDay" runat="server" CausesValidation="False" Message="NONE" ></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top">
						<asp:panel id="pnlWeek" runat="server">
							<cc2:ysxdayscalendar id="YSXDaysCalendar1" runat="server" PreviousFormat="MMM dd" NextFormat="MMM dd"
								TableBodyCssClass="CalendarBody" TableHeaderCssClass="CalendarHeader" TableWeekendBodyCssClass="CalendarBodyWeekend"
								TableWeekendHeaderCssClass="CalendarHeaderWeekend" HeaderDateFormat=" ddd, MMM dd" TableTodayBodyCssClass="CalendarBodyToday"
								TableTodayHeaderCssClass="CalendarHeaderToday" Days="7" TableTitleHeaderCssClass="CalendarTitleHeader"
								Width="100%" NextWeek='<img src="../System/Icons/arrow_right.gif"  border="0" />' PreviousWeek='<img src="../System/Icons/arrow_left.gif"  border="0" />'>
								<ItemTemplate>
									<%# GetCalendarLink(Container.DataItem("PKeyId").ToString, Container.DataItem("CalendarLinkId").ToString, Container.DataItem("CalendarLinkSubId").ToString, GetLocalTime(Container.DataItem("CalendarDate")).ToString, Container.DataItem("CalendarType").ToString, Container.DataItem("CalendarStatus").ToString, Container.DataItem("CalendarDescription").ToString, Container.DataItem("SeasonYearID").ToString)%>
								</ItemTemplate>
							</cc2:ysxdayscalendar>
						</asp:panel>
						<asp:panel id="pnlMonth" runat="server">
							<cc2:ysmonthlycalendar id="Calendar1" runat="server" CssClass="font" SelectedDate="2006-01-01" width="100%"
								NextMonthText='<img src="../System/Icons/arrow_right.gif"  border="0" />' PrevMonthText='<img src="../System/Icons/arrow_left.gif"  border="0" />'
								DayField="CalendarDate" VisibleDate="2006-01-01" CellPadding="0" NextPrevFormat="FullMonth" DayNameFormat="Full"
								BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px">
								<SelectedDayStyle ForeColor="Black" BorderColor="#E0E0E0" BackColor="AliceBlue"></SelectedDayStyle>
								<OtherMonthDayStyle ForeColor="White" BorderColor="#E0E0E0" BackColor="White"></OtherMonthDayStyle>
								<TitleStyle Font-Size="Medium" Height="35px" BorderWidth="0px" BorderStyle="None" BorderColor="#FFFFC0"
									CssClass="font" BackColor="#FFFFC0"></TitleStyle>
								<DayStyle Font-Size="Medium" Font-Names="Arial" HorizontalAlign="Left" Height="100px" BorderStyle="Solid"
									CssClass="Font" VerticalAlign="Top" BackColor="White"></DayStyle>
								<WeekendDayStyle BackColor="WhiteSmoke"></WeekendDayStyle>
								<DayHeaderStyle Height="25px" BorderStyle="None" CssClass="TableHeaderYellow"></DayHeaderStyle>
								<ItemTemplate>
									<%# GetCalendarLink(Container.DataItem("PKeyId").ToString, Container.DataItem("CalendarLinkId").ToString, Container.DataItem("CalendarLinkSubId").ToString, GetLocalTime(Container.DataItem("CalendarDate")).ToString, Container.DataItem("CalendarType").ToString, Container.DataItem("CalendarStatus").ToString, Container.DataItem("CalendarDescription").ToString, Container.DataItem("SeasonYearID").ToString)%>
								</ItemTemplate>
							</cc2:ysmonthlycalendar>
						</asp:panel>
					</td>
					<td valign="top" width="5">
						<table style="BORDER-TOP: #ffffc0 1px solid; BORDER-BOTTOM: #dcdcdc 1px solid" cellSpacing="0"
							cellpadding="0" width="100%" border="0">
							<tr height="35">
								<td width="5" bgColor="#ffffc0">&nbsp;</td>
							</tr>
							<tr height="25">
								<td class="TableHeaderYellow" width="5">&nbsp;</td>
							</tr>
						</table>
					</td>
					<td valign="top" width="180">
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td style="BORDER-TOP: #ffffc0 1px solid; HEIGHT: 36px; BACKGROUND-COLOR: #ffffc0">&nbsp;</td>
							</tr>
							<tr>
								<td>
									<asp:calendar id="CalendarRight01" runat="server" Width="180px" CssClass="font" NextMonthText='<img src="../System/Icons/arrow_right.gif"  border="0" />'
										PrevMonthText='<img src="../System/Icons/arrow_left.gif"  border="0" />' CellPadding="0" DayNameFormat="FirstLetter"
										BorderColor="White" BorderWidth="0px" SelectWeekText=" ">
										<NextPrevStyle Height="25px" CssClass="TableHeaderYellow"></NextPrevStyle>
										<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
										<SelectedDayStyle BackColor="Silver"></SelectedDayStyle>
										<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeaderYellow"></TitleStyle>
										<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
										<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
									</asp:calendar></td>
							</tr>
							<tr>
								<td height="5"></td>
							</tr>
							<tr>
								<td>
									<asp:calendar id="CalendarRight02" runat="server" Width="180px" CssClass="font" NextMonthText=" "
										PrevMonthText=" " DayNameFormat="FirstLetter" BorderColor="White" SelectWeekText=" ">
										<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
										<SelectedDayStyle BackColor="Silver"></SelectedDayStyle>
										<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
										<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
										<NextPrevStyle Height="25px" CssClass="TableHeader"></NextPrevStyle>
										<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeader"></TitleStyle>
									</asp:calendar></td>
							</tr>
							<tr>
								<td height="5"></td>
							</tr>
							<tr>
								<td>
									<asp:calendar id="CalendarRight03" runat="server" Width="180px" CssClass="font" NextMonthText=" "
										PrevMonthText=" " DayNameFormat="FirstLetter" BorderColor="White" SelectWeekText=" ">
										<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
										<SelectedDayStyle BackColor="Silver"></SelectedDayStyle>
										<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
										<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
										<NextPrevStyle Height="25px" CssClass="TableHeader"></NextPrevStyle>
										<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeader"></TitleStyle>
									</asp:calendar></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
