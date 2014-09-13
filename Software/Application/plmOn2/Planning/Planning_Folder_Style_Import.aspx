<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Style_Import.aspx.vb" Inherits="plmOnApp.Planning_Folder_Style_Import" %>

<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Style Search</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />    
    <script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <asp:ImageButton ID="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px">
                </asp:ImageButton>
                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnCopy" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="imgBtnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Style</asp:Label>
            </td>
        </tr>
    </table>
    <cc3:YSTabView ID="YSTabView1" runat="server"></cc3:YSTabView>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td width="100%" valign="middle">
                <table id="Table3" height="45">
                    <tr>
                        <td valign="middle">
                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table class="TableHeader" id="Table2" height="20" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr class="fontHead">
            <td align="center" width="10" height="25">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td align="left" width="100" height="25">
                <label><input type="checkbox" onclick="checkAll(this)" /><%= GetSystemText("Select All")%></label>
            </td>
            <td height="25">
                <div align="left">
                    &nbsp;
                    <asp:Label ID="lblCurrentIndex" Text="0" Visible="False" runat="server"></asp:Label><asp:Label ID="lblPageSize"
                        Text="10" Visible="False" runat="server">10</asp:Label>
                </div>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:ImageButton>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:ImageButton>
            </td>
            <td nowrap align="center" width="125">
                <asp:Label ID="lblCounts" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:ImageButton>
            </td>
            <td width="20">
                <asp:ImageButton ID="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:ImageButton>
            </td>
            <td width="10">
                &nbsp;
            </td>
            <td nowrap height="25">
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;
                        <asp:Label ID="lblRecordFound" runat="server" />
                    </b>
                </div>
            </td>
            <td height="25">
                <p align="right">
                    <asp:DropDownList ID="ddlSortField" runat="server">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlSortBy" runat="server">
                        <asp:ListItem Value="ASC">ASC</asp:ListItem>
                        <asp:ListItem Value="DESC">DESC</asp:ListItem>
                    </asp:DropDownList>
                    <asp:ImageButton ID="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton></p>
            </td>
        </tr>
    </table>
    <table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0">
        <tr>
            <td valign="top">
                <asp:DataList ID="Datalist1" runat="server" DataKeyField="PlanningItemID" RepeatLayout="Table" RepeatColumns="1"
                    RepeatDirection="Horizontal" EnableViewState="true">
                    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"
                        BackColor="White"></ItemStyle>
                    <ItemTemplate>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:DataList>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var frm = document.forms[0];
        function checkAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (var i = 0, len = frm.length; i < len; i++) {
                var e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf('Datalist1') != -1 && !e.disabled)
                    e.checked = actVar;
            }
        }               
    </script>
    </form>
</body>
</html>
