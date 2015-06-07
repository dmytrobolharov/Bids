<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_Style_List_View.ascx.vb"
    Inherits="plmOnApp.Sourcing_Page_Style_List_View" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<script type="text/javascript">

    var frm = document.forms['form1'];
    function selectAll(checkAllBox) {
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("chbSelect") != -1 && e.disabled == false)
                e.checked = actVar;
        }
    }

    function RadGridRowClick(sender, eventArgs) {
        window.open('../Style/Style_Redirect.aspx?SID=' + eventArgs.getDataKeyValue("StyleID") + '&SYID=' + eventArgs.getDataKeyValue("SeasonYearID"));
    }

</script>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr valign="top">
        <td>
            <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
                bgcolor="#ffffff" border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                    </td>
                    <td width="16">
                        <asp:CheckBox ID="cbThumbnail" AutoPostBack="true" runat="server"></asp:CheckBox>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblThumbnail" runat="server"></asp:Label>
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
                        <asp:Label ID="lblRecordCount" runat="server" CssClass="font"></asp:Label>
                        <asp:HiddenField ID="hdnRecordCount" runat="server" Value='' />
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
                            <asp:ListItem Value="50" Selected="true">50</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td width="10">
                        <asp:Button ID="btnGo" OnClick="RePage" runat="server" CssClass="fontHead"></asp:Button>
                    </td>
                </tr>
            </table>
            <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="StyleID" EnableViewState="False"
                AllowSorting="true" AllowPaging="false">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                <PagerStyle Visible="False"></PagerStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkSelectAll" runat="server" onclick="selectAll(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chbSelect" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <%# GetSystemText("Image")%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Image ID="imgDesignSketchID" runat="server" ImageUrl='<%# GetImageStreamPath(50, Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
        </td>
    </tr>
</table>
<table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0">
    <tr>
        <td valign="top">
            <asp:PlaceHolder ID="plhStylesGrid" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
</table>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" />&nbsp;&nbsp;
