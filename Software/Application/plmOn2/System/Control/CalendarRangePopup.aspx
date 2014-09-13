<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CalendarRangePopup.aspx.vb" Inherits="plmOnApp.CalendarRangePopup" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Calendar</title>
	    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	    <LINK href="../CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../CSS/Calendar.css" type="text/css" rel="stylesheet">
</HEAD>
	<body>
			<form runat="server" ID="Form1">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 100px">
					<asp:calendar ID="cal1" runat="server" Height="150px" Width="150px" CssClass="font" 										
	                    BorderColor="White" DayNameFormat="FirstLetter" CellPadding="0" PrevMonthText='<img src="../Icons/arrow_left.gif"  border="0" />'
						NextMonthText='<img src="../Icons/arrow_right.gif"  border="0" />' SelectWeekText=" " BackColor="White">
						<NextPrevStyle Height="25px" CssClass="TableHeaderYellow"></NextPrevStyle>
						<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
						<SelectedDayStyle BackColor="#C00000" BorderColor="Red" BorderStyle="Solid" ForeColor="White"></SelectedDayStyle>
						<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeaderYellow"></TitleStyle>
						<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
						<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
                        <TodayDayStyle BackColor="White" BorderColor="Gold" BorderStyle="Solid" BorderWidth="2px"
                            CssClass="fontHead" ForeColor="Black" />
					</asp:calendar>
                        </td>
                        <td style="width: 100px">
					<asp:calendar ID="cal2" runat="server" Height="150px" Width="150px" CssClass="font" 										
	                    BorderColor="White" DayNameFormat="FirstLetter" CellPadding="0" PrevMonthText='<img src="../Icons/arrow_left.gif"  border="0" />'
						NextMonthText='<img src="../Icons/arrow_right.gif"  border="0" />' SelectWeekText=" " BackColor="White">
						<NextPrevStyle Height="25px" CssClass="TableHeaderYellow"></NextPrevStyle>
						<DayHeaderStyle Font-Bold="True" Height="25px" BorderStyle="None" CssClass="TableHeaderYellow" BackColor="#E0E0E0"></DayHeaderStyle>
						<SelectedDayStyle BackColor="#C00000" BorderColor="Red" BorderStyle="Solid" ForeColor="White"></SelectedDayStyle>
						<TitleStyle Height="25px" BorderWidth="0px" BorderStyle="None" CssClass="TableHeaderYellow"></TitleStyle>
						<WeekendDayStyle BackColor="#FFFFC0"></WeekendDayStyle>
						<OtherMonthDayStyle ForeColor="#E0E0E0"></OtherMonthDayStyle>
                        <TodayDayStyle BackColor="White" BorderColor="Gold" BorderStyle="Solid" BorderWidth="2px"
                            CssClass="fontHead" ForeColor="Black" />
					</asp:calendar>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="150" border=0 cellpadding=0 cellspacing=0>
                            <tr>
                            <td class="fontHead" style="height: 23px" align="right" width="35">
                                <asp:label id="lblFrom" runat="server">From:</asp:label>&nbsp;</td>
                            <td style="height: 23px" width="100"><asp:TextBox ID="txtDateFrom" runat="server" Width="100px" CssClass="fontRed" Font-Bold="True"></asp:TextBox></td>
                            </tr>
                            </table>
                        </td>
                        <td>
                            <table width="150" border=0 cellpadding=0 cellspacing=0>
                            <tr>
                            <td class="fontHead" align="right" width="35">
                                <asp:label id="lblTo" runat="server">To:</asp:label>&nbsp;</td>
                            <td width="100"><asp:TextBox ID="txtDateTo" runat="server" Width="100px" CssClass="fontRed" Font-Bold="True"></asp:TextBox></td>
                            </tr>
                            </table>
                       </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnDateSelect" runat="server" Text="Select Date range" Width="300px" cssclass="fontHead" Height="25px"/></td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
					<input type="hidden" id="control" runat="server" NAME="control"></td>
                        <td style="width: 100px">
					<input type="hidden" id="Hidden1" runat="server" NAME="control"></td>
                    </tr>
                </table>
			</form>
	</body>
</HTML>
