<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Grid_My.aspx.vb"
    Inherits="plmOnApp.SampleRequest_Workflow_Grid_My" %>

<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title runat="server" id="PageTitle"></title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" border="0">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnNew" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server"></cc1:ConfirmedImageButton>
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
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:Label ID="lblMyList" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblStyleNo" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblDescription" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblSeason" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblYear" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblAgent" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblVendor" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td>
            </td>
            <td>
                &nbsp;
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td width="10" height="25">
            </td>
            <td valign="middle" align="center" width="53" height="25">
                <asp:CheckBox ID="cbMyList" runat="server"></asp:CheckBox>
            </td>
            <td width="104" height="25">
                <asp:TextBox ID="txtStyleNo" runat="server" CssClass="font" Width="100px"></asp:TextBox>
            </td>
            <td width="127" height="25">
                <asp:TextBox ID="txtStyleDescription" runat="server" CssClass="font"></asp:TextBox>
            </td>
            <td width="75" height="25">
                <asp:DropDownList ID="ddlSeason" runat="server" Width="70px">
                </asp:DropDownList>
            </td>
            <td width="75" height="25">
                <asp:DropDownList ID="ddlYear" runat="server" Width="70px">
                </asp:DropDownList>
            </td>
            <td width="155" height="25">
                <asp:DropDownList ID="ddlAgent" runat="server" Width="150px" AutoPostBack="True">
                </asp:DropDownList>
            </td>
            <td width="125" height="25">
                <asp:DropDownList ID="ddlVendor" runat="server" Width="150px">
                </asp:DropDownList>
            </td>
            <td height="25">
                <asp:Button ID="btnSearch" runat="server" CssClass="fontHead"></asp:Button>
            </td>
            <td height="25">
            </td>
            <td height="25">
            </td>
            <td height="25">
            </td>
        </tr>
    </table>
    <asp:DataGrid ID="dgSampleWorkflow" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid"
        BorderWidth="1px" PageSize="100" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
        <HeaderStyle Height="20px"></HeaderStyle>
    </asp:DataGrid><cc3:DataCalendar ID="DataCalendar1" runat="server" BorderColor="Silver"
        DayField="Duedate" Width="100%" Font-Name="Tahoma" DayNameFormat="Full" NextPrevFormat="FullMonth"
        OnVisibleMonthChanged="MonthChange" Height="100%" BackColor="White">
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
                <asp:Label ID="lblTodaySubmits" runat="server"><%#GetSystemText("Today's Submits")%></asp:Label>
            </td>
            <td class="TableHeaderRed" height="25">
                <asp:Label ID="lblLateSubmits" runat="server"><%#GetSystemText("Late Submits")%></asp:Label>
            </td>
            <td class="TableHeaderYellow" height="25">
                <asp:Label ID="lblTechPackUpdates" runat="server"><%#GetSystemText("Tech Pack Updates")%></asp:Label>
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
                                <asp:Label ID="lblStyleNoH" runat="server"><%#GetSystemText("Style No")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStyleNo" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label ID="lblProcessH" runat="server"><%#GetSystemText("Process")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                               <asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSubmit" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label ID="lblAssignedToH" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>s
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAssignedTo" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                              <asp:Label ID="lblDueDateH" runat="server"><%#GetSystemText("Due Date")%></asp:Label>
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
                               <asp:Label ID="lblStyleNoHL" runat="server"><%#GetSystemText("Style No")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStyleNoL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                              <asp:Label ID="lblProcessHL" runat="server"><%#GetSystemText("Process")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblWorkflowL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                               <asp:Label ID="lblSubmitHL" runat="server"><%#GetSystemText("Submit")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSubmitL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                            <asp:Label ID="lblAssignedToHL" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAssignedToL" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                               <asp:Label ID="lblDueDateHL" runat="server"><%#GetSystemText("Due Date")%></asp:Label>
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
