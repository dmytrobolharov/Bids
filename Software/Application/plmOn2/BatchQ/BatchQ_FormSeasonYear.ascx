<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_FormSeasonYear.ascx.vb" Inherits="plmOnApp.BatchQ_FormSeasonYear" %>
        <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                <td nowrap="nowrap">
                    <asp:Label runat="server" ID="lblSeasonYearLabel" class="fontHead" ></asp:Label>&nbsp;
                    <asp:Label ID="lblStyleSeasonYear" runat="server"></asp:Label>
                </td>
            </tr>
        </table>