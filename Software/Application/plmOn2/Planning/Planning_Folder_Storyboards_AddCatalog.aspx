<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Storyboards_AddCatalog.aspx.vb"
    Inherits="plmOnApp.Planning_Folder_Storyboards_AddCatalog" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Image Catalog Add</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/Custom.js"></script>
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body ms_positioning="GridLayout">
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help"
            target="_blank" id="yHelp"></a>
    </div>
    <form id="form1" method="post" runat="server" defaultbutton="imgBtnSearch">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblImageCatalogHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana">Image Catalog</asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="1" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top">
                <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
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
                            <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
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
                            <asp:Button ID="Button1" OnClick="RePage" runat="server" CssClass="fontHead" Text="GO">
                            </asp:Button>
                        </td>
                    </tr>
                </table>
                <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="false"></asp:PlaceHolder>
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
                <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="ImageCatalogID" BorderStyle="Solid" BorderWidth="1px">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro">
                            <HeaderTemplate>
                                <input type="checkbox" id="checkAll" onclick="SelectAll(this);" />
                            </HeaderTemplate>
                            <ItemStyle Width="20px" CssClass="SelectCheckBox" />
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSelected" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                <input type="hidden" runat="server" id="hiddenCurrentPage" value="0" />
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>    
    </form>
    <script type="text/javascript">
        function SelectAll(chb) {
            $("[name$='chkSelected']:enabled").each(function () { this.checked = chb.checked });
        }
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
