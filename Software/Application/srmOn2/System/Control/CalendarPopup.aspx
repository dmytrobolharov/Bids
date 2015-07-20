<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CalendarPopup.aspx.vb" Inherits="srmOnApp.CalendarPopup" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Calendar</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	    <LINK href="../CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../CSS/Calendar.css" type="text/css" rel="stylesheet">
</HEAD>
	<body>
			<form runat="server" ID="Form1">
			<div align="center" >
					<asp:calendar ID="thedate" runat="server" Height="150px" Width="150px" CssClass="font" 										
	                    BorderColor="White" DayNameFormat="FirstLetter" CellPadding="0" PrevMonthText='<img src="../Icons/arrow_left.gif"  border="0" />'
						NextMonthText='<img src="../Icons/arrow_right.gif"  border="0" />' SelectWeekText=" " BackColor="White">
						<NextPrevStyle Height="25px" CssClass="TableHeaderYellow"></NextPrevStyle>
						<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
						<SelectedDayStyle BackColor="Black"></SelectedDayStyle>
						<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeaderYellow"></TitleStyle>
						<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
						<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
                        <TodayDayStyle BackColor="White" BorderColor="Gold" BorderStyle="Solid" BorderWidth="2px"
                            CssClass="fontHead" ForeColor="Black" />
					</asp:calendar>
			</div>  		
					<input type="hidden" id="control" runat="server" NAME="control">
			</form>
	</body>
</HTML>
