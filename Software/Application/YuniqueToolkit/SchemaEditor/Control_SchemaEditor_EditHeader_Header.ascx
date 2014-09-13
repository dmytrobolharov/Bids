<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Control_SchemaEditor_EditHeader_Header.ascx.vb" Inherits="YuniFace.Control_SchemaEditor_EditHeader_Header" %>

<table bgcolor="#FFFFFF" width="98%">
    <tr>
        <td align="center">
	        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
	        <asp:Label ID="lblHeader" runat="server">Header</asp:Label></b></font>
        </td>
    </tr>
    <tr valign='top'>
        <td>
            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
</table>
