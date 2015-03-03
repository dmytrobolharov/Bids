<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_CalendarPages.aspx.vb"
    Inherits="plmOnApp.SampleRequest_Workflow_Submit_CalendarPages" %>

<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title runat="server" id="PageTitle"></title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src='../System/Jscript/YSCalendarFunctions.js'></script>

    <script type="text/javascript">
        function disableEnterKey() {
            if (window.event.keyCode == 13) window.event.keyCode = 0;
        }
    </script>

</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form onkeypress="disableEnterKey()" id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSaveSchedule" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton id="btnAddCalendar" runat="server"  Message="NONE"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton id="btnRemoveCalendar" runat="server"  Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnGoToStyle" runat="server"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnNewIssue" runat="server" Message="NONE" CausesValidation="False"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td width="100%">
                <uc1:Style_Header ID="Style_Header1" runat="server"></uc1:Style_Header>
            </td>
        </tr>
    </table>
    <cc3:YSTabView ID="YSTabView1" runat="server"></cc3:YSTabView>

    <table height="45" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhWorkflowControls" runat="server" ></asp:PlaceHolder>
            </td>
            <td align="center" width="100" style="background-color:White;" id="tdOnlyTracked">
                <asp:Label ID="lblOnlyTracked" runat="server" CssClass="fontHead" Text="Tracked Pages"></asp:Label><br/>
                <asp:CheckBox runat="server" ID="chbOnlyTracked" AutoPostBack="true" />
            </td>
            <td>
            </td>
        </tr>
    </table>

    <asp:Panel ID="Panel1" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td valign="middle" align="left">
                    &nbsp;
                    <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblSchedule"  runat="server"></asp:Label>
                       
                </td>
            </tr>
        </table>
        <asp:DataGrid ID="DataGrid1" runat="server" Width="1200px" BorderWidth="1px" PageSize="100"
            AutoGenerateColumns="False" BorderStyle="Solid" BorderColor="#E0E0E0">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblProcess" runat="server"><%# GetSystemText("Pages")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                        <asp:HiddenField ID="hdnTACalRefTaskId" Value='<%#Eval("TACalRefTaskId")%>' runat="server"/>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblStatusH" runat="server"><%#GetSystemText("Status")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSubmit" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblResubmitDaysH" runat="server"><%#GetSystemText("Resubmit Days")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRDays" runat="server" Width="40px" MaxLength="3"></asp:TextBox>
                        <asp:RangeValidator ID="rvRDays" runat="server" CssClass="fontHead" Text="*"
                            ControlToValidate="txtRDays" Type="Integer" MinimumValue="-99999" MaximumValue="99999" ToolTip='<%#GetSystemText("Integer only!") %>'
                            Display="Dynamic"></asp:RangeValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblAssignedToH" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dlAssignedTo" runat="server" Width="175">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rvAssignedTo" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User") %>...'
                            ControlToValidate="dlAssignedTo" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPartnerOwner" runat="server"><%# GetSystemText("Partner Owner")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dlPartnerOwner" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rvPartnerOwner" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select Partner Owner") %>...'
                            ControlToValidate="dlPartnerOwner" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPlannedStart" runat="server"><%# GetSystemText("Planned Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedStart" runat="server" Width="75px"></asp:Label>
                        <input type="hidden" runat="server" id="hdnPlannedStart" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPlannedEnd" runat="server"><%# GetSystemText("Planned End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedEnd" runat="server" Width="75px"></asp:Label>
                        <input type="hidden" runat="server" id="hdnPlannedEnd" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblRevisedStart" runat="server"><%# GetSystemText("Revised Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRevisedStart" runat="server" Width="75px" MaxLength="10"></asp:TextBox>
                        <asp:Label ID="lblLinkRevisedStart" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblRevisedEnd" runat="server"><%# GetSystemText("Revised End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRevisedEnd" runat="server" Width="75px" MaxLength="10"></asp:TextBox>
                        <asp:Label ID="lblLinkRevisedEnd" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblActualStart" runat="server"><%# GetSystemText("Actual Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblActualStart" runat="server" Width="75px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblActualEnd" runat="server"><%# GetSystemText("Actual End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblActualEnd" runat="server" Width="75px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td valign="middle" align="left">
                    &nbsp;
                    <asp:Label ID="Label2" runat="server">Label</asp:Label>&nbsp;<asp:Label ID="lblSchedule1"  runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:DataGrid ID="DataGrid2" runat="server" Width="1200px" BorderWidth="1px" PageSize="100"
            AutoGenerateColumns="False" BorderStyle="Solid" BorderColor="#E0E0E0">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblProcess" runat="server"><%# GetSystemText("Pages")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                        <asp:HiddenField ID="hdnTACalRefTaskId" Value='<%#Eval("TACalRefTaskId")%>' runat="server"/>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblStatusH" runat="server"><%#GetSystemText("Status")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSubmit" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblResubmitDaysH" runat="server"><%#GetSystemText("Resubmit Days")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRDays" runat="server" Width="40px" MaxLength="3"></asp:TextBox>
                        <asp:RangeValidator ID="rvRDays" runat="server" CssClass="fontHead" Text="*"
                            ControlToValidate="txtRDays" Type="Integer" MinimumValue="-99999" MaximumValue="99999" ToolTip='<%#GetSystemText("Integer only!") %>'
                            Display="Dynamic"></asp:RangeValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblAssignedToH" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dlAssignedTo" runat="server" Width="175">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rvAssignedTo" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User") %>...'
                            ControlToValidate="dlAssignedTo" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPartnerOwner" runat="server"><%# GetSystemText("Partner Owner")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dlPartnerOwner" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rvPartnerOwner" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select Partner Owner") %>...'
                            ControlToValidate="dlPartnerOwner" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPlannedStart" runat="server"><%# GetSystemText("Planned Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedStart" runat="server" Width="75px"></asp:Label>
                        <input type="hidden" runat="server" id="hdnPlannedStart" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPlannedEnd" runat="server"><%# GetSystemText("Planned End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedEnd" runat="server" Width="75px"></asp:Label>
                        <input type="hidden" runat="server" id="hdnPlannedEnd" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblRevisedStart" runat="server"><%# GetSystemText("Revised Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRevisedStart" runat="server" Width="75px" MaxLength="10"></asp:TextBox>
                        <asp:Label ID="lblLinkRevisedStart" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblRevisedEnd" runat="server"><%# GetSystemText("Revised End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRevisedEnd" runat="server" Width="75px" MaxLength="10"></asp:TextBox>
                        <asp:Label ID="lblLinkRevisedEnd" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblActualStart" runat="server"><%# GetSystemText("Actual Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblActualStart" runat="server" Width="75px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblActualEnd" runat="server"><%# GetSystemText("Actual End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblActualEnd" runat="server" Width="75px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
    </asp:Panel>
    <asp:Panel ID="Panel3" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td valign="middle" align="left">
                    &nbsp;
                    <asp:Label ID="Label3" runat="server">Label</asp:Label>&nbsp;<asp:Label ID="lblSchedule2"  runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:DataGrid ID="DataGrid3" runat="server" Width="1200px" BorderWidth="1px" PageSize="100"
            AutoGenerateColumns="False" BorderStyle="Solid" BorderColor="#E0E0E0">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblProcess" runat="server"><%# GetSystemText("Pages")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                        <asp:HiddenField ID="hdnTACalRefTaskId" Value='<%#Eval("TACalRefTaskId")%>' runat="server"/>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblStatusH" runat="server"><%#GetSystemText("Status")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSubmit" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblResubmitDaysH" runat="server"><%#GetSystemText("Resubmit Days")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRDays" runat="server" Width="40px" MaxLength="3"></asp:TextBox>
                        <asp:RangeValidator ID="rvRDays" runat="server" CssClass="fontHead" Text="*"
                            ControlToValidate="txtRDays" Type="Integer" MinimumValue="-99999" MaximumValue="99999" ToolTip='<%#GetSystemText("Integer only!") %>'
                            Display="Dynamic"></asp:RangeValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblAssignedToH" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dlAssignedTo" runat="server" Width="175">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rvAssignedTo" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User") %>...'
                            ControlToValidate="dlAssignedTo" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPartnerOwner" runat="server"><%# GetSystemText("Partner Owner")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dlPartnerOwner" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rvPartnerOwner" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select Partner Owner") %>...'
                            ControlToValidate="dlPartnerOwner" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPlannedStart" runat="server"><%# GetSystemText("Planned Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedStart" runat="server" Width="75px"></asp:Label>
                        <input type="hidden" runat="server" id="hdnPlannedStart" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPlannedEnd" runat="server"><%# GetSystemText("Planned End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedEnd" runat="server" Width="75px"></asp:Label>
                        <input type="hidden" runat="server" id="hdnPlannedEnd" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblRevisedStart" runat="server"><%# GetSystemText("Revised Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRevisedStart" runat="server" Width="75px" MaxLength="10"></asp:TextBox>
                        <asp:Label ID="lblLinkRevisedStart" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblRevisedEnd" runat="server"><%# GetSystemText("Revised End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRevisedEnd" runat="server" Width="75px" MaxLength="10"></asp:TextBox>
                        <asp:Label ID="lblLinkRevisedEnd" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblActualStart" runat="server"><%# GetSystemText("Actual Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblActualStart" runat="server" Width="75px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblActualEnd" runat="server"><%# GetSystemText("Actual End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblActualEnd" runat="server" Width="75px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
    </asp:Panel>
    <asp:Panel ID="Panel4" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td valign="middle" align="left">
                    &nbsp;
                    <asp:Label ID="Label4" runat="server">Label</asp:Label>&nbsp;<asp:Label ID="lblSchedule3"  runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:DataGrid ID="DataGrid4" runat="server" Width="1200px" BorderWidth="1px" PageSize="100"
            AutoGenerateColumns="False" BorderStyle="Solid" BorderColor="#E0E0E0">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <Columns>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblProcess" runat="server"><%# GetSystemText("Pages")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                        <asp:HiddenField ID="hdnTACalRefTaskId" Value='<%#Eval("TACalRefTaskId")%>' runat="server"/>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblStatusH" runat="server"><%#GetSystemText("Status")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblSubmitH" runat="server"><%#GetSystemText("Submit")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblSubmit" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblResubmitDaysH" runat="server"><%#GetSystemText("Resubmit Days")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRDays" runat="server" Width="40px" MaxLength="3"></asp:TextBox>
                        <asp:RangeValidator ID="rvRDays" runat="server" CssClass="fontHead" Text="*"
                            ControlToValidate="txtRDays" Type="Integer" MinimumValue="-99999" MaximumValue="99999" ToolTip='<%#GetSystemText("Integer only!") %>'
                            Display="Dynamic"></asp:RangeValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="150px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblAssignedToH" runat="server"><%#GetSystemText("Assigned To")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dlAssignedTo" runat="server" Width="175">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rvAssignedTo" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select User") %>...'
                            ControlToValidate="dlAssignedTo" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPartnerOwner" runat="server"><%# GetSystemText("Partner Owner")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="dlPartnerOwner" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rvPartnerOwner" runat="server" Display="Dynamic" ToolTip='<%#GetSystemText("Select Partner Owner") %>...'
                            ControlToValidate="dlPartnerOwner" ErrorMessage="*" CssClass="fontHead">*</asp:RequiredFieldValidator>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPlannedStart" runat="server"><%# GetSystemText("Planned Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedStart" runat="server" Width="75px"></asp:Label>
                        <input type="hidden" runat="server" id="hdnPlannedStart" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblPlannedEnd" runat="server"><%# GetSystemText("Planned End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedEnd" runat="server" Width="75px"></asp:Label>
                        <input type="hidden" runat="server" id="hdnPlannedEnd" />
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblRevisedStart" runat="server"><%# GetSystemText("Revised Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRevisedStart" runat="server" Width="75px" MaxLength="10"></asp:TextBox>
                        <asp:Label ID="lblLinkRevisedStart" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="125px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblRevisedEnd" runat="server"><%# GetSystemText("Revised End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtRevisedEnd" runat="server" Width="75px" MaxLength="10"></asp:TextBox>
                        <asp:Label ID="lblLinkRevisedEnd" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblActualStart" runat="server"><%# GetSystemText("Actual Start")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblActualStart" runat="server" Width="75px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn>
                    <HeaderStyle Height="20px" Width="100px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label ID="lblActualEnd" runat="server"><%# GetSystemText("Actual End")%></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblActualEnd" runat="server" Width="75px"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
    </asp:Panel>
    </form>

        <script type="text/javascript" language="javascript">
            if (!$("#drlSampleTACalendarID").val()) {
                $("#gotoCalendar").css('display', 'none')
                $("#tdOnlyTracked").css('display', 'none')
            }
            var goToCalendar = function () {
                var strTACalTemplateId = $("#drlSampleTACalendarID").val()
                var newWin = window.open("../TimeAction/TimeAction_Frame.aspx?TID=" + strTACalTemplateId, "dp", "toolbar=yes,location=yes,directories=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,left=375,top=200");
                newWin.focus();
            }
        </script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
</body>
</html>
