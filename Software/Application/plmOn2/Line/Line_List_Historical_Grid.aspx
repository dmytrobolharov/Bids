<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Line_List_Historical_Grid.aspx.vb" Inherits="plmOnApp.Line_List_Historical_Grid" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Line List Historical Grid</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <wc1:color_wait id="Color_Wait" runat="server" />

    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:BWImageButton ID="btnLink" runat="server" message="NONE"></cc1:BWImageButton>
                <cc1:confirmedimagebutton id="btnRemove" runat="server" message="NONE"></cc1:confirmedimagebutton>
                <cc1:bwimagebutton id="btnChangeLog" runat="server" causesvalidation="false" Visible="true" onclientclick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
            </td>
        </tr>
    </table>   
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"><%= GetSystemText("Historical Line Lists")%></asp:Label>
            </td>
        </tr>
    </table>
    <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr class="TableHeader">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td width="20">
                <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor: pointer" src="../System/Icons/icon_Next.gif" />
                <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor: pointer" src="../System/Icons/icon_Down.gif" />
            </td>
            <td class="fontHead">
                <asp:Label ID="lblHeaderDetail" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div id="divHeaderContent" style="display: none">
        <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td width="900">
                    <asp:PlaceHolder ID="plhHeaderControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
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

        try {
            document.getElementById('imgBtnCol').style.display = 'none';
            function ShowHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnCol').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'block';
                return false;
            }

            function HideHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnExp').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'none';
                return false;
            }
        } catch (e) { }
    </script>
</body>
</html>
