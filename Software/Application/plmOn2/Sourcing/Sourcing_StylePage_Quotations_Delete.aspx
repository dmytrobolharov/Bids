<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_Quotations_Delete.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_Quotations_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><% GetSystemText("Delete Quotes")%></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnDelete" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.close();"></cc1:ConfirmedImageButton>
            </td>            
        </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Style Quotations...</asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="top">
            <td>
                <table class="TableHeader" width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                        </td>
                        <td width="16">
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:ImageButton>
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:ImageButton>
                        </td>
                        <td align="center" width="125" nowrap>
                            <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:ImageButton>
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:ImageButton>
                        </td>
                        <td width="10">
                            &nbsp;
                        </td>
                        <td nowrap>
                            <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
                        </td>
                        <td align="right" class="fontHead">
                            <asp:Label ID="lblRecordsPerPage" runat="server" CssClass="fontHead">Records per Page:</asp:Label>
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
                            <asp:Button ID="Button1" runat="server" CssClass="fontHead" Text="GO"></asp:Button>
                        </td>
                    </tr>
                </table>
                <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhSearchControl" runat="server"></asp:PlaceHolder>
                        </td>
                        <td width="100%">
                            <asp:ImageButton ID="imgBtnSearch" runat="server" />
                        </td>
                    </tr>
                </table>
                <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="StyleQuoteItemID" AllowPaging="true" AllowSorting="true">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn Visible="true">
                            <HeaderTemplate>
                                <asp:CheckBox ID="cbSelectAll" OnClick="CheckAll(this);" AutoPostBack="False" runat="server"></asp:CheckBox>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chbStyleQuoteItem" name="chbStyleQuoteItem" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        var frm = document.form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (var i = 0; i < frm.length; i++) {
                var e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf('chbStyleQuoteItem') != -1) {
                    if (e.disabled != true && e.name != 'chbBatchUpdate') {
                        e.checked = actVar;
                    }
                }
            }
        }
    </script>
    </form>
</body>
</html>
