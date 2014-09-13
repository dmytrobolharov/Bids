<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Qty.ascx.vb" Inherits="plmOnApp.LinePlan_Item_Qty" %>
    <asp:datagrid id="DataGrid1" runat="server" PageSize="1000" OnItemDataBound="dataGrid1_ItemDataBound"
        DataKeyField="LinePlanFinancialID" ShowFooter="False" CellPadding="0" CellSpacing="2" BorderWidth="0" CssClass="fontHead" BackColor="#DFDFDF">
        <ItemStyle BorderStyle="Solid" BorderWidth="1" BorderColor="Black" 
            BackColor="White" Height="20px"></ItemStyle>
        <HeaderStyle CssClass="fontHead"></HeaderStyle>
        <Columns>
            <asp:TemplateColumn>
	            <HeaderTemplate>
                    </td>
                        <td align="center" height="20px">&nbsp;</td>
                        <td runat="server" id="tdLastYear" class="TableHeaderYellow" align="center" height="20px">
                            <asp:Label ID="lblLastYearH" runat="server" ><%#GetSystemtext("Last Year")%></asp:Label></td>
                        <td runat="server" id="tdPlanning" class="TableHeaderGreen" colspan="4" align="center" height="20px">
                            <asp:Label ID="lblPlanningH" runat="server" ><%#GetSystemText("Planning")%></asp:Label></td>
<%  
    If m_blnLinePlanIsTopDown And LinePlanRollup = "1" Then
%>
                        <td runat="server" id="tdTarget" class="TableHeaderBlue" colspan="4" align="center" height="20px">
                            <asp:Label ID="lblTargetH" runat="server" ><%#GetSystemText("Target")%></asp:Label></td>
<%  
End If
%>
                        <td runat="server" id="tdInProgress" class="TableHeaderRed" colspan="4" align="center" height="20px">
                            <asp:Label ID="lblWIPH" runat="server" ><%#GetSystemText("W I P")%></asp:Label></td>
                        <td runat="server" id="tdActual" class="TableHeaderBlue" colspan="4" align="center" height="20px">
                            <asp:Label ID="lblActualH" runat="server"><%#GetSystemText("Actual")%></asp:Label></td>
                    </tr>
                    <td height="18px">&nbsp;</td>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="hdDataType" runat="server" />
                    <asp:HiddenField ID="hdDataFormat" runat="server" />
                </ItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
            </asp:TemplateColumn>
        </columns> 
    </asp:datagrid>

    