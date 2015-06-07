<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_BreadCrumb_Multi.ascx.vb" Inherits="plmOnApp.Planning_Folder_BreadCrumb_Multi" %>

<table>
    <tr>
        <td>
            <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder>
        </td>
        <td>
            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
        </td>
        <td>
            &nbsp;<asp:Label ID="lblRecordCount" runat="server" CssClass="fontHead" style="color: Red;" Visible="false"></asp:Label>&nbsp;
            <asp:Label ID="lblRecordCountText" runat="server" CssClass="fontHead" Visible="false"></asp:Label>
        </td>
    </tr>
</table>
