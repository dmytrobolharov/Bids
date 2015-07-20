<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Compliance_SelectedAgents.ascx.vb"
    Inherits="plmOnApp.Compliance_SelectedAgents" %>
    
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>    
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

		
<%--<table cellspacing="0" cellpadding="0" width="100%" border="0" height="25">
    <tr class="TableHeader">
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td width="20">
            <asp:ImageButton ID="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"
                CausesValidation="False"></asp:ImageButton><asp:ImageButton ID="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif"
                    runat="server" CausesValidation="False"></asp:ImageButton>
        </td>
        <td class="fontHead" width="150">
            &nbsp;
            <asp:Label ID="lblComment" runat="server"></asp:Label>
        </td>
         <td class="fontHead">
            <cc1:ConfirmedImageButton ID="btnUnshare" runat="server" ToolTip="UnShare File with Agent" Message="Are you sure you want to UnShare this File with selected Agent?"></cc1:ConfirmedImageButton>
        </td>
    </tr>
</table>--%>

<input type="hidden" id="hdnTab" name="hdnTab" />
<cc2:YSTabView ID="YSTabView1" runat="server" />

<asp:Panel ID="pnlSharedAgent" runat="server">

    <table cellspacing="0" cellpadding="0" width="100%" border="0" height="25">
         <tr>
            <td style="height:3px;"></td>
        </tr>   
        <tr class="TableHeader">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
             <td class="fontHead">
                <cc1:ConfirmedImageButton ID="btnUnshare" runat="server"></cc1:ConfirmedImageButton>
            </td>
        </tr>
    </table>    
    <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
        <tr>
            <asp:DataGrid ID="DataGrid1" runat="server" Width="100%" BorderStyle="None" BorderColor="WhiteSmoke"
                BackColor="White" PageSize="500" AllowSorting="False" DataKeyField="TradePartnerID">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                <PagerStyle Visible="False"></PagerStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkSelectAllAgent"  runat="server" onclick="CheckAll(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkSelect" ToolTip="UnShare File with Agent" />
                            <asp:HiddenField ID="hdnTradePartnerRelationshipLevelID" runat="server" />
                            <asp:HiddenField ID="hdnTradePartnerIDChain" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
        </tr>
    </table>
</asp:Panel>

<asp:Panel ID="pnlLog" runat="server">
    <table cellspacing="1" cellpadding="1" width="100%" bgcolor="whitesmoke" border="0">
        <tr>
            <asp:DataGrid ID="DataGrid2" runat="server" Width="100%" BorderStyle="None" BorderColor="WhiteSmoke"
                BackColor="White" PageSize="500" AllowSorting="False" DataKeyField="ResourceLogID">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                <PagerStyle Visible="False"></PagerStyle>

            </asp:DataGrid>
            <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
        </tr>
    </table>
</asp:Panel>
<br />
<hr />
