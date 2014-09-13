<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="_SampleRequest_Workflow_Grid.aspx.vb"
    Inherits="srmOnApp._SampleRequest_Workflow_Grid" %>

<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title runat="server" id="PageTitle">Sample Request</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnNew" runat="server" Message="Are you sure you want to add an new style?">
                </cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="btnClose" runat="server"
                    Message="Are you sure you want to do close this form?"></cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
                &nbsp;
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="Large"
                    Font-Names="Tahoma,Verdana">Program Timeline</asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="2" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top">
            </td>
        </tr>
    </table>
    <table id="tbSearch" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
        border="0" runat="server">
        <tr>
            <td style="height: 19px" width="10">
                &nbsp;
            </td>
            <td style="width: 104px; height: 19px" width="104">
                <asp:Label ID="lblStyleNo" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td style="width: 127px; height: 19px" width="127">
                <asp:Label ID="lblDescription" runat="server" CssClass="fontHead">Description</asp:Label>
            </td>
            <td style="height: 19px">
            </td>
            <td style="height: 19px">
                &nbsp;
            </td>
            <td style="height: 19px">
            </td>
            <td style="height: 19px">
            </td>
        </tr>
        <tr>
            <td width="10" height="25">
            </td>
            <td style="width: 104px" width="104" height="25">
                <asp:TextBox ID="txtStyleNo" runat="server" Width="100px" CssClass="font"></asp:TextBox>
            </td>
            <td style="width: 127px" width="127" height="25">
                <asp:TextBox ID="txtStyleDescription" runat="server" CssClass="font"></asp:TextBox>
            </td>
            <td height="25">
                <asp:Button ID="btnSearch" runat="server" CssClass="fontHead" Text="Search"></asp:Button>
            </td>
            <td height="25">
            </td>
            <td height="25">
            </td>
            <td height="25">
            </td>
        </tr>
    </table>
    <asp:DataGrid ID="dgSampleWorkflow" runat="server" AutoGenerateColumns="false" PageSize="100"
        BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
        <HeaderStyle Height="20px"></HeaderStyle>
    </asp:DataGrid><cc3:DataCalendar ID="DataCalendar1" runat="server" BorderColor="Silver"
        BackColor="White" Height="100%" OnVisibleMonthChanged="MonthChange" NextPrevFormat="FullMonth"
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
    </cc3:DataCalendar>
    <br>
    <table id="TB_Alert" cellspacing="1" cellpadding="1" border="0" runat="server">
        <tr class="TableHeaderRed">
            <td class="TableHeaderGreen" height="25">
                <asp:Label ID="lblTodaysSubmits" runat="server">Today's&nbsp;Submits</asp:Label>
            </td>
            <td class="TableHeaderRed" height="25">
                <asp:Label ID="lblLateSubmits" runat="server">Late Submits</asp:Label>
            </td>
            <td class="TableHeaderYellow" height="25">
                <asp:Label ID="lblTechPackUpdates" runat="server">Tech Pack Updates</asp:Label>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <asp:DataGrid ID="DataGrid1" runat="server" Width="400px" AutoGenerateColumns="False"
                    PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Style No")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStyleNo" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label2"><%#GetSystemText("Process")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label3"><%#GetSystemText("Submit")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSubmit" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label4"><%#GetSystemText("Assigned To")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAssignedTo" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label5"><%#GetSystemText("Due Date")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblDueDate" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
            <td>
                <asp:DataGrid ID="Datagrid2" runat="server" Width="400px" AutoGenerateColumns="False"
                    PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label6"><%#GetSystemText("Style No")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStyleNoL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label7"><%#GetSystemText("Process")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblWorkflowL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label8"><%#GetSystemText("Submit")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSubmitL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label9"><%#GetSystemText("Assigned To")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAssignedToL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" CssClass="fontHead" ID="label10"><%#GetSystemText("Due Date")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblDuedateL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
            <td width="300">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
