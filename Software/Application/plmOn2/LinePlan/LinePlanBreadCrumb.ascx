<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlanBreadCrumb.ascx.vb" Inherits="plmOnApp.LinePlanBreadCrumb" %>

<table>
    <tr>
        <td>
            <asp:DropDownList ID="ddlLinePlanAttribute1" runat="server" AutoPostBack="True" />
            <input id="hiddenLinePlanAttribute1" type="hidden" value="" name="hiddenLinePlanAttribute1" runat="server" />
        </td>
        <td>
            <asp:DropDownList ID="ddlLinePlanAttribute2" runat="server" AutoPostBack="True" />
            <input id="hiddenLinePlanAttribute2" type="hidden" value="" name="hiddenLinePlanAttribute2" runat="server" />
        </td>
        <td>
            <asp:DropDownList ID="ddlLinePlanAttribute3" runat="server" AutoPostBack="True" />
            <input id="hiddenLinePlanAttribute3" type="hidden" value="" name="hiddenLinePlanAttribute3" runat="server" />
        </td>
        <td>
            <asp:DropDownList ID="ddlLinePlanAttribute4" runat="server" AutoPostBack="True" />
            <input id="hiddenLinePlanAttribute4" type="hidden" value="" name="hiddenLinePlanAttribute4" runat="server" />
        </td>
        <td>
            <asp:ImageButton ID="btnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif" />
        </td>
        <td>
        </td>
    </tr>
</table>
