<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Color_PaletteImage_List_Image.ascx.vb" Inherits="plmOnApp.Color_PaletteImage_List_Image" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<table class="TableHeader" id="Table2" height="20" cellspacing="0" cellpadding="0"
    width="100%" border="0">
    <tr class="fontHead">
        <td align="center" width="10" height="20">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" >
        </td>
        <td width="20">
            <asp:CheckBox ID="cbSelectAll" onclick="CheckAll(this);" AutoPostBack="False" runat="server">
            </asp:CheckBox>
        </td>
        <td class="fontHead" width="100">
            <asp:Label ID="lblSelectAll" runat="server" Text="SelectAll"></asp:Label>
        </td>
        <td width="20" height="20">
            <div align="center">
                <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif">
                </asp:ImageButton></div>
        </td>
        <td width="20" height="20">
            <div align="center">
                <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif">
                </asp:ImageButton></div>
        </td>
        <td width="125" height="20">
            <div align="center">
                <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div>
        </td>
        <td width="20" height="20">
            <div align="center">
                <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif">
                </asp:ImageButton></div>
        </td>
        <td width="20" height="20">
            <div align="center">
                <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif">
                </asp:ImageButton></div>
        </td>
        <td height="20">
            <div align="left">
                <b>
                    <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;<asp:Label
                        ID="lblRecordsFound" runat="server" Visible="false" Text="Records Found"></asp:Label>
                </b>
            </div>
        </td>
        <td height="20">
            <p align="right" style="margin:0px;" >
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
                        cellspacing="0" width="100%" >
                        <tr>
                            <td>
                                <table class="TableHeader" cellpadding="0" cellspacing="0" width="100%" style="width:350px;">
                                    <tr>
                                        <td>
                                            <asp:CheckBox runat="server" ID="chkSelect" Text='<%#GetSystemText("Select") %>'
                                                onclick="CheckSelect(this);" CssClass="font" />
                                            <asp:RadioButton ID="rbSelect" name="rbSelect" runat="server" onclick="javascript:RadioSelect(this.id)" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr >
                            <td style="height:350px; width:350px; " align="center">
                                <asp:Image ID="imgDesign" runat="server" Style=" " ></asp:Image>
                            </td>
                        </tr>
                        <tr>
                            <td style="height:82px; width:350px; ">
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
<asp:HiddenField ID="hdnCurrentIndex" Value="0" runat="server" />
<asp:HiddenField ID="hdnPageSize" Value="25" runat="server" />
<asp:HiddenField ID="hdnRecordCount" runat="server" />
<script type="text/javascript">
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

    function RadioSelect(objID) {
        var rbSelEmp = $(document.getElementById(objID));
        $(rbSelEmp).attr('checked', true);

        var rbUnSelect = rbSelEmp.parents('table').find("input[type='radio']").not(rbSelEmp);
        rbUnSelect.attr('checked', false);
    }
</script>

