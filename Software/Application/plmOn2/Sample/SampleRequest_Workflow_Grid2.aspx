<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Grid2.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Grid2" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register TagPrefix="cc4" Namespace="Yunique.WebControls.YSCalendar" Assembly="YSCalendar" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
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
        <LINK href="../System/CSS/Calendar.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <style type="text/css">
            .search-cell td {
            	vertical-align: top !important;
            }
        </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </Scripts>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadScriptManager>
        <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadStyleSheetManager>
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="DarkGray" Font-Size="Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td bgColor="#ffffff"></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">				  
				<tr>
					<td class="search-cell"><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
					<td vAlign="top" width="100%">
						<table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<cc2:YSTabView id="YSTabView1" runat="server" AutoPostBack="true"></cc2:YSTabView>
					</td>
				</tr>
			</table>
            <asp:Panel ID="pnlSampleGrid" runat="server">
            <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
		        <td width="16"><asp:checkbox id="cbThumbnail" runat="server" AutoPostBack="True"></asp:checkbox></td>
		        <td class="fontHead" width="100"><asp:Label ID="lblThumbnail" runat="server" Text="Thumbnail?"></asp:Label></td>
                <td width="20">
                    <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
                </td>
                <td nowrap align="center" width="125">
                    <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgNext" runat="server"></asp:ImageButton>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgLast" runat="server" ToolTip="Last"></asp:ImageButton>
                </td>
                <td width="10">
                    &nbsp;
                </td>
                <td nowrap>
                    <asp:Label ID="RecordCount" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td class="fontHead" align="right" width="110">
                    <asp:Label ID="lblRecordsPerPage" runat="server"></asp:Label>
                </td>
                <td width="25">
                    <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                        <asp:ListItem Value="5">5</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="25" Selected="True">25</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>
                        <asp:ListItem Value="40">40</asp:ListItem>
                        <asp:ListItem Value="50">50</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td width="10">
                    <asp:button id="btnGo" runat="server" CssClass="fontHead" text="GO"></asp:button>
                </td>
            </tr>
        </table>

		<asp:datagrid id="dgSampleRequest" runat="server" BorderStyle="NotSet" AllowSorting="false"
                AutoGenerateColumns="false" AllowPaging="true"
                BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0" DataKeyField="SampleRequestTradeID">
		    <AlternatingItemStyle CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
		    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="false" />
		    <Columns>
                <asp:TemplateColumn ItemStyle-BorderWidth="1">
                    <HeaderStyle CssClass="TableHeader" />
                    <ItemTemplate>
                        <cc1:BWImageButton runat="server" ID="imgRedirect" ImageUrl="../System/icons/icon_search.gif" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn ItemStyle-BorderWidth="1">
                    <HeaderStyle CssClass="TableHeader" />
                    <ItemTemplate>
                        <img runat="server" ID="imgStyle" />
                    </ItemTemplate>
                </asp:TemplateColumn>
		    </Columns>
	    </asp:datagrid>
        </asp:Panel>

        <asp:Panel ID="pnlSampleLate" runat="server" Visible="true">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                Font-Size="8pt" Height="100%" ProcessingMode="Remote" Width="100%" 
                PromptAreaCollapsed="True" ShowParameterPrompts="true" BorderColor="Gray" 
                BorderStyle="Solid" BorderWidth="1px" DocumentMapCollapsed="True" 
                ShowBackButton="True" BackColor="White" 
                ToolBarItemHoverBackColor="GhostWhite" 
                ToolBarItemPressedHoverBackColor="Gainsboro" SizeToReportContent="True"
                PageCountMode="Actual">                
            </rsweb:ReportViewer>
        </asp:Panel>

        <asp:Panel ID="pnlCalendar" runat="server">
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD class="FontHead">
                        <cc1:confirmedimagebutton id="btnCalMonth" runat="server" Message="NONE" CausesValidation="False">
                        </cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnCalWeek" runat="server" Message="NONE" CausesValidation="False">
                        </cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnCalDay" runat="server" Message="NONE" CausesValidation="False">
                        </cc1:confirmedimagebutton>
                    </TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top"><asp:panel id="pnlWeek" runat="server">
							<cc4:ysxdayscalendar id="YSXDaysCalendar1" runat="server" Width="100%" PreviousWeek='<img src="../System/Icons/arrow_left.gif"  border="0" />'
								NextWeek='<img src="../System/Icons/arrow_right.gif"  border="0" />' TableTitleHeaderCssClass="CalendarTitleHeader"
								Days="7" TableTodayHeaderCssClass="CalendarHeaderToday" TableTodayBodyCssClass="CalendarBodyToday"
								HeaderDateFormat=" ddd, MMM dd" TableWeekendHeaderCssClass="CalendarHeaderWeekend" TableWeekendBodyCssClass="CalendarBodyWeekend"
								TableHeaderCssClass="CalendarHeader" TableBodyCssClass="CalendarBody" PreviousFormat="MMM dd" NextFormat="MMM dd">
								<ItemTemplate>								    
									<%# GetCalendarLink(Container.DataItem("PKeyId").ToString, Container.DataItem("CalendarLinkId").ToString, Container.DataItem("CalendarLinkSubId").ToString, Container.DataItem("CalendarDate").ToString, Container.DataItem("CalendarType").ToString, Container.DataItem("CalendarStatus").ToString, Container.DataItem("CalendarDescription").ToString,Container.DataItem("CalendarLinkSubId1").ToString) %>																																			
								</ItemTemplate>
							</cc4:ysxdayscalendar>
						</asp:panel>
	                    <asp:panel id="pnlMonth" runat="server">
							<cc4:ysmonthlycalendar id="Calendar1" 
                            runat="server" 
                            CssClass="font" 
                            BorderWidth="1px" 
                            BorderStyle="Solid"
                            BorderColor="#E0E0E0" DayNameFormat="Full" 
                            NextPrevFormat="FullMonth" CellPadding="0" VisibleDate="2006-01-01"
                            DayField="CalendarDate" 
                            PrevMonthText='<img src="../System/Icons/arrow_left.gif"  border="0" />' 
                            NextMonthText='<img src="../System/Icons/arrow_right.gif"  border="0" />'
                            width="100%" SelectedDate="2006-01-01">
                            <SelectedDayStyle ForeColor="Black" BorderColor="#E0E0E0" BackColor="AliceBlue"></SelectedDayStyle>
                            <OtherMonthDayStyle ForeColor="White" BorderColor="#E0E0E0" BackColor="White"></OtherMonthDayStyle>
                            <TitleStyle Font-Size="Medium" Height="35px" BorderWidth="0px" BorderStyle="None" BorderColor="#FFFFC0"
                            CssClass="font" BackColor="#FFFFC0"></TitleStyle>
                            <DayStyle Font-Size="Medium" Font-Names="Arial" HorizontalAlign="Left" Height="100px" BorderStyle="Solid"
                            CssClass="Font" VerticalAlign="Top" BackColor="White"></DayStyle>
                            <WeekendDayStyle BackColor="WhiteSmoke"></WeekendDayStyle>
                            <DayHeaderStyle Height="25px" BorderStyle="None" CssClass="TableHeaderYellow"></DayHeaderStyle>
                            <ItemTemplate>
                            <%# GetCalendarLink(Container.DataItem("PKeyId").ToString, Container.DataItem("CalendarLinkId").ToString, Container.DataItem("CalendarLinkSubId").ToString, Container.DataItem("CalendarDate").ToString, Container.DataItem("CalendarType").ToString, Container.DataItem("CalendarStatus").ToString, Container.DataItem("CalendarDescription").ToString, Container.DataItem("CalendarLinkSubId1").ToString, Container.DataItem("CalendarSN").ToString)%>									
                            </ItemTemplate>
							</cc4:ysmonthlycalendar>
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
								<TD><asp:calendar id="CalendarRight01" runat="server" CssClass="font" Width="180px" BorderWidth="0px"
										BorderColor="White" DayNameFormat="FirstLetter" CellPadding="0" PrevMonthText='<img src="../System/Icons/arrow_left.gif"  border="0" />'
										NextMonthText='<img src="../System/Icons/arrow_right.gif"  border="0" />' SelectWeekText=" ">
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
								<TD><asp:calendar id="CalendarRight02" runat="server" CssClass="font" Width="180px" BorderColor="White"
										DayNameFormat="FirstLetter" PrevMonthText=" " NextMonthText=" " SelectWeekText=" ">
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
								<TD><asp:calendar id="CalendarRight03" runat="server" CssClass="font" Width="180px" BorderColor="White"
										DayNameFormat="FirstLetter" PrevMonthText=" " NextMonthText=" " SelectWeekText=" ">
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
        </asp:Panel>

        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</form>

        <script type="text/javascript" language="javascript">
            Sys.Application.add_load(function () {
                var viewer = $find("ReportViewer1");
                if (viewer) { viewer.add_propertyChanged(viewerPropertyChanged); }
            });

            function viewerPropertyChanged(sender, e) {
                if (e.get_propertyName() === "isLoading") {
                    var viewer = $find("ReportViewer1");
                    if (viewer.get_isLoading() == false)
                        disable_waittext_for_calendar();
                }
            }

            $(function () {
                $('.with-sample-tooltip').each(function () {
                    var $self = $(this);
                    $self.closest('table').attr('title', $self.attr('title'));
                });
            })
        </script>
	</body>
</HTML>
