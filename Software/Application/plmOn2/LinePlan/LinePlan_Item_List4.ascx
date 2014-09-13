<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_List4.ascx.vb" Inherits="plmOnApp.LinePlan_Item_List4" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<asp:datalist id="dlStyles" runat="server" DataKeyField="LinePlanItemID" 
    RepeatLayout="Table" RepeatDirection="Horizontal" EnableViewState="false"  
    OnItemDataBound="dlStyles_ItemDataBound " CellPadding="0" CellSpacing="0" 
    RepeatColumns="5"  >
<ItemStyle VerticalAlign="top" />
<AlternatingItemStyle VerticalAlign="top"   />
<ItemTemplate>
    <table id="tbItem" runat="server" bordercolor='#CCCCCC'  border="1"  cellpadding="0" cellspacing="0" >
        <tr>
           <td ><table  class="TableHeader"  width ="100%" >
                <tr><td><cc1:bwimagebutton id="btnEditItem" runat="server"  /></td></tr>
                </table>
           </td>
         </tr>
        <tr align="center"  height="100"  ><td><cc1:bwimagebutton id="imgDesign" runat="server" /></td></tr>
        <tr><td><asp:PlaceHolder ID="pnlHeader" runat="server" ></asp:PlaceHolder></td></tr>
        <tr><td align="center"><asp:datalist id="dlColors" runat="server" DataKeyField="StyleColorID" Width="100%"
                    ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1"	ItemStyle-BorderColor="Gainsboro"
                    RepeatLayout="Table" RepeatDirection="Horizontal" EnableViewState="false"  
                    CellPadding="0" CellSpacing="0" RepeatColumns="5" OnItemDataBound="dlColors_ItemDataBound">
                        <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                   		    <TABLE >
	                            <TR><TD valign="top" align="center"><asp:Image id="imgLineImage" runat="server">
	                            </asp:Image></TD></TR>
	                            <TR><TD><asp:Label id="lblColorNo" runat="server" Text ='<%# DataBinder.Eval(Container.DataItem, "StyleColorNo")%>'></asp:Label></TD></TR>
	                            <TR><TD><asp:Label id="lblColorName" runat="server" Text ='<%# DataBinder.Eval(Container.DataItem, "StyleColorName")%>'></asp:Label></TD></TR>
                            </TABLE>
                        </ItemTemplate>
                    </asp:datalist>
        </td></tr>
        
   </table>
</ItemTemplate>
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
</asp:datalist>	