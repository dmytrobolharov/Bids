<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSCalendar" Assembly="YSCalendar" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Quote_Calendar.aspx.vb" Inherits="plmOnApp.Quote_Calendar" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Calendar</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Calendar.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Quote Folder...</asp:Label></td>
				</tr>
			</table>
			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD class="FontHead">
						<cc1:confirmedimagebutton id="btnCalMonth" runat="server" CausesValidation="False" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCalWeek" runat="server" CausesValidation="False" Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnCalDay" runat="server" CausesValidation="False" Message="NONE"></cc1:confirmedimagebutton>
					</TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top">
						<asp:panel id="pnlWeek" runat="server">
							<cc2:ysxdayscalendar id="YSXDaysCalendar1" runat="server" PreviousWeek='<img src="../System/Icons/arrow_left.gif"  border="0" />'
								NextWeek='<img src="../System/Icons/arrow_right.gif"  border="0" />' Width="100%" TableTitleHeaderCssClass="CalendarTitleHeader"
								Days="7" TableTodayHeaderCssClass="CalendarHeaderToday" TableTodayBodyCssClass="CalendarBodyToday"
								HeaderDateFormat=" ddd, MMM dd" TableWeekendHeaderCssClass="CalendarHeaderWeekend" TableWeekendBodyCssClass="CalendarBodyWeekend"
								TableHeaderCssClass="CalendarHeader" TableBodyCssClass="CalendarBody"
								NextFormat="MMM dd" PreviousFormat="MMM dd" >
								<ItemTemplate>
									<%# GetCalendarLink(Container.DataItem("PKeyId").ToString, Container.DataItem("CalendarLinkId").ToString, Container.DataItem("CalendarLinkSubId").ToString, Container.DataItem("CalendarDate").ToString, Container.DataItem("CalendarType").ToString, Container.DataItem("CalendarStatus").ToString, Container.DataItem("CalendarDescription").ToString, Container.DataItem("CalendarView").ToString) %>
								</ItemTemplate>
							</cc2:ysxdayscalendar>
						</asp:panel>
						<asp:panel id="pnlMonth" runat="server">
							<cc2:ysmonthlycalendar id="Calendar1" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
								DayNameFormat="Full" NextPrevFormat="FullMonth" CellPadding="0" VisibleDate="2006-01-01" DayField="CalendarDate"
								PrevMonthText='<img src="../System/Icons/arrow_left.gif"  border="0" />' NextMonthText='<img src="../System/Icons/arrow_right.gif"  border="0" />'
								width="100%" SelectedDate="2006-01-01" CssClass="font">
								<SelectedDayStyle ForeColor="Black" BorderColor="#E0E0E0" BackColor="AliceBlue"></SelectedDayStyle>
								<OtherMonthDayStyle ForeColor="White" BorderColor="#E0E0E0" BackColor="White"></OtherMonthDayStyle>
								<TitleStyle Height="35px" BorderWidth="0px" BorderStyle="None" BorderColor="#FFFFC0" CssClass="CalendarTitleHeader"
									BackColor="#FFFFC0"></TitleStyle>
								<DayStyle Font-Size="Medium" Font-Names="Arial" HorizontalAlign="Left" Height="100px" BorderStyle="Solid"
									CssClass="Font" VerticalAlign="Top" BackColor="White"></DayStyle>
								<WeekendDayStyle BackColor="WhiteSmoke"></WeekendDayStyle>
								<DayHeaderStyle Height="25px" BorderStyle="None" CssClass="CalendarHeader"></DayHeaderStyle>
								<ItemTemplate>
									<%# GetCalendarLink(Container.DataItem("PKeyId").ToString, Container.DataItem("CalendarLinkId").ToString, Container.DataItem("CalendarLinkSubId").ToString, Container.DataItem("CalendarDate").ToString, Container.DataItem("CalendarType").ToString, Container.DataItem("CalendarStatus").ToString, Container.DataItem("CalendarDescription").ToString, Container.DataItem("CalendarView").ToString) %>
								</ItemTemplate>
							</cc2:ysmonthlycalendar>
						</asp:panel>
					</TD>
					<TD vAlign="top" width="5">
						<TABLE style="BORDER-TOP: #ffffc0 1px solid; BORDER-BOTTOM: #dcdcdc 1px solid" cellSpacing="0"
							cellPadding="0" width="100%" border="0">
							<TR height="35">
								<TD width="5" bgColor="#ffffc0">&nbsp;</TD>
							</TR>
							<TR height="25">
								<TD class="TableHeaderYellow" width="5">&nbsp;</TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top" width="180">
						<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD style="BORDER-TOP: #ffffc0 1px solid; HEIGHT: 36px; BACKGROUND-COLOR: #ffffc0">&nbsp;</TD>
							</TR>
							<TR>
								<TD>
									<asp:calendar id="CalendarRight01" runat="server" Width="180px" CssClass="font" NextMonthText='<img src="../System/Icons/arrow_right.gif"  border="0" />'
										PrevMonthText='<img src="../System/Icons/arrow_left.gif"  border="0" />' CellPadding="0" DayNameFormat="FirstLetter"
										BorderColor="White" BorderWidth="0px" SelectWeekText=" ">
										<NextPrevStyle Height="25px" CssClass="TableHeaderYellow"></NextPrevStyle>
										<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
										<SelectedDayStyle BackColor="Silver"></SelectedDayStyle>
										<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeaderYellow"></TitleStyle>
										<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
										<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
									</asp:calendar></TD>
							</TR>
							<TR>
								<TD height="5"></TD>
							</TR>
							<TR>
								<TD>
									<asp:calendar id="CalendarRight02" runat="server" Width="180px" CssClass="font" NextMonthText=" "
										PrevMonthText=" " DayNameFormat="FirstLetter" BorderColor="White" SelectWeekText=" ">
										<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
										<SelectedDayStyle BackColor="Silver"></SelectedDayStyle>
										<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
										<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
										<NextPrevStyle Height="25px" CssClass="TableHeader"></NextPrevStyle>
										<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeader"></TitleStyle>
									</asp:calendar></TD>
							</TR>
							<TR>
								<TD height="5"></TD>
							</TR>
							<TR>
								<TD>
									<asp:calendar id="CalendarRight03" runat="server" Width="180px" CssClass="font" NextMonthText=" "
										PrevMonthText=" " DayNameFormat="FirstLetter" BorderColor="White" SelectWeekText=" ">
										<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
										<SelectedDayStyle BackColor="Silver"></SelectedDayStyle>
										<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
										<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
										<NextPrevStyle Height="25px" CssClass="TableHeader"></NextPrevStyle>
										<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeader"></TitleStyle>
									</asp:calendar></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
