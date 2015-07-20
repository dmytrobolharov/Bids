<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_FlashEdit_Color_StyleDetails.ascx.vb" Inherits="plmOnApp.Planning_FlashEdit_Color_StyleDetails" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<table width="100%">
    <tr>
        <td width="100%">
            <asp:PlaceHolder ID="plhStyleDetailsForm" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
    <asp:HiddenField ID="hdnStyleBOMDimensionId" runat="server" Value="" />
    <tr>
        <td width="100%">
            <div id="ColorFrame" style="height: 157px; overflow-x:auto;" runat="server">
                <asp:datalist id="DatalistColorwayImages" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
                    RepeatLayout="Table" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1"
	                ItemStyle-BorderColor="Gainsboro" ItemStyle-VerticalAlign="Top" 
                    CellSpacing="0" CellPadding="3" DataKeyField="StyleColorID">
	                <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" HorizontalAlign="Left"></ItemStyle>
	                <ItemTemplate>
		                <table border="0" cellpadding="0" cellspacing="0" width="80">
			                <tr>
				                <td valign="top" width="80" height="80" runat="server" id="tdImage">
                                    <label style="width:100%; height:100%; display:block;">
			                            <asp:CheckBox runat="server" ID="chbSelectColorway" />
                                        <asp:HiddenField runat="server" ID="hdnColorPaletteID" EnableViewState="false"/>
                                        <asp:HiddenField runat="server" ID="hdnStyleColorID" EnableViewState="false"/>
                                    </label>
                                </td>
			                </tr>
			                <tr>
				                <td>
					                <asp:Label id="lblColorNo" runat="server"></asp:Label>
                                </td>
			                </tr>
			                <tr>
				                <td>
					                <asp:Label id="lblColorName" runat="server"></asp:Label>
                                </td>
			                </tr>
		                </table>
	                </ItemTemplate>
                </asp:datalist>
            </div>
        </td>
    </tr>
</table>
