<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_SampleRequest_Grid.aspx.vb" Inherits="plmOnApp.Style_SampleRequest_Grid" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Sample Request</title>
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0"></td>
					<td><cc1:confirmedimagebutton id="btnNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="Are you sure you want to do close this form?"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40">&nbsp;</td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Program Timeline</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellpadding="0" width="100%" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top"></td>
				</tr>
			</table>
			<asp:datagrid id="dgSampleWorkflow" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="false" Width="100%">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px"></HeaderStyle>
				<Columns></Columns>
			</asp:datagrid><cc3:datacalendar id="DataCalendar1" runat="server" BorderColor="Silver" DayField="Duedate" width="100%"
				Font-Name="Tahoma" DayNameFormat="Full" NextPrevFormat="FullMonth" OnVisibleMonthChanged="MonthChange" Height="100%"
				BackColor="White">
				<TodayDayStyle ForeColor="#C00000" BackColor="#FFFF80"></TodayDayStyle>
				<OtherMonthDayStyle ForeColor="Black" BackColor="Gainsboro"></OtherMonthDayStyle>
				<TitleStyle Font-Bold="True" Height="20px" BorderWidth="0px" ForeColor="White" CssClass="FontHead"></TitleStyle>
				<SelectorStyle BackColor="Red"></SelectorStyle>
				<NextPrevStyle ForeColor="White" CssClass="FontHead"></NextPrevStyle>
				<DayStyle Font-Size="X-Small" HorizontalAlign="Left" Height="100px" CssClass="fontHead" VerticalAlign="Top"></DayStyle>
				<WeekendDayStyle BackColor="WhiteSmoke"></WeekendDayStyle>
				<DayHeaderStyle Height="20px" CssClass="TableHeaderOver"></DayHeaderStyle>
				<ItemTemplate>
					<table>
						<tr>
							<td><%#GetStatusIcon(Container.DataItem("Status"), _
							Container.DataItem("Submit"),Container.DataItem("StyleNo") & "-" & Container.DataItem("MainColor") & " " & Container.DataItem("SetName"), _
							Container.DataItem("SampleWorkflow").ToString, _
							Container.DataItem("StyleColorID").ToString, _
							Container.DataItem("StyleID").ToString, _
							Container.DataItem("StyleSet").ToString, _
							Container.DataItem("SampleRequestTradeID").ToString, _
							Container.DataItem("SampleWorkflowID").ToString)%></td>
						</tr>
					</table>
				</ItemTemplate>
			</cc3:datacalendar><br>
			<table id="TB_Alert" cellSpacing="1" cellpadding="1" border="0" runat="server">
				<tr class="TableHeaderRed">
					<td class="TableHeaderGreen" height="25"><asp:label id="lblTodaysSubmits" Runat="server" CssClass="fontHead">Today's&nbsp;Submits</asp:label></td>
					<td class="TableHeaderRed" height="25"><asp:label id="lblLateSubmits" Runat="server" CssClass="fontHead">Late Submits</asp:label></td>
					<td class="TableHeaderYellow" height="25"><asp:label id="lblTechPackUpdates" Runat="server" CssClass="fontHead">Tech Pack Updates</asp:label></td>
				</tr>
				<tr>
					<td valign="top"><asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False" Width="400px">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Style No")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleNo" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Process")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Submit")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblSubmit" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Assigned To")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblAssignedTo" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Due Date")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblDueDate" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td><asp:datagrid id="Datagrid2" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False" Width="400px">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Style No")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleNoL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Process")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflowL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Submit")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblSubmitL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Assigned To")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblAssignedToL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<%#GetSystemText("Due Date")%>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblDuedateL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td width="300"></td>
				</tr>
			</table>
		</form>
	</body>
</html>
