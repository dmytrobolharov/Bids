<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Marker.aspx.vb"
    Inherits="plmOnApp.Style.Marker.Style_Marker" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Style - Marker</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form2" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true" />
    <!-- Toolbar -->
    <uc1:Style_Workflow ID="Style_Workflow1" runat="server"></uc1:Style_Workflow>
    <asp:Panel ID="pnlChange" runat="server">
    </asp:Panel>
    <uc2:Style_Header ID="Style_Header1" runat="server"></uc2:Style_Header>
    <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td height="20">
                <uc1:Style_Comment ID="Style_Comment1" runat="server"></uc1:Style_Comment>
            </td>
        </tr>
    </table>
    <br />
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:bwimagebutton ID="btnCreateMarker" runat="server" Message="NONE"></cc1:bwimagebutton>
                <cc1:bwimagebutton ID="btnAdd1" runat="server" Message="NONE" runat="server">
                </cc1:bwimagebutton>
                <cc1:BWImageButton ID="btnRemove" runat="server" Message="NONE" runat="server"></cc1:BWImageButton>
                <cc1:bwimagebutton ID="btnAddBF" runat="server" Message="NONE" runat="server">
                </cc1:bwimagebutton>&nbsp;&nbsp;&nbsp;
                <asp:CheckBox valign="top" align="center" ID="chbImperial" AutoPostBack="true" runat="server"
                    Text="Imperial" CssClass="fontHead" />
                <asp:Image id="ImgWFLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible="false"/>
                <asp:Image id="ImgWFParent" runat="server" ImageUrl="../System/Icons/icon_parent_link.gif" Visible="false"/>
            </td>
        </tr>
    </table>
    <br />
    <!-- HEADER -->
    <!-- Model List View -->
    <asp:DataGrid ID="Datagrid2" runat="server" AllowSorting="True" AutoGenerateColumns="false"
        DataKeyField="ID" Width="1800px">
        <AlternatingItemStyle Height="25px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <div align="center">
                        <asp:Label ID="lblLink" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></div>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Image ID="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif"
                        Visible='<%# DisplayLinkedVisible(Container.DataItem("IsLinked")) %>' ToolTip='<%#GetSystemText("Linked")%>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <div align="center">
                        <asp:Label ID="lblLinkBF" runat="server" CssClass="fontHead"><%#GetSystemText("LBF")%></asp:Label></div>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Image ID="ImgLinkedBF" runat="server" ImageUrl="../System/Icons/icon_folderLinked.gif"
                        Visible='<%# DisplayBF(Container.DataItem("IsLinkedBF")) %>' ToolTip='<%#GetSystemText("Linked to Body Folder")%>' />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <asp:Label ID="SortOrder2" runat="server" Visible="False"></asp:Label>
    <br />
    <br />
    <asp:Label ID="lblSummary" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large"
        ForeColor="#666666">Marker Spreadsheet</asp:Label>
    <br />
    <br />
    <asp:DataGrid ID="Datagrid1" runat="server" AllowSorting="False" AutoGenerateColumns="false"
        BorderColor="Gainsboro" BorderStyle="None" BorderWidth="1px">
        <AlternatingItemStyle Height="20px" Width="50px" CssClass="AlternateItemTemplate">
        </AlternatingItemStyle>
        <ItemStyle Height="20px" Width="50px" CssClass="ItemTemplate" BorderColor="Gainsboro"
            BorderWidth="1px"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader" BorderColor="Gainsboro" BorderWidth="1px">
        </HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
        </Columns>
    </asp:DataGrid>
    <asp:Label ID="SortOrder1" runat="server" Visible="False"></asp:Label>
    <br />
    <table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_left.gif" />
            </td>
            <td class="TableBar" valign="middle" align="center" width="20">
                <img src="../System/icons/icon_changeobject.gif">
            </td>
            <td class="TableBar">
                <asp:Label ID="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
                <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_right.gif" />
            </td>
        </tr>
    </table>
    </form>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" language="javascript">
        function jsWorkWhereUsed(StyleWorkflowID, StyleID, ShowParent) {

            PageMethods.WorkflowWhereUsed(StyleWorkflowID, StyleID, ShowParent, function (strHTML) {

                var $confirmDialog = $("<div></div>");
                $confirmDialog.html(strHTML);
                $confirmDialog.dialog({
                    autoOpen: false,
                    modal: true,
                    resizable: false,
                    title: '<%= GetSystemText("Page Where Used") %>',
                    buttons: { '<%= GetSystemText("Close") %>': function () { $(this).dialog("close"); } }
                });

                $confirmDialog.dialog('open');
            }, function () { console.log(arguments) });
        }	    
	</script> 
</body>
</html>
