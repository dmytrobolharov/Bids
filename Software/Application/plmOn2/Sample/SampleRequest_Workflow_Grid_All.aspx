<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Grid_All.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Grid_All" %>
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
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0"></td>
					<td><cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  ></cc1:confirmedimagebutton></td>
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
			<table id="tbSearch" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0"
				runat="server">
				<TR>
					<TD width="10">&nbsp;</TD>
					<TD><asp:label id="lblMyList" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD><asp:label id="lblStyleNo" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD><asp:label id="lblDescription" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD>
						<asp:Label id="lblSeason" runat="server" CssClass="fontHead"></asp:Label></TD>
					<TD>
						<asp:Label id="lblYear" runat="server" CssClass="fontHead"></asp:Label></TD>
					<TD><asp:label id="lblAgent" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD><asp:label id="lblVendor" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD></TD>
					<TD>&nbsp;</TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<tr>
					<td width="10" height="25"></td>
					<TD vAlign="middle" align="center" width="53" height="25"><asp:checkbox id="cbMyList" runat="server"></asp:checkbox></TD>
					<td width="104" height="25"><asp:textbox id="txtStyleNo" runat="server" CssClass="font" Width="100px"></asp:textbox></td>
					<TD width="127" height="25"><asp:textbox id="txtStyleDescription" runat="server" CssClass="font"></asp:textbox></TD>
					<TD width="75" height="25">
						<asp:DropDownList id="ddlSeason" runat="server" Width="70px"></asp:DropDownList></TD>
					<TD width="75" height="25">
						<asp:DropDownList id="ddlYear" runat="server" Width="70px"></asp:DropDownList></TD>
					<TD width="155" height="25"><asp:dropdownlist id="ddlAgent" runat="server" Width="150px" AutoPostBack="True"></asp:dropdownlist></TD>
					<TD width="125" height="25"><asp:dropdownlist id="ddlVendor" runat="server" Width="150px"></asp:dropdownlist></TD>
					<TD height="25"><asp:button id="btnSearch" runat="server" CssClass="fontHead" ></asp:button></TD>
					<td height="25"></td>
					<TD height="25"></TD>
					<TD height="25"></TD>
				</tr>
			</table>
			<asp:datagrid id="dgSampleWorkflow" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="false">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="20px"></HeaderStyle>
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
							<TD><%#GetStatusIcon(Container.DataItem("Status"), _
							Container.DataItem("Submit"),Container.DataItem("StyleNo") & "-" & Container.DataItem("MainColor") & " " & Container.DataItem("SetName"), _
							Container.DataItem("SampleWorkflow").ToString, _
							Container.DataItem("StyleColorID").ToString, _
							Container.DataItem("StyleID").ToString, _
							Container.DataItem("StyleSet").ToString, _
							Container.DataItem("SampleRequestTradeID").ToString, _
							Container.DataItem("SampleWorkflowID").ToString)%></TD>
						</tr>
					</table>
				</ItemTemplate>
			</cc3:datacalendar><BR>
			<TABLE id="TB_Alert" cellSpacing="1" cellPadding="1" border="0" runat="server">
				<TR class="TableHeaderRed">
					<TD class="TableHeaderGreen" height="25">
                        <asp:Label ID="lblTodaySubmits" runat="server"><%#GetSystemText("Today's Submits")%></asp:Label></TD>
					<TD class="TableHeaderRed" height="25"><asp:Label ID="lblLateSubmits" runat="server"><%#GetSystemText("Late Submits")%></asp:Label></TD></TD>
					<TD class="TableHeaderYellow" height="25"><asp:Label ID="lblTechPackUpdates" runat="server"><%#GetSystemText("Tech Pack Updates")%></asp:Label></TD></TD>
				</TR>
				<TR>
					<TD vAlign="top"><asp:datagrid id="DataGrid1" runat="server" Width="400px" AutoGenerateColumns="False" PageSize="100"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblStyleNoH" runat="server"><%#GetSystemText("Style No")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleNo" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblProcessH" runat="server"><%#GetSystemText("Process")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblSubmit" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblAssignedToH" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblAssignedTo" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblDueDateH" runat="server"><%#GetSystemText("Due Date")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblDueDate" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></TD>
					<TD><asp:datagrid id="Datagrid2" runat="server" Width="400px" AutoGenerateColumns="False" PageSize="100"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblStyleNoH" runat="server"><%#GetSystemText("Style No")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleNoL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblProcessH" runat="server"><%#GetSystemText("Process")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflowL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblSubmitL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblAssignedToH" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblAssignedToL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblDueDateH" runat="server"><%#GetSystemText("Due Date")%></asp:Label>

									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblDuedateL" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></TD>
					<TD width="300"></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
