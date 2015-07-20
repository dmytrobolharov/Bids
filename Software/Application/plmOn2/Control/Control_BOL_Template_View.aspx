﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_BOL_Template_View.aspx.vb"
    Inherits="plmOnApp.Control_BOL_Template_View" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Control Panel</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnEdit" Visible="true" runat="server" Message="NONE"
                        CausesValidation="False"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" CausesValidation="false" Message="NONE" OnClientClick="return btnClose_Click()">
                    </cc1:ConfirmedImageButton>
                </td>
                <td class="FontHead" align="right" width="75">
                </td>
                <td width="40">
                </td>
                <td>
                </td>
            </tr>
        </table>
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
            height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                        ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
<%--        <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>--%>
        <table id="Table2" class="TableHeader" visible="false" runat="server" cellspacing="0"
            cellpadding="0" width="100%" border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="ImageButton1"
                        runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnTabEdit" Visible="false" runat="server" Message="NONE"
                        CausesValidation="False"></cc1:ConfirmedImageButton>
                    <cc1:BWImageButton ID="btnTabAdd" Visible="false" runat="server"></cc1:BWImageButton>
                    <cc1:ConfirmedImageButton ID="btnTabDelete" Visible="false" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnTabSave" Visible="false" runat="server" Message="NONE">
                    </cc1:ConfirmedImageButton>
                </td>
                <td class="FontHead" align="right" width="75">
                </td>
                <td width="40">
                </td>
                <td>
                </td>
            </tr>
        </table>
        <table id="TableEdit" style="border-bottom: orange thin solid" runat="server" cellspacing="2" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td>
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" width="300" border="0" style="background-color: White">
                        <tr>
                            <td colspan="2" class="font" width="50">
                                <br />
                                <cc1:BWImageButton ID="imgFeature" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table id="Table3" class="TableHeader" runat="server" visible="false" height="25"
            cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif">
                    </asp:ImageButton>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif">
                    </asp:ImageButton>
                </td>
                <td nowrap align="center" width="125">
                    <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif">
                    </asp:ImageButton>
                </td>
                <td width="20">
                    <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif">
                    </asp:ImageButton>
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
                    <asp:Button ID="btnRepage" OnClick="RePage" runat="server" CssClass="fontHead" Text="GO">
                    </asp:Button>
                </td>
            </tr>
        </table>
        <table id="Table4" height="15" runat="server" cellspacing="0" cellpadding="0" width="100%"
            bgcolor="white" border="0">
            <tr>
                <td>
                    <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder>
                </td>
                <td valign="top" width="100%">
                    <table height="45">
                        <tr>
                            <td>
                                <asp:ImageButton ID="imgBtnSearch" Visible="false" runat="server"></asp:ImageButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="TemplateEntryId">
            <AlternatingItemStyle Height="20px" CssClass="ItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="False"></PagerStyle>
            <Columns>
                <asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro">
                    <HeaderStyle Width="30px" CssClass="TableHeader"></HeaderStyle>
                    <HeaderTemplate>
                        <asp:Label runat="server" ID="lblMacro" Text="Macro" />
                    </HeaderTemplate>
                    <ItemStyle Width="30px" HorizontalAlign="Center"></ItemStyle>
                    <ItemTemplate>
                        <asp:Image runat="server" ID="imgIsMacro" ImageUrl="../System/Icons/tv_plusdotsbt.gif" />
                        <asp:HiddenField runat="server" ID="hdnMacroParentId" Value="" />
                        <asp:HiddenField runat="server" ID="hdnMacroId" Value="" />
                        <asp:HiddenField runat="server" ID="hdnOperationId" Value="" />
                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>
        </asp:DataGrid>
        <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="top">
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>

<script language="javascript">
    var frm = document.form1;

    function SelectAll(checkAllBox) {
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                if (e.disabled == false)
                e.checked = actVar;
        }
    }
    function getElementsByNameIE(tag, name) {

        var elem = document.getElementsByTagName(tag);
        var arr = new Array();
        for (i = 0, iarr = 0; i < elem.length; i++) {
            att = elem[i].getAttribute("name");
            if (att == name) {
                arr[iarr] = elem[i];
                iarr++;
            }
        }
        return arr;
    }

    function hideUnhide(MacroParentId, id) {
        var h = getElementsByNameIE("tr", "hide_" + MacroParentId)
        for (var i = 0; i < h.length; i++) {
            if (h[i].style.display == 'none') {
                h[i].style.display = ''
                document.getElementById(id).src = '../System/Icons/tv_minusdotst.gif'
            }
            else {
                if (h[i].style.display == '') h[i].style.display = 'none'
                document.getElementById(id).src = '../System/Icons/tv_plusdotsbt.gif'
            }
        }
    }
	    
</script>
<script language="javascript">
	function btnClose_Click() {
		<%= strExitScript %>
        return false;
    }
</script>
</html>
