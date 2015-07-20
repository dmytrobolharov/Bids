<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Material_TradePartnerVendorInfo.ascx.vb" Inherits="plmOnApp.Material_TradePartnerVendorInfo" %>
<table border="0" cellpadding="0" cellspacing="0" width="900">
    <tr>
        <td class="TableHeader" height="25">
            <asp:Label ID="lblAgentHeader" runat="server" Text=""></asp:Label>
        </td>
        <td class="TableHeader" height="25">
            <asp:Label ID="lblVendorHeader" runat="server" Text=""></asp:Label>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td id="tdAgent" runat="server"><span lang="en-us"><asp:placeholder id="plhAgentHeaderControlsHolder" runat="server"></asp:placeholder></span></td>
        <td id="tdVendor" runat="server"><span lang="en-us"><asp:placeholder id="plhVendorHeaderControlsHolder" runat="server"></asp:placeholder></span></td>
        <td><span lang="en-us">&nbsp;</span></td>
    </tr>
</table>