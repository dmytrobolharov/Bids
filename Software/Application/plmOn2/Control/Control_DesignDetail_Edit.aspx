<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DesignDetail_Edit.aspx.vb"
    Inherits="plmOnApp.Control_DesignDetail_Edit" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title>Design Template</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
</head>
<body ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" 
                    Message="NONE"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton ID="imgBtnCopy"
                        runat="server"  Message="NONE"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                            ID="btmImgDeletePOM" runat="server" 
                           ></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                                ID="btnClose" runat="server"  Message="NONE">
                            </cc1:ConfirmedImageButton>
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table cellspacing="2" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
        <tr>
            <td width="900">
                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <cc1:confirmedimagebutton id="btnRemoveItems" runat="server" CausesValidation="false"></cc1:confirmedimagebutton>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" width="300">
                <asp:DataGrid ID="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid"
                    BorderWidth="1px">
                <%--<asp:DataGrid ID="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid"
                    BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler"
                    OnItemCommand="DisplayBoundColumnValues" Width="600px">--%>
                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
<%--                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label ID="lblFeatureDetail" runat="server"><%#GetSystemText("Feature Details")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtFeatureDetail" runat="Server" Width="208px" MaxLength="100" Columns="20"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "FeatureDetail")%>'>
                                </asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label ID="lblMeas" runat="server"><%#GetSystemText("Meas")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtMeasurement" runat="Server" Text='<%# DataBinder.Eval(Container.DataItem, "Measurement")%>'
                                    Columns="5" MaxLength="100">
                                </asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label ID="lblStitch" runat="server"><%#GetSystemText("Stitch Type")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="dpStitchType" runat="server" CssClass="font" Width="200px">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label ID="lblComments" runat="server"><%#GetSystemText("Comments")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtComments" runat="Server" MaxLength="300" Columns="80" Text='<%# (DataBinder.Eval(Container.DataItem, "Comments"))%>'>
                                </asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label ID="lblOrder" runat="server"><%#GetSystemText("Order")%></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtSort" runat="Server" Width="50px" MaxLength="3" Text='<%# (DataBinder.Eval(Container.DataItem, "Sort"))%>'>
                                </asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>--%>
                    </Columns>
                </asp:DataGrid>
                <table cellspacing="2" cellpadding="0" border="0">
                    <tr class="fontHead">
                        <td>
                            &nbsp;
                        </td>
                        <td nowrap width="85">
                            <asp:Label ID="lblNofRow" runat="server"></asp:Label>
                        </td>
                        <td width="35">
                            <asp:DropDownList ID="dpNewRow" runat="server" CssClass="fontHead">
                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="15">15</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td width="100">
                            <cc1:ConfirmedImageButton ID="imgBtnAdd" runat="server" 
                                Message="NONE"></cc1:ConfirmedImageButton>
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
            </td>
        </tr>
    </table>
    </form>

    <script language="javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
            }
        }
    </script>

</body>
</html>
