<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Storyboards_Image_Thumb.ascx.vb"
    Inherits="plmOnApp.Planning_Folder_Storyboards_Image_Thumb" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<table class="TableHeader" id="Table2" height="20" cellspacing="0" cellpadding="0"
    width="100%" border="0">
    <tr class="fontHead">
        <td align="center" width="10" height="25">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td width="16">
            <asp:CheckBox ID="cbSelectAll" onclick="CheckAll(this);" AutoPostBack="False" runat="server">
            </asp:CheckBox>
        </td>
        <td class="fontHead" width="100">
            <asp:Label ID="lblSelectAll" runat="server" Text="SelectAll"></asp:Label>
        </td>
        <td height="25">
            <div align="left">
                &nbsp;
                <asp:Label ID="lblCurrentIndex" Text="0" Visible="False" runat="server"></asp:Label><asp:Label
                    ID="lblPageSize" Text="25" Visible="False" runat="server"></asp:Label></div>
        </td>
        <td width="20" height="25">
            <div align="center">
                <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif">
                </asp:ImageButton></div>
        </td>
        <td width="20" height="25">
            <div align="center">
                <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif">
                </asp:ImageButton></div>
        </td>
        <td width="125" height="25">
            <div align="center">
                <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div>
        </td>
        <td width="20" height="25">
            <div align="center">
                <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif">
                </asp:ImageButton></div>
        </td>
        <td width="20" height="25">
            <div align="center">
                <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif">
                </asp:ImageButton></div>
        </td>
        <td height="25">
            <div align="left">
                <b>
                    <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;<asp:Label
                        ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>
                </b>
            </div>
        </td>
        <td height="25">
            <p align="right">
                <asp:DropDownList ID="ddlSortField" runat="server">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlSortBy" runat="server">
                    <asp:ListItem Value="ASC">ASC</asp:ListItem>
                    <asp:ListItem Value="DESC">DESC</asp:ListItem>
                </asp:DropDownList>
                <asp:ImageButton ID="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif">
                </asp:ImageButton></p>
        </td>
    </tr>
</table>
<table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0">
    <tr>
        <td valign="top">
            <asp:DataList ID="Datalist1" runat="server" DataKeyField="ImageID" RepeatColumns="5"
                EnableViewState="False">
                <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
                    VerticalAlign="Top" BackColor="White" Width="100%"></ItemStyle>
                <ItemTemplate>
                    <table id="tbItem" runat="server" bordercolor='#CCCCCC' border="1" cellpadding="0"
                        cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <table class="TableHeader" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <asp:CheckBox runat="server" ID="chkSelect" Text='<%#GetSystemText("Select") %>'
                                                onclick="CheckSelect(this);" CssClass="font" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr height="250">
                            <td>
                                <asp:Image ID="imgDesign" runat="server"></asp:Image>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:PlaceHolder ID="pnlHeader" runat="server"></asp:PlaceHolder>
                            </td>
                        </tr>
                    </table>
                    <input type="hidden" id="ImageVersion" runat="server" /><br />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
            </asp:DataList>
        </td>
    </tr>
</table>
<input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">&nbsp;&nbsp;
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

    function CheckSelect(checkSel) {
        var actVar = document.getElementById("ctrList_cbSelectAll");
        var actVarSel = checkSel.checked;
        if (actVarSel == false) {
            actVar.checked = false;
        }
    }
    function CheckSelectAll() {
        var actVar = document.getElementById("ctrList_cbSelectAll");
        if (actVar != null) {
            actVar.checked = false;
            CheckAll(actVar);
        }

    }
</script>

