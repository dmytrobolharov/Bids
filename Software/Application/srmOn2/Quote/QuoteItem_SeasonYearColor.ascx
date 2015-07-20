<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QuoteItem_SeasonYearColor.ascx.vb" Inherits="srmOnApp.QuoteItem_SeasonYearColor" %>
<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="30"
    border="0">
    <tr valign="middle">
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
        </td>
        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
        <td width="100" nowrap="nowrap">
            <asp:Label ID="lblSeasonYearName" runat="server"></asp:Label>
        </td>
        <td with="25">&nbsp;</td>
        <td width="20"><asp:Image ID="imgColorName" runat="server" ImageUrl="../System/Icons/icon_colorway.gif" /></td>
        <td nowrap="nowrap">
            <asp:Label ID="lblColorName" runat="server"></asp:Label>          
        </td>
    </tr>
</table>	
