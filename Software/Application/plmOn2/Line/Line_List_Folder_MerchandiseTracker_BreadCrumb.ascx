<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Line_List_Folder_MerchandiseTracker_BreadCrumb.ascx.vb" Inherits="plmOnApp.Line_List_Folder_MerchandiseTracker_BreadCrumb" %>

<table>
    <tr>
        <td>
            <asp:DropDownList ID="drlDivisionID" runat="server" AutoPostBack="True" CssClass="fontHead" />
        </td>
        <td>
            <asp:DropDownList ID="drlStyleTypeID" runat="server" AutoPostBack="True" Width="100" CssClass="fontHead" />
        </td>
        <td>
            <asp:DropDownList ID="drlStyleCategoryID" runat="server" AutoPostBack="True" Width="100" CssClass="fontHead" />
        </td>
    </tr>
</table>
