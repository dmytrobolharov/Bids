<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Late.aspx.vb"
    Inherits="plmOnApp.SampleRequest_Late" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title runat="server" id="PageTitle"></title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Calendar.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
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

    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tbody>
            <tr>
                <td height="50">
                    &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="DarkGray" Font-Size="Large"
                        Font-Names="Tahoma,Verdana"></asp:Label>
                </td>
            </tr>
        </tbody>
    </table>
    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">				  
		<tr>
			<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
			<td vAlign="top" width="100%">
				<table height="45">
					<tr>
						<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
    <br />
    <cc3:YSTabView ID="YSTabView1" runat="server"></cc3:YSTabView>
    <table class="TableHeaderRed" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td class="FontHead">
                <asp:Label ID="lblTitle" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <%--<table id="tbSearch" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
        border="0" runat="server">
        <tr>
            <td style="height: 19px" width="10">
                &nbsp;
            </td>
            <td style="height: 19px">
                <asp:Label ID="lblAgent" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td style="height: 19px">
                <asp:Label ID="lblVendor" runat="server" CssClass="fontHead"></asp:Label>
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
            <td width="155" height="25">
                <asp:DropDownList ID="ddlAgent" runat="server" AutoPostBack="True" Width="150px">
                </asp:DropDownList>
            </td>
            <td width="125" height="25">
                <asp:DropDownList ID="ddlVendor" runat="server" AutoPostBack="True" Width="150px">
                </asp:DropDownList>
            </td>
            <td height="25">
                <asp:Button ID="Button1" runat="server" CssClass="fontHead"></asp:Button>
            </td>
            <td height="25">
            </td>
            <td height="25">
            </td>
            <td height="25">
            </td>
        </tr>
    </table>--%>
    <%--<table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" 
        border="0" style="height: 29px">
        <tr>
            <td valign="top">
                <asp:DataList ID="dlSampleWorkflow" runat="server" RepeatDirection="Horizontal">
                    <ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
                        VerticalAlign="Top" BackColor="White"></ItemStyle>
                    <ItemTemplate>
                        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
                            border="0">
                            <tr valign="middle">
                                <td valign="middle" align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                </td>
                                <td>
                                    <asp:Label ID="lblSampleWorkflow" runat="server" CssClass="fontHead">
                                    </asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:Label ID="lblSubmitList" runat="server" CssClass="fontHead">
                        </asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:DataList>
            </td>
        </tr>
    </table>--%>
       <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
            <br/>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                Font-Size="8pt" Height="100%" ProcessingMode="Remote" Width="100%" 
                PromptAreaCollapsed="True" ShowParameterPrompts="true" BorderColor="Gray" 
                BorderStyle="Solid" BorderWidth="1px" DocumentMapCollapsed="True" 
                ShowBackButton="True" BackColor="WhiteSmoke" 
                ToolBarItemHoverBackColor="GhostWhite" 
                ToolBarItemPressedHoverBackColor="Gainsboro" SizeToReportContent="True">
            </rsweb:ReportViewer>
            <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
    </form>
</body>
</html>
