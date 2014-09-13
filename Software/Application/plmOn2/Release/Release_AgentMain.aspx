<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Release_AgentMain.aspx.vb" Inherits="plmOnApp.Release_AgentMain" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSCalendar" Assembly="YSCalendar" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Profile</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Calendar.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClose" runat="server" CausesValidation="False" Message="NONE"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top" noWrap width="200">
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr vAlign="middle">
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="FontHead"><%#GetSystemText("Profile")%></td>								
							</tr>
						</table>
						<DIV style="BORDER-TOP-WIDTH: thin; BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: gainsboro; BORDER-BOTTOM-WIDTH: thin; BORDER-BOTTOM-COLOR: gainsboro; PADDING-BOTTOM: 1px; OVERFLOW: scroll; WIDTH: 200px; BORDER-TOP-COLOR: gainsboro; HEIGHT: 175px; BACKGROUND-COLOR: white; TEXT-ALIGN: left; BORDER-RIGHT-WIDTH: thin; BORDER-RIGHT-COLOR: gainsboro">
							<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
						</DIV>
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr vAlign="middle">
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="FontHead"><%#GetSystemText("Vendor")%></td>
							</tr>
						</table>
						<DIV style="BORDER-TOP-WIDTH: thin; BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: gainsboro; BORDER-BOTTOM-WIDTH: thin; BORDER-BOTTOM-COLOR: gainsboro; PADDING-BOTTOM: 1px; OVERFLOW: scroll; WIDTH: 200px; BORDER-TOP-COLOR: gainsboro; HEIGHT: 200px; BACKGROUND-COLOR: white; TEXT-ALIGN: left; BORDER-RIGHT-WIDTH: thin; BORDER-RIGHT-COLOR: gainsboro">
							<asp:datagrid id="dgVendor" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
								OnItemDataBound="dgVendor_ItemDataBound" Width="180px" AutoGenerateColumns="False" ShowHeader="False">
								<AlternatingItemStyle Height="20px"></AlternatingItemStyle>
								<ItemStyle Height="20px"></ItemStyle>
								<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<ItemTemplate>
											<asp:Label id="lblVendorName" runat="server" CssClass="font" />
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<ItemTemplate>
											<asp:Label id="lblVendorCountry" runat="server" CssClass="font" />
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></DIV>
					</TD>
					<TD vAlign="top">
						<table class="TableHeaderYellow" height="25" cellSpacing="0" cellPadding="0" width="100%"
							border="0">
							<tr vAlign="middle">
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="FontHead"><%#GetSystemText("This Week")%></td>
							</tr>
						</table>
						<DIV style="BORDER-TOP-WIDTH: thin; BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: gainsboro; BORDER-BOTTOM-WIDTH: thin; BORDER-BOTTOM-COLOR: gainsboro; PADDING-BOTTOM: 1px; OVERFLOW: scroll; WIDTH: 100%; BORDER-TOP-COLOR: gainsboro; HEIGHT: 400px; TEXT-ALIGN: left; BORDER-RIGHT-WIDTH: thin; BORDER-RIGHT-COLOR: gainsboro"><SPAN class="font"><cc2:ysxdayscalendar id="YSXDaysCalendar1" runat="server" TableBodyCssClass="CalendarBody" TableHeaderCssClass="CalendarHeader"
									TableWeekendBodyCssClass="CalendarBodyWeekend" TableWeekendHeaderCssClass="CalendarHeaderWeekend" HeaderDateFormat=" ddd, MMM dd" TableTodayBodyCssClass="CalendarBodyToday" TableTodayHeaderCssClass="CalendarHeaderToday" Days="7">
									<ItemTemplate>
										<table cellSpacing="1" cellPadding="0" width="100%" bgColor="#e4e4e4" border="0">
											<tr bgColor="#ffffff">
												<td><a href="#" onClick='onEvent("<%# Container.DataItem("SampleRequestWorkflowID")%>" ) ;'  ><img src='../System/Icons/icon_shortcut.gif ' border='0' /></a></td>
												<td class="font"><%# Container.DataItem("WeekItem")%></td>
											</tr>
										</table>
									</ItemTemplate>
								</cc2:ysxdayscalendar></SPAN></DIV>
					</TD>
					<TD vAlign="top" width="200">
						<table class="TableHeaderRed" height="25" cellSpacing="0" cellPadding="0" width="100%"
							border="0">
							<tr vAlign="middle">
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="FontHead"><%#GetSystemText("Critical")%></td>
							</tr>
						</table>
						<DIV style="BORDER-TOP-WIDTH: thin; BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: gainsboro; BORDER-BOTTOM-WIDTH: thin; BORDER-BOTTOM-COLOR: gainsboro; PADDING-BOTTOM: 1px; OVERFLOW: scroll; WIDTH: 200px; BORDER-TOP-COLOR: gainsboro; HEIGHT: 400px; BACKGROUND-COLOR: white; TEXT-ALIGN: left; BORDER-RIGHT-WIDTH: thin; BORDER-RIGHT-COLOR: gainsboro"><asp:datagrid id="dgCritical" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
								OnItemDataBound="dgCritical_ItemDataBound" Width="180px" AutoGenerateColumns="False" ShowHeader="False">
								<AlternatingItemStyle Height="20px"></AlternatingItemStyle>
								<ItemStyle Height="20px"></ItemStyle>
								<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn ItemStyle-Width="25">
										<ItemTemplate>
											<div align="center">
												<asp:Image id="imgCritical" runat="server" ImageUrl="../System/Icons/icon_alarm.gif"></asp:Image>
											</div>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<ItemTemplate>
											<asp:Label id="lblCriticalItem" runat="server" CssClass="font" />
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></DIV>
					</TD>
				</TR>
			</TABLE>
			<br>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="#ffffff" height="100%">
				<tr>
					<td valign="top">
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
