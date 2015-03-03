<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_Storyboards.aspx.vb"
    Inherits="plmOnApp.Planning_Folder_Storyboards" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui-1.10.3.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help"
            target="_blank" id="yHelp"></a>
    </div>
    <form id="form1" runat="server" method="post">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="middle" align="left">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnAddImage" runat="server" Message="NONE" />
                <cc1:BWImageButton ID="btnUpload" runat="server" Message="NONE" />
                <cc1:BWImageButton ID="btnSort" runat="server" Message="NONE" />
                <cc1:BWImageButton ID="btnPreview" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnBurn" runat="server" Message="Are you sure you want to burn this folder?" />
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnDelete" runat="server" Message="NONE" />
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;">
                </cc1:BWImageButton>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr class="TableHeader">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td width="20">
                <img id="imgBtnExp" onclick="return ShowPlanningHeaderContent(this)" style="cursor: pointer;"
                    src="../System/Icons/icon_Next.gif" alt="" />
                <img id="imgBtnCol" onclick="return HidePlanningHeaderContent(this)" style="cursor: pointer;
                    display: none;" src="../System/Icons/icon_Down.gif" alt="" />
            </td>
            <td class="fontHead">
                <asp:Label ID="lblHeaderDetail" runat="server"><%= CatalogName %></asp:Label>
            </td>
        </tr>
    </table>
    <div id="divHeaderContent" style="display: none;">
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr bgcolor="White">
                <td>
                    <asp:PlaceHolder ID="plhHeader" runat="server" EnableViewState="False"></asp:PlaceHolder>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td>
                &nbsp;
            </td>
            <td>
                <asp:DataList ID="Datalist1" runat="server" Width="100%" GridLines="Both" RepeatDirection="Horizontal" Style="table-layout:fixed;"
                    RepeatColumns="4" BackColor="White" BorderColor="Silver" BorderStyle="Solid"
                    BorderWidth="1px" DataKeyField="ImageCatalogItemID" CssClass="font">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemStyle VerticalAlign="Top"></ItemStyle>
                    <ItemTemplate>
                        <table width="100%">
                            <tr>
                                <td valign="top">
                                    <table width="100%">
                                        <tr>
                                            <td align="left">
                                                <asp:CheckBox ID="chbSelect" runat="server" />
                                            </td>
                                            <td align="left">
                                                <%# ImageVersionChecker(Container.DataItem("ImageID").tostring, Container.DataItem("ImageVersion").tostring) %>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%">
                                        <tr>
                                            <td align="center">
                                                <cc1:BWImageButton ID="imgBtnEdit" runat="server" Message="NONE" CommandName="Link">
                                                </cc1:BWImageButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td class="font">
                                    <asp:Label ID="lbImgDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription") %>'
                                        CssClass="fonthead">
                                    </asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:TextBox ID="txtImageID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ImageID")%>'
                            Visible="False">
                        </asp:TextBox>
                        <asp:TextBox ID="txtImageVersion" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ImageVersion")%>'
                            Visible="False">
                        </asp:TextBox>
                        <asp:TextBox ID="txtImageCatalogItemID" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ImageCatalogItemID")%>'
                            Visible="False">
                        </asp:TextBox>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                </asp:DataList>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" language="javascript">
        function ShowPlanningHeaderContent(obj) {
            obj.style.display = 'none';
            document.getElementById('imgBtnCol').style.display = 'block';
            document.getElementById('divHeaderContent').style.display = 'block';
            return false;
        }

        function HidePlanningHeaderContent(obj) {
            obj.style.display = 'none';
            document.getElementById('imgBtnExp').style.display = 'block';
            document.getElementById('divHeaderContent').style.display = 'none';
            return false;
        }
    </script>
    </form>
    <script type="text/javascript">
        function SelectAll(chb) {
            $("[name$='chbSelect']:enabled").each(function () { this.checked = chb.checked });
        }
    </script>
</body>
</html>
