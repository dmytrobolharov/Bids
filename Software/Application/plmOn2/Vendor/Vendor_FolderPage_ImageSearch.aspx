<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_ImageSearch.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_ImageSearch" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Image Folder</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="Form1" method="post" autocomplete="on" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="imgBtnClose" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table id="Table4" style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Folder...</asp:Label>
            </td>
        </tr>
    </table>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td width="100%" valign="top">
                <table id="Table3" height="45">
                    <tr>
                        <td>
                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table id="Table1" cellspacing="1" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top">
                <table class="TableHeader" id="Table2" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr class="fontHead">
                        <td align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td>
                            <div align="left">
                                &nbsp;
                                <asp:Label ID="lblCurrentIndex" Text="0" Visible="False" runat="server"></asp:Label>
                                <asp:Label ID="lblPageSize" Text="20" Visible="False" runat="server"></asp:Label></div>
                        </td>
                        <td width="20">
                            <div align="center">
                                <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:ImageButton></div>
                        </td>
                        <td width="20">
                            <div align="center">
                                <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:ImageButton></div>
                        </td>
                        <td width="150">
                            <div align="center">
                                <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div>
                        </td>
                        <td width="20">
                            <div align="center">
                                <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:ImageButton></div>
                        </td>
                        <td width="20">
                            <div align="center">
                                <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:ImageButton></div>
                        </td>
                        <td>
                            <div align="left">
                                <b>
                                    <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblRecordsFound"
                                        runat="server" CssClass="fontHead">Records Found</asp:Label></b></div>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <asp:DataList ID="DataList1" runat="server" OnItemDataBound="DataList1_ItemDataBound" RepeatDirection="Horizontal"
                    OnItemCommand="DataList1_ItemCommand" RepeatColumns="5" DataKeyField="ImageID" Width="100%">
                    <ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" VerticalAlign="Top"
                        BackColor="White"></ItemStyle>
                    <ItemTemplate>
                        <table bordercolor="silver" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                            <tr>
                                <td>
                                    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr class="fontHead">
                                            <td>
                                                &nbsp;
                                                <asp:CheckBox ID="chkSelect" runat="server" Text='<%#string.Concat(GetSystemText("Select Image") + "...")%>'
                                                    CssClass="fonthead" ToolTip='<%#string.Concat(GetSystemText("click here to select image") + "...")%>'
                                                    Checked="false"></asp:CheckBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="fontHead" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr class="fontHead">
                                            <td>
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:CheckBox ID="cbImageLinked" runat="server" Visible="False" Text='<%#string.Concat("<b>" + GetSystemText("Link Image") + "</b>" + "...")%>'
                                                    CssClass="fontred" ToolTip='<%#string.Concat(GetSystemText("click here to link image") + "...")%>'
                                                    Checked="true"></asp:CheckBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" width="200" bgcolor="#ffffff" height="150">
                                    <cc1:BWImageButton ID="btnImgNewWindow" runat="server" CommandName="Window"></cc1:BWImageButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td class="font">
                                                <asp:Label ID="lblImageCode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageNo") %>'>
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="font">
                                                <asp:Label ID="lbImgDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription") %>'>
                                                </asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:HiddenField ID="hdnImageFileName" Value='<%# Eval("ImageLocation") %>' runat="server" />
                                    <asp:HiddenField ID="hdnImageVersion" Value='<%# Eval("Version") %>' runat="server" />
                                    <asp:HiddenField ID="hdnImageID" Value='<%# Eval("ImageID") %>' runat="server" />
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:DataList>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>