<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_New_SeasonYearAdd.aspx.vb" Inherits="plmOnApp.Material_New_SeasonYearAdd" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>            
            <td valign="top">
                <asp:ImageButton runat="server" ID="btnAdd" />
                <asp:ImageButton runat="server" ID="btnClose" OnClientClick="return btnClose_Click()" />
            </td>
            <td width="75">
                &nbsp;
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0" class="TableHeader">
        <tr>
            <td align="center" width="10" height="25">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                &nbsp;<asp:Label ID="lblColorSearch" runat="server" Text="">Season & Year </asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="top">
            <td>
                <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                    border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
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
                            <asp:ImageButton ID="btnImgLast" runat="server"></asp:ImageButton>
                        </td>
                        <td width="10">
                            &nbsp;
                        </td>
                        <td nowrap>
                            <asp:Label ID="RecordCount" runat="server" CssClass="fontHead"></asp:Label>
                        </td>
                        <td class="fontHead" align="right" width="110">
                            <asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label>
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
                            <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead" Text="GO"></asp:Button>
                        </td>
                    </tr>
                </table>
                <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
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
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="SeasonYearID">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkSelect" Checked='<%# SeasonYearIDs.Contains(Eval("SeasonYearID").ToString) %>' />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
    </form>
        <script language="javascript">
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
        </script>
</body>
</html>
