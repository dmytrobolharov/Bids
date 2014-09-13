<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Storyboards_Image_List.ascx.vb"
    Inherits="plmOnApp.Planning_Folder_Storyboards_Image_List" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr valign="top">
        <td>
            <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
                bgcolor="#ffffff" border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="16">
                        <asp:CheckBox ID="cbSelectAll" OnClick="CheckAll(this);" AutoPostBack="False" runat="server">
                        </asp:CheckBox>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblSelectAll" runat="server" Text="SelectAll"></asp:Label>
                    </td>
                    <td width="16">
                        <asp:CheckBox ID="cbThumbnail" AutoPostBack="True" runat="server"></asp:CheckBox>
                    </td>
                    <td class="fontHead" width="100">
                        <asp:Label ID="lblThumbnail" runat="server" Text="Thumbnail?"></asp:Label>
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
                        <asp:Label ID="lblRecordsPerPage" runat="server" Text="Records per Page"></asp:Label>:
                    </td>
                    <td width="25">
                        <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                            <asp:ListItem Value="0">All</asp:ListItem>
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
            <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="ImageID" AllowSorting="True"
                AutoGenerateColumns="False">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                <PagerStyle Visible="False"></PagerStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%#GetSystemText("Select")%>'></asp:Label></HeaderTemplate>
                        <ItemTemplate>
                            <div align="center">
                                <input type="checkbox" id="chkSelect" name="chkSelect" runat="server" onclick="CheckSelect(this);" /><input
                                    type="hidden" id="ImageVersion" runat="server" /></div>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#GetSystemText("Image") %>'></asp:Label></HeaderTemplate>
                        <ItemTemplate>
                            <cc2:BWImageButton ID="imgDesign" runat="server"></cc2:BWImageButton></ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
        </td>
    </tr>
</table>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server" />
<input id="hiddenSortOrder" type="hidden" value="" name="hiddenSortOrder" runat="server" />

<script language="javascript">
    function CheckAll(checkAllBox) {
        var frm = document.Form1;
        var actVar = checkAllBox.checked;
        for (i = 0; i < frm.length; i++) {
            e = frm.elements[i];
            if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                e.checked = actVar;
        }
    }
    
    function CheckSelect(checkSel) {
        var actVar = document.getElementById("ctrGrid_cbSelectAll");
        var actVarSel = checkSel.checked;
        if (actVarSel == false) {
            actVar.checked = false;
        }
    }

    function CheckSelectAll() {
        var actVar = document.getElementById("ctrGrid_cbSelectAll");
        if (actVar != null) {
            actVar.checked = false;
            CheckAll(actVar);
        }

    }
</script>

