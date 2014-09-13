<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="_SampleRequest_Workflow_Submit_Calendar.aspx.vb"
    Inherits="srmOnApp._SampleRequest_Workflow_Submit_Calendar" %>

<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title runat="server" id="PageTitle">Sample Approval</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">

    <script language="javascript">
        function calendar(sTxtBoxName) {
            windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
            windowDatePicker.focus();
        }
    </script>

    <script type="text/javascript">
        function disableEnterKey() {
            if (window.event.keyCode == 13) window.event.keyCode = 0;
        }
    </script>

</head>
<body>
    <form onkeypress="disableEnterKey()" id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="80">
                <cc1:BWImageButton ID="btnGoToStyle" runat="server"></cc1:BWImageButton>
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="Do you want to close this window?">
                </cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana">Submit Calendar</asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td width="900">
                <uc1:Style_Header ID="Style_Header1" runat="server"></uc1:Style_Header>
            </td>
            <td>
                <cc1:BWImageButton ID="imgDesign" runat="server"></cc1:BWImageButton>
            </td>
        </tr>
    </table>
    <cc3:YSTabView ID="YSTabView1" runat="server"></cc3:YSTabView>
    <table class="TableHeader" id="TB_Schedule" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSaveSchedule" runat="server" Message="NONE"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                    ID="btnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <asp:DataGrid ID="DataGrid1" runat="server" Width="800px" BorderWidth="1px" PageSize="100"
        AutoGenerateColumns="False" BorderStyle="Solid" BorderColor="#E0E0E0">
        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Process")%></asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Status")%></asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblStatus" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Submit")%></asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblSubmit" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Assigned To")%></asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="dlAssignedTo" runat="server">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rvAssignedTo" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User")%>...'
                        ControlToValidate="dlAssignedTo" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Due Date")%></asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="txtDueDate" runat="server" Width="75px" MaxLength="10"></asp:TextBox><a
                        id="aDueDate" runat="server"><img height="17" src="../System/Icons/icon_calendar.gif"
                            width="18" border="0"></a>
                    <asp:RegularExpressionValidator ID="rvDueDate" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Between 0 to 999 Days")%>'
                        ValidationExpression="^(?:(?:0?[13578]|1[02])|(?:0?[469]|11)(?!\/31)|(?:0?2)(?:(?!\/3[01]|\/29\/(?:(?:0[^48]|[13579][^26]|[2468][^048])00|(?:\d{2}(?:0[^48]|[13579][^26]|[2468][^048]))))))\/(?:0?[1-9]|[12][0-9]|3[01])\/\d{4}$"
                        ControlToValidate="txtDueDate" ErrorMessage="*" CssClass="fontHead"></asp:RegularExpressionValidator>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid><br>
    <cc2:DataCalendar ID="DataCalendar1" runat="server" BorderColor="Silver" BackColor="White"
        Height="100%" OnVisibleMonthChanged="MonthChange" NextPrevFormat="FullMonth"
        DayNameFormat="Full" Font-Name="Tahoma" Width="100%" DayField="Duedate">
        <TodayDayStyle ForeColor="#C00000" BackColor="#FFFF80"></TodayDayStyle>
        <OtherMonthDayStyle ForeColor="Black" BackColor="Gainsboro"></OtherMonthDayStyle>
        <TitleStyle Font-Bold="True" Height="20px" BorderWidth="0px" ForeColor="White" CssClass="FontHead">
        </TitleStyle>
        <SelectorStyle BackColor="Red"></SelectorStyle>
        <NextPrevStyle ForeColor="White" CssClass="FontHead"></NextPrevStyle>
        <DayStyle Font-Size="X-Small" HorizontalAlign="Left" Height="100px" CssClass="fontHead"
            VerticalAlign="Top"></DayStyle>
        <WeekendDayStyle BackColor="WhiteSmoke"></WeekendDayStyle>
        <DayHeaderStyle Height="20px" CssClass="TableHeaderOver"></DayHeaderStyle>
        <itemtemplate>
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
				</itemtemplate>
    </cc2:DataCalendar>
    </form>
</body>
</html>
