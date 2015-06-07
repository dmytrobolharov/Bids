<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_StyleDelete_Confirm.aspx.vb"
    Inherits="plmOnApp.Control_StyleDelete_Confirm" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Control_StyleDelete_Confirm</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnDelete" runat="server" CausesValidation="False"
                    Message="NONE"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                        ID="btnCancel" runat="server" CausesValidation="False" 
                        Message="NONE"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="top">
            <td>
                <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
                    bgcolor="#ffffff" border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="16">
                            <asp:CheckBox ID="cbThumbnail" runat="server" AutoPostBack="True"></asp:CheckBox>
                        </td>
                        <td class="fontHead" width="100">
                            <asp:Label ID="lblThumbnail" runat="server"></asp:Label>
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
                        </td>
                        <td nowrap align="center" width="75">
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
                            <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
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
                                <asp:ListItem Value="25">25</asp:ListItem>
                                <asp:ListItem Value="30">30</asp:ListItem>
                                <asp:ListItem Value="40">40</asp:ListItem>
                                <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td width="10">
                            <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead"></asp:Button>
                        </td>
                    </tr>
                </table>
                <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="StyleID">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
             
                    <Columns>
                        <asp:TemplateColumn ItemStyle-Width="50px">
                            <HeaderTemplate><%# GetSystemText("Picture")%></HeaderTemplate>
                            <ItemTemplate><asp:Image runat="server" ID="imgDesignSketchID" ImageUrl='<%# GetImageStreamPath("50", Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>' /></ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:BoundColumn DataField="Description"  ItemStyle-Width="200">
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="StyleNo" ></asp:BoundColumn>
                    </Columns>
                    <PagerStyle Visible="False"></PagerStyle>
                </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
