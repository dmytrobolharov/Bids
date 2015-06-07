<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_List_Search.aspx.vb" Inherits="plmOnApp.Sourcing_Page_List_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sourcing Search</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" method="post" runat="server" defaultbutton="imgBtnSearch">

    <asp:Panel runat="server" ID="pnlPerm" Visible="false">
        <table style="height: 50;" cellspacing="0" cellpadding="0" width="100%" bgcolor="#990000" border="1"
            bordercolor="red">
            <tr>
                <td>
                    <table style="height: 25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td width="25">
                                <div align="center">
                                    <asp:Image ID="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:Image></div>
                            </td>
                            <td>
                                <asp:Label ID="lblPerm" runat="server" Text="You might not have permission to access sourcing folder using your credentials."
                                    CssClass="fontHead" ForeColor="White"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>

    <asp:Panel runat="server" ID="pnlMain">
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                </td>
                <td>
                    <cc1:bwimagebutton id="btnNew" runat="server" message="NONE"></cc1:bwimagebutton>
                    <cc1:ConfirmedImageButton ID="btnSaveSearch" runat="server" Message="NONE" />
                </td>
            </tr>
        </table>
        <table width="100%" style="border-bottom: orange thin solid;" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
            <tr>
                <td>
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </table>        
        <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
            <tr colspan="2"><td>&nbsp;</td></tr>
            <tr>
                <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
                <td vAlign="top" width="100%">
                    <table height="45">
                        <tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
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
                    <asp:Label ID="RecordCount" runat="server" CssClass="fontHead"></asp:Label>
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
                    <asp:button id="btnGo" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button>
                </td>
            </tr>
        </table>
        <asp:DataGrid ID="dgSourcing" runat="server" EnableViewState="true" AutoGenerateColumns="False" BorderColor="#E0E0E0"
            BorderStyle="Solid" BorderWidth="1px" DataKeyField="SourcingHeaderID" AllowSorting="true">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="False"></PagerStyle>            
        </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
    </asp:Panel>
    </form>
</body>
</html>
