<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Care.aspx.vb" Inherits="plmOnApp.Style.Care.Style_Care" %>

<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title runat="server" id="PageTitle"></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <uc1:Style_Workflow ID="Style_Workflow1" runat="server" ChangeTransTablePKID='<%# strStyleCareId %>'></uc1:Style_Workflow>
    <asp:Panel ID="pnlChange" runat="server">
        <uc1:Style_Change_Alert ID="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
    </asp:Panel>
    <uc2:Style_Header ID="Style_Header1" runat="server" StyleId='<%# Request("SID")%>'>
    </uc2:Style_Header>
    <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td height="20">
                <uc1:Style_Comment ID="Style_Comment1" runat="server"></uc1:Style_Comment>
            </td>
        </tr>
    </table>
    <table bordercolor="whitesmoke" cellspacing="0" cellpadding="0" width="100%" border="1">
        <tr>
            <td valign="top" width="100%" bgcolor="#ffffff">
                <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%"
                    border="0">
                    <tr>
                        <td valign="middle" align="center" width="10" height="25">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td>
                            <asp:Label ID="lblCareInstructions" runat="server">Care Instructions</asp:Label>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table class="TableHeader" bordercolor="gainsboro" cellspacing="0" cellpadding="0"
        width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10" height="25">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <asp:Label ID="lblCareLabels" runat="server">Care Labels</asp:Label>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    
    <table  bordercolor="#ffffff" cellspacing="1" cellpadding="1" width="100%" bgcolor="#ffffff"
        border="2">
        <tr>
            <td valign="top">
                <asp:DataList ID="Datalist2" runat="server" EnableViewState="false" RepeatDirection="Horizontal"
                    RepeatColumns="1" RepeatLayout="Table">
                    <ItemStyle HorizontalAlign="Center" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
                        VerticalAlign="Top" BackColor="White"></ItemStyle>
                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    <ItemTemplate>
                        <table id="tbItem" runat="server" bordercolor='#CCCCCC' border="1" cellpadding="0"
                            width="100%" cellspacing="0">
                            <tr>
                                <td>
                                    <table class="TableHeader" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="lblText" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr height="130">
                                <td align="center" width="130">
                                    <asp:Image ID="imgDesign" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:PlaceHolder ID="pnlHeader" runat="server"></asp:PlaceHolder>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
    </table>
    <table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
        runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_left.gif">
            </td>
            <td class="TableBar" valign="middle" align="center" width="20">
                <img src="../System/icons/icon_changeobject.gif">
            </td>
            <td class="TableBar">
                <asp:Label ID="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
                <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_right.gif">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
