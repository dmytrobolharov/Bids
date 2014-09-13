<!-- 

**************************************************************
XMLFILE: 
LinePlanRangeRollup_Default.xml
**************************************************************

-->


<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Range.ascx.vb" Inherits="plmOnApp.LinePlan_Item_Range" %>

        <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  ShowFooter="False" 
            DataKeyField="LinePlanFinancialID" CellPadding="0" CellSpacing="2" BorderWidth="0" CssClass="fontHead" BackColor="#DFDFDF" ItemStyle-Height="20px">
            <ItemStyle BorderStyle="Solid" BorderWidth="1" BorderColor="Black" BackColor="White"></ItemStyle>
            <HeaderStyle CssClass="fontHead"></HeaderStyle>
            
            <Columns>
                <asp:TemplateColumn>
                    <HeaderTemplate>
                        </td>
                            <td align="center" height="20px">&nbsp;</td>
                            <td runat="server" id="tdDel1" class="TableHeaderBlue" colspan="4" align="center" height="20px">&nbsp;</td>
                        </tr>
                        <td height="18px">&nbsp;</td>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:HiddenField ID="hdDataType" runat="server" />
                        <asp:HiddenField ID="hdDataFormat" runat="server" />
                    </ItemTemplate>
                    <FooterTemplate>
                    <tr>
                         <td height="50" bgcolor="White"></td>   
                         <td colspan="14" bgcolor="White">
                             
                         </td>
                    </tr>  
                    </FooterTemplate>
                </asp:TemplateColumn>
           </Columns> 
        </asp:datagrid> 	
