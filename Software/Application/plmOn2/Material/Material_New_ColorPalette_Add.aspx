<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_New_ColorPalette_Add.aspx.vb" Inherits="plmOnApp.Material_New_ColorPalette_Add" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Assembly="YSTab" Namespace="Yunique.WebControls.YSTab" TagPrefix="cc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Palette</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
    <table class="TableHeader" id="TABLE1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="top">
                <asp:ImageButton ID="btnBack" runat="server"></asp:ImageButton>
                <asp:ImageButton ID="btnClose" runat="server" OnClientClick="return btnClose_Click()"/>
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
    <table height="10" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <cc2:YSTabView ID="YSTabView1" runat="server" />
    <table class="TableHeader TableFloatHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td valign="top">
                <asp:ImageButton ID="btnAdd" runat="server"></asp:ImageButton>                
            </td>
            <td width="75">
                &nbsp;
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td width="100%" valign="top">
                <table id="Table3" height="45">
                    <tr>
                        <td>
                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table id="Table2" border="0" cellpadding="0" cellspacing="0" class="TableHeader" height="20" width="100%">
        <tr class="fontHead">
            <td align="center" height="25" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td height="25">
                <div align="left">
                    &nbsp;
                    <asp:Label ID="lblCurrentIndex" runat="server" Text="0" Visible="False"></asp:Label>
                    <asp:Label ID="lblPageSize" runat="server" Text="49" Visible="False"></asp:Label>
                </div>
            </td>
            <td height="25" width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgFirstRecord" runat="server" ImageUrl="../System/Icons/icon_first.gif" Style="width: 16px">
                    </asp:ImageButton>
                </div>
            </td>
            <td height="25" width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgPreviousRecord" runat="server" ImageUrl="../System/Icons/icon_Previous.gif">
                    </asp:ImageButton>
                </div>
            </td>
            <td height="25" width="125">
                <div align="center">
                    <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label>
                </div>
            </td>
            <td height="25" width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgNextRecord" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:ImageButton>
                </div>
            </td>
            <td height="25" width="20">
                <div align="center">
                    <asp:ImageButton ID="btnImgLastRecord" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:ImageButton>
                </div>
            </td>
            <td height="25">
                <div align="left">
                    <b>
                        <asp:Label ID="lblRecordCount" runat="server" Visible="true"></asp:Label>
                        &nbsp;<asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label></b></div>
            </td>
            <td height="25" >
                <p align="right" style="margin:0;">
                    <asp:DropDownList ID="ddlSortField" runat="server">
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlSortBy" runat="server">
                        <asp:ListItem Value="ASC">ASC</asp:ListItem>
                        <asp:ListItem Value="DESC">DESC</asp:ListItem>
                    </asp:DropDownList>
                    <asp:ImageButton ID="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif" />
                </p>
            </td>
        </tr>
    </table>
    <table class="TableHeader" cellpadding="0" cellspacing="0" width="100%" id="tablechk" runat="server">
        <tr>
            <td align="center" height="25" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td valign="top" align="left">
                <asp:CheckBox onclick="SelectAll(this)" ID="chkSelectAll" runat="server" />
                <asp:Label ID="lblcheck" runat="server">Check all Colors</asp:Label>
            </td>
        </tr>
    </table>
    <table border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
        <tr>
            <td valign="top">
                <asp:DataList ID="Datalist1" runat="server" EnableViewState="False" RepeatColumns="1" BorderColor="Gray"
                    BorderWidth="1px" CellPadding="2" GridLines="Both" DataKeyField="ColorPaletteID">
                    <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"
                        VerticalAlign="Top" />
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:DataList>
            </td>            
        </tr>
    </table>
    <script language="javascript" type="text/javascript">
        var frm = document.form1;
        function SelectAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkColorSelect") != -1)
                    e.checked = actVar;
            }
        }

        // allow color selection by clicking on a color itself, not just checkbox
        $(":checkbox[id$=chkColorSelect]")
            .parent().css('position', 'relative').end()
            .wrap($("<label>").css({ position: 'absolute', width: '100%', height: '100%' }));

            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
    </script>
    </form>
</body>
</html>
