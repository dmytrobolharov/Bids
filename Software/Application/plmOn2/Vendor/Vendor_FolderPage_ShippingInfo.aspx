<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_FolderPage_ShippingInfo.aspx.vb" Inherits="plmOnApp.Vendor_FolderPage_ShippingInfo" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="PartnerAccessType" src="Vendor_FolderPage_PartnerAccessType.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Shipping Info</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/CheckListDropDown.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td width="350">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnTmpSave" runat="server" Message="NONE" Style="display: none;"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnCancel" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
            </td>
            <td><uc1:PartnerAccessType runat="server" id="ctrlPartnerAccessType" /></td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="50">
                            <asp:Label ID="lblTradeName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="50">
                        </td>
                    </tr>
                </table>
                <table id="Table2" cellspacing="2" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>                
                <br />                
            </td>
        </tr>
    </table>    
    <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="TradePartnerShipInfoID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>        
        <Columns>            
            <asp:TemplateColumn>                
                <HeaderTemplate>
                    <asp:CheckBox ID="chbRemoveAll" onclick="checkAll(this, 'chbRemove')" runat="server" />
                </HeaderTemplate>                
                <ItemTemplate>
                    <asp:CheckBox ID="chbRemove" Enabled='<%# Not String.IsNullOrEmpty(Eval("TradePartnerShipInfoID").ToString) %>' runat="server" />
                    <input type="hidden" id="hdnIsChanged" runat="server" value="0" />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <%# GetSystemText("Ship Type") %>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="drlShipType" DataSource='<%# ShipTypeDataSource %>' DataTextField="Custom"
                        DataValueField="CustomID" SelectedValue='<%# Bind("ShipTypeID") %>' AppendDataBoundItems="true" onchange='<%# String.Format("checkForSave(&#39;{0}&#39;)", Container.ClientID) %>'>
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <%# GetSystemText("Ship Mode") %>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="drlShipMode" DataSource='<%# ShipModeDataSource %>' DataTextField="Custom"
                        DataValueField="CustomID" SelectedValue='<%# Bind("ShipModeID") %>' AppendDataBoundItems="true" onchange='<%# String.Format("checkForSave(&#39;{0}&#39;)", Container.ClientID) %>'>
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <%# GetSystemText("Trade Point") %>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:DropDownList runat="server" ID="drlTradePoint" DataSource='<%# TradePointDataSource %>' DataTextField="Custom"
                        DataValueField="CustomID" SelectedValue='<%# Bind("TradePointID") %>' AppendDataBoundItems="true"
                        onchange='<%# String.Format("checkForSave(&#39;{0}&#39;)", Container.ClientID) %>'>
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    </form>

    <script type="text/javascript">
        function checkAll(chb, what) {
            var checked = chb.checked,
            frm = document.forms[0],
            i = frm.length,
            e;

            while (i--) {
                e = frm.elements[i];
                if (e.type === "checkbox" && e.name.indexOf(what) !== -1 && !e.disabled) {
                    e.checked = checked;
                }
            }
        }

        function checkForSave(gridrowid) {
            var $ = function(id) { return document.getElementById(id); };

            var shipType = $(gridrowid + "_drlShipType").selectedIndex,
                shipMode = $(gridrowid + "_drlShipMode").selectedIndex,
                tradePoint = $(gridrowid + "_drlTradePoint").selectedIndex;

            if (shipType > 0 && shipMode > 0 && tradePoint > 0) {
                $(gridrowid + "_hdnIsChanged").value = 1;
                $("<%= btnTmpSave.ClientID %>").click();
            }
        }
    </script>
</body>
</html>
