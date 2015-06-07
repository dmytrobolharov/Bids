<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calendar_LineList_Add.aspx.vb" Inherits="plmOnApp.Calendar_LineList_Add" %>


<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />    
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
    <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="top">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.close(); return false;">
                </cc1:ConfirmedImageButton>
            </td>
            <td width="75">
                &nbsp;
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                <asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td width="100%" valign="top">
                <table height="45">
                    <tr>
                        <td valign="middle">
                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
        border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td width="16">
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
    <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="LineFolderID" BorderStyle="Solid" BorderWidth="1px">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelected" runat="server"></asp:CheckBox>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
    </form>
    <script type="text/javascript">
        var frm = document.forms['form1'];
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (var i = 0; i < frm.length; i++) {
                var e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
                    e.checked = actVar;
            }
        }
    </script>
</body>
</html>