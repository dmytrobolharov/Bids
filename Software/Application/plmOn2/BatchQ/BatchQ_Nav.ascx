<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_Nav.ascx.vb" Inherits="plmOnApp.BatchQ_Nav" %>
 <asp:datalist id="DataList1" runat="server" RepeatDirection="Horizontal"  CellPadding="2" CellSpacing="0" >
    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
    <ItemTemplate>
    
    <table cellspacing="0" cellpadding="0" border="0" runat="server" id="toolbarButton">
        <tr>
            <td>
                <table cellspacing="0" cellpadding="0" border="0" height="40" runat="server" id="tblBatch" bgcolor="White">
                    <tr>
                        <td><asp:Label ID="lblBatch" runat="server" CssClass="fontHead"></asp:Label> </td>
                    </tr>
                </table>    
                             
            </td>
            <td valign="middle" align="center" width="30"><asp:Image ID="imgDiv" runat="server" ImageUrl="" /></td>
        </tr>
    </table> 

    </ItemTemplate>
</asp:datalist>	  

