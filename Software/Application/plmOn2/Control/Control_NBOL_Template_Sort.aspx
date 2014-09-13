<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_NBOL_Template_Sort.aspx.vb"
    Inherits="plmOnApp.Control_NBOL_Template_Sort" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tbody>
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                    </td>
                    <td valign="middle" align="left" width="400">
                        <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:ConfirmedImageButton ID="imgBtnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                    </td>
                    <td>
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
            height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                        ForeColor="#E0E0E0">Bla Bla</asp:Label>
                </td>
            </tr>
        </table>
        <table border="0">
            <tr>
                <td width="100">
                    &nbsp;
                </td>
                <td>
                    <!---------------------->
                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr valign="middle">
                            <td>
                                <span class="fontHead">
                                    <asp:Label ID="lblSortBy" runat="server" Text="Sort by"></asp:Label>: &nbsp;</span><asp:DropDownList
                                        runat="server" ID="ddlSortBy" CssClass="font">
                                    </asp:DropDownList>
                                <cc1:ConfirmedImageButton ID="btnSort" runat="server" Message="NONE"></cc1:ConfirmedImageButton><br>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                                <asp:DataGrid ID="DataGrid1" runat="server" EnableViewState="true" AutoGenerateColumns="False"
                                    BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" DataKeyField="TemplateItemID">
                                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                    <PagerStyle Visible="False"></PagerStyle>
                                </asp:DataGrid>
                                <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
