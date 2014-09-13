<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CalendarEventPopup.aspx.vb" Inherits="srmOnApp.CalendarEventPopup" %>

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
                <table border="0" cellpadding="0" cellspacing="0" width=200>
                    <tr>
                        <td style="width: 100px" align=left valign=top >
					<asp:calendar ID="calEvent" runat="server" Height="150px" Width="150px" CssClass="font" 										
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
                        </td>
                        <td style="width: 150px" align=left valign=top >

                            <asp:GridView ID="calGridView" runat="server" AutoGenerateColumns="false" BackColor="White" PageSize="100" Width="150px" >
                                <HeaderStyle Height="26px" CssClass="TableHeaderYellow" ForeColor="Black" />
                                <RowStyle  CssClass="font" />
                                
                                    <Columns>
                                            <asp:TemplateField>
						                        <HeaderTemplate>
							                        <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Day")%></asp:Label>
						                        </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table bgcolor="firebrick" border="2" bordercolor="red" cellpadding="0" cellspacing="0"
                                                        style="width: 25px; height: 25px">
                                                        <tr>
                                                            <td style="width: 100px" align=center valign=middle >
                                                    <asp:Label ID="lblCalendarEventDate" runat="server" ForeColor="White"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
						                        <HeaderTemplate>
							                        <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Event")%></asp:Label>
						                        </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCalendarEventName" runat="server" Text=""></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField> 
                                    </Columns>

                            </asp:GridView>
                       
                           
                        </td>
                    </tr>
                </table>
					<input type="hidden" id="control" runat="server" NAME="control">
			</form>
	</body>
</HTML>
