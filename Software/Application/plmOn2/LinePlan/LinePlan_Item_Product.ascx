<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Product.ascx.vb" Inherits="plmOnApp.LinePlan_Item_Product" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<asp:datalist id="dlStyles" runat="server" DataKeyField="LinePlanItemID" RepeatLayout="Table" RepeatDirection="Horizontal" EnableViewState="false"  
OnItemDataBound="dlStyles_ItemDataBound " CellPadding="0" CellSpacing="0"  >
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
        <tr align="center"  height="200"  ><td><cc1:bwimagebutton id="imgDesign" runat="server" /></td></tr>
        <tr><td><asp:PlaceHolder ID="pnlHeader" runat="server" ></asp:PlaceHolder></td></tr>
   </table>
</ItemTemplate>
<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
</asp:datalist>	