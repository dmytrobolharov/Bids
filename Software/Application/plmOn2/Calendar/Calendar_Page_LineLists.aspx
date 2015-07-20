<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Calendar_Header.ascx" TagName="Calendar_Header" TagPrefix="hc1" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calendar_Page_LineLists.aspx.vb" Inherits="plmOnApp.Calendar_Page_LineLists" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Line List Historical Grid</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:BWImageButton ID="btnLink" runat="server" message="NONE"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" Visible="false" OnClientClick="javascript:Page_ValidationActive = false;">
                </cc1:BWImageButton>
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
    <table class="TableHeader CollapsibleHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="20" valign="bottom">
                <asp:ImageButton ID="imgBtnToggleBOMs" OnClientClick="return toggleSectionVisibility(this);" runat="server"
                    ImageUrl="../System/Icons/icon_Next.gif"></asp:ImageButton>
            </td>
            <td align="left" valign="middle">
                <asp:Label ID="lblCalendar" runat="server"><%= getCalendarHeaderName()%></asp:Label>&nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <div class="Collapsible">
        <hc1:calendar_header id="Calendar_Header" runat="server">
        </hc1:calendar_header>
    </div>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr colspan="2">
            <td>
                &nbsp;
            </td>
        </tr>
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
                            <asp:ImageButton ID="btnImgLast" runat="server" ToolTip="Last"></asp:ImageButton>
                        </td>
                        <td width="10">
                            &nbsp;
                        </td>
                        <td nowrap height="25">
                            <div align="left">
                                <b>
                                    <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;
                                    <asp:Label ID="lblRecordFound" runat="server" />
                                </b>
                            </div>
                        </td>
                        <td width="110" align="right">
                            <asp:Label ID="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:Label>
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
                <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="LineFolderID">
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
                </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
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

        function toggleSectionVisibility(sender) {
            var collapsibleDiv = $(sender).closest(".CollapsibleHeader").nextAll(".Collapsible")[0];
            var hdnCollapsibleStatus = $(sender).siblings("input[id*='hdnIsExpanded']");

            if (collapsibleDiv != null) {
                // Saving status of collapsed section to hidden field
                if ($(collapsibleDiv).is(":visible")) {
                    $(collapsibleDiv).hide();
                    sender.src = '../System/Icons/icon_Next.gif'
                    if ($(hdnCollapsibleStatus)[0] != null) {
                        hdnCollapsibleStatus.val("false");
                    }
                } else {
                    $(collapsibleDiv).show();
                    sender.src = '../System/Icons/icon_Down.gif'
                    if ($(hdnCollapsibleStatus)[0] != null) {
                        hdnCollapsibleStatus.val("true");
                    }
                }
            }

            return false;
        }

        $(".Collapsible").hide();
    </script>
</body>
</html> 