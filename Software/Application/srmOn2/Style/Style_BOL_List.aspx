<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_BOL_List.aspx.vb"
    Inherits="srmOnApp.Style_BOL_List" %>

<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<%--<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>BOL</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
       <script language="javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <uc1:Style_Workflow ID="Style_Workflow1" runat="server"></uc1:Style_Workflow>
    <asp:Panel ID="pnlChange" runat="server">
        <uc1:Style_Change_Alert ID="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
    </asp:Panel>
    <uc2:Style_Header ID="Style_Header1" runat="server"></uc2:Style_Header>
    <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td height="20">
                <uc1:Style_Comment ID="Style_Comment1" runat="server"></uc1:Style_Comment>
            </td>
        </tr>
    </table>
    <%--<uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />--%>
    <br />
    <cc2:YSTabView ID="YSTabView" runat="server"></cc2:YSTabView>
    <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="False" DataKeyField="PageOperationId">
        <%--<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>--%>
        <%--<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>--%>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn ItemStyle-BorderWidth="1">
                <ItemStyle Width="75" />
                <ItemTemplate>
                    <table cellspacing="0" cellpadding="0" width="75" border="0">
                        <tr>
                            <td>
                                <table cellspacing="0" cellpadding="0" width="25" border="0">
                                    <tr>
                                        <td>
                                            <asp:Image ID="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif"
                                                Visible='<%# DisplayLinkedVisible(Container.DataItem("isLinked")) %>' ToolTip='<%#GetSystemText("Construction Linked") & "..." %>'>
                                            </asp:Image>
                                        </td>
                                    </tr>
                                </table>
                                <table cellspacing="0" cellpadding="0" width="25" border="0">
                                    <tr>
                                        <td style="height:50px;vertical-align:top">
                                        <div style="position:absolute;">
                                            <cc1:BWImageButton ID="imgConstructionDetail" runat="server"></cc1:BWImageButton></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BorderWidth="1">
                <HeaderStyle Width="30px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" ID="lblMacro" Text='<%#GetSystemText("Macro") %>' />
                </HeaderTemplate>
                <ItemStyle Width="30px" HorizontalAlign="Center"></ItemStyle>
                <ItemTemplate>
                    <asp:Image runat="server" ID="imgIsMacro" ImageUrl="../System/Icons/tv_plusdotsbt.gif" />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <asp:DataGrid ID="DataGrid2" runat="server" AllowSorting="False" DataKeyField="PageOperationId">
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn ItemStyle-BorderWidth="1">
                <ItemStyle Width="75" />
                <ItemTemplate>
                    <table cellspacing="0" cellpadding="0" width="75" border="0">
                        <tr>
                            <td>
                                <table cellspacing="0" cellpadding="0" width="25" border="0">
                                    <tr>
                                        <td>
                                            <asp:Image ID="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif"
                                                Visible='<%# DisplayLinkedVisible(Container.DataItem("isLinked")) %>' ToolTip='<%#GetSystemText("Construction Linked") & "..." %>'>
                                            </asp:Image>
                                        </td>
                                    </tr>
                                </table>
                                <table cellspacing="0" cellpadding="0" width="25" border="0">
                                    <tr>
                                        <td style="height:50px;vertical-align:top">
                                        <div style="position:absolute;">
                                            <cc1:BWImageButton ID="imgConstructionDetail" runat="server"></cc1:BWImageButton></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn ItemStyle-BorderWidth="1">
                <HeaderStyle Width="30px" CssClass="TableHeader"></HeaderStyle>
                <HeaderTemplate>
                    <asp:Label runat="server" ID="lblMacro" Text='<%#GetSystemText("Macro") %>' />
                </HeaderTemplate>
                <ItemStyle Width="30px" HorizontalAlign="Center"></ItemStyle>
                <ItemTemplate>
                    <asp:Image runat="server" ID="imgIsMacro" ImageUrl="../System/Icons/tv_plusdotsbt.gif" />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <br />
    <table cellspacing="2" cellpadding="0" width="20%" border="0" align="center" style="background-color: #AABBCC"
        id="tblTTime" runat="server">
        <tr>
            <td class="fontHead" align="center">
                <asp:DataGrid ID="DataGridTTime" Width="100%" runat="server" ShowHeader="false" AllowSorting="False" DataKeyField="BaseRateId" BorderStyle="Solid" BorderColor="Silver" AutoGenerateColumns="false" HeaderStyle-Height="0">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                <ItemStyle Height="20px" Wrap="false" CssClass="ItemTemplate"></ItemStyle>
                    <Columns>
                        <asp:BoundColumn DataField="RateCode" ItemStyle-BorderStyle="Solid" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
                        <asp:BoundColumn DataField="TotalTime" ItemStyle-BorderStyle="Solid" ItemStyle-HorizontalAlign="Right"></asp:BoundColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    <br />
    <table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_left.gif" />
            </td>
            <td class="TableBar" valign="middle" align="center" width="20">
                <img src="../System/icons/icon_changeobject.gif">
            </td>
            <td class="TableBar">
                <asp:Label ID="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
                <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_right.gif" />
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript" language="javascript">
        function getElementsByNameIE(tag, name) {

            var elem = document.getElementsByTagName(tag);
            var arr = new Array();
            for (i = 0, iarr = 0; i < elem.length; i++) {
                att = elem[i].getAttribute("name");
                if (att == name) {
                    arr[iarr] = elem[i];
                    iarr++;
                }
            }
            return arr;
        }

        function hideUnhide(MacroParentId, id) {
            var h = getElementsByNameIE("tr", "hide_" + MacroParentId)
            for (var i = 0; i < h.length; i++) {
                if (h[i].style.display == 'none') {
                    h[i].style.display = ''
                    document.getElementById(id).src = '../System/Icons/tv_minusdotst.gif'
                }
                else {
                    if (h[i].style.display == '') h[i].style.display = 'none'
                    document.getElementById(id).src = '../System/Icons/tv_plusdotsbt.gif'
                }
            }
        }
    </script>

</body>
</html>
