<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_BOL_Operations_Link.aspx.vb"
    Inherits="plmOnApp.Style.BOL.Style_BOL_Operations_Link" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<html>
<head>
	<title id="tlLinkFeature" runat="server">Link Feature</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch" >
    <table class="TableHeader" id="TableHeader" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnLink" runat="server" Message="NONE"/>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" />
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tbody>
            <tr>
                <td valign="middle">
                    &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                        ForeColor="#E0E0E0"></asp:Label>
                </td>
            </tr>
        </tbody>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="top">
            <td>
                <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
                    bgcolor="#ffffff" border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td class="fontHead" width="10">
                            &nbsp;
                        </td>
                        <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
            <td class="fontHead" width="10">
                &nbsp;
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
            <td width="125">
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
                    <asp:ListItem Value="50" Selected="true">50</asp:ListItem>
                    <asp:ListItem Value="75">75</asp:ListItem>
                    <asp:ListItem Value="100">100</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td width="10">
                <asp:Button ID="btnRepage" runat="server" CssClass="fontHead"></asp:Button>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td width="100%" valign="top">
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
    <asp:DataGrid ID="DataGrid1" runat="server" Width="100%">
        <PagerStyle Visible="false"></PagerStyle>
    	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeaderRed"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn HeaderStyle-Width="20" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                <HeaderTemplate>
                    <asp:CheckBox runat="server" ID="chkSelectAll" onclick="CheckAll(this);" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="chkSelect"></asp:CheckBox>
                    <input type="hidden" runat="server" id="hdnActive" />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
    </form>

    <script language="javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                    e.checked = actVar;
            }
        }
    </script>

</body>
</html>
