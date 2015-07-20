<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_BreadCrumb.ascx.vb" Inherits="plmOnApp.Planning_Folder_BreadCrumb" %>

<table>
    <tr>
        <td width="120">
            <asp:Label ID="lblBrand" runat="server" Text="Brand" CssClass="fontHead" />
        </td>
        <td width="120">
            <asp:Label ID="lblDivision" runat="server" Text="Division" CssClass="fontHead" />
        </td>
        <td width="120">
            <asp:Label ID="lblStyleType" runat="server" Text="Style Type" CssClass="fontHead" />
        </td>
        <td width="120">
            <asp:Label ID="lblStyleCategory" runat="server" Text="Style Category" CssClass="fontHead" />
        </td>
        <td width="120">
            <asp:Label ID="lblSubCategory" runat="server" Text="Sub Category" CssClass="fontHead" />
        </td>
    </tr>
    <tr>
        <td>
            <asp:DropDownList ID="drlBrandID" runat="server" AutoPostBack="True" Width="120" CssClass="fontHead" />
        </td>
        <td>
            <asp:DropDownList ID="drlDivisionID" runat="server" AutoPostBack="True" Width="120" CssClass="fontHead" />
        </td>
        <td>
            <asp:DropDownList ID="drlStyleTypeID" runat="server" AutoPostBack="True" Width="120" CssClass="fontHead" />
        </td>
        <td>
            <asp:DropDownList ID="drlStyleCategoryID" runat="server" AutoPostBack="True" Width="120" CssClass="fontHead" />
        </td>
        <td>
            <asp:DropDownList ID="drlSubCategoryID" runat="server" AutoPostBack="True" Width="120" CssClass="fontHead" />
        </td>
    </tr>
</table>
