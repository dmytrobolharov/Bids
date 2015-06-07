<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Grid_Calendar.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Grid_Calendar" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		
        <title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0"></td>
					<td><cc1:confirmedimagebutton id="btnNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40">&nbsp;</td>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
				</tr>
			</table>
			<cc3:datacalendar id="DataCalendar1" runat="server" BorderColor="Silver" DayField="Duedate" width="100%"
				Font-Name="Tahoma" DayNameFormat="Full" NextPrevFormat="FullMonth" OnVisibleMonthChanged="MonthChange"
				Height="100%" BackColor="White">
				<TodayDayStyle ForeColor="#C00000" BackColor="#FFFF80"></TodayDayStyle>
				<OtherMonthDayStyle ForeColor="Black" BackColor="Gainsboro"></OtherMonthDayStyle>
				<TitleStyle Font-Bold="True" Height="20px" BorderWidth="0px" ForeColor="White" CssClass="FontHead"></TitleStyle>
				<SelectorStyle BackColor="Red"></SelectorStyle>
				<NextPrevStyle ForeColor="White" CssClass="FontHead"></NextPrevStyle>
				<DayStyle Font-Size="X-Small" HorizontalAlign="Left" Height="100px" CssClass="fontHead" VerticalAlign="Top"></DayStyle>
				<WeekendDayStyle BackColor="WhiteSmoke"></WeekendDayStyle>
				<DayHeaderStyle Height="20px" CssClass="TableHeaderOver"></DayHeaderStyle>
			</cc3:datacalendar><BR>
		</form>
	</body>
</HTML>
