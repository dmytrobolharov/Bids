﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_BOL_Operations_Edit.aspx.vb"
    Inherits="plmOnApp.Control_BOL_Operations_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Control Panel</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

    <script language="javascript" type="text/javascript">
// <!CDATA[

        //function Submit1_onclick() {

        //}

// ]]>
    </script>

</head>
<body>
    <form id="Form1" runat="server">
    <div>
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveNew" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
<%--                    <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>--%>
                    <cc1:ConfirmedImageButton ID="btnDelete" runat="server" CausesValidation="false"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false">
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
        <table style="border-bottom: orange thin solid" height="45" cellspacing="0" cellpadding="0"
            width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                        ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>
        <%--<cc2:ystabview id="YSTabView" runat="server"></cc2:ystabview>

		<table  style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="Label2" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
			</tr>
		</table>--%>
        <table id="TableEdit" style="border-bottom: orange thin solid" cellspacing="2" cellpadding="0" width="100%" border="0" runat="server">
            <tr>
                <td>
                    <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
                <td valign="top">
                    <table cellspacing="0" cellpadding="0" width="300" border="0" style="background-color: White">
                        <tr>
                            <td class="fontHead" valign="top" width="100">
                                <asp:Label ID="lblImageFile" runat="server"></asp:Label>:
                            </td>
                            <td class="font">
                                <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="font" width="50">
                                <br />
                                <cc1:BWImageButton ID="imgFeature" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <cc1:ConfirmedImageButton ID="btnImageRemove" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr valign="top">
                <td>
                    <table class="TableHeader" id="toolbar2" cellspacing="0" cellpadding="0" width="100%"
                        border="0" runat="server">
                        <tr valign="middle">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td>
                                <cc1:BWImageButton ID="btnAddFixed" runat="server" Message="NONE"></cc1:BWImageButton>
                                <cc1:ConfirmedImageButton ID="btnDeleteFixed" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                            </td>
                        </tr>
                    </table>
                    <table id="Table3" class="TableHeader" runat="server" height="25" cellspacing="0"
                        cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
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
                                <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead"></asp:Button>
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
                                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                            <asp:TemplateColumn HeaderStyle-Width="20" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                <HeaderStyle Width="25px" CssClass="TableHeaderRed"></HeaderStyle>
                                <ItemStyle Width="20px"></ItemStyle>
                                <HeaderTemplate>
                                    <input type="checkbox" onclick="SelectAll(this)" id="checkAll" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkDelete" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                    </asp:DataGrid>
                    <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    </form>

    <script language="javascript">
        var frm = document.Form1;
        function SelectAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
            }
        }
    </script>

</body>
</html>
