<%@ Control Language="vb" EnableViewState="true" AutoEventWireup="false" CodeBehind="Planning_FlashEdit_Material_StyleDetails.ascx.vb" Inherits="plmOnApp.Planning_FlashEdit_Material_StyleDetails" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<table width="100%">
    <tr>
        <td width="100%">
            <asp:PlaceHolder ID="plhStyleDetailsForm" runat="server"></asp:PlaceHolder>
        </td>
    </tr>
    <asp:HiddenField ID="hdnStyleBOMDimensionId" runat="server" Value="" />
    <asp:HiddenField ID="hdnStyleID" runat="server" Value="" />
    <tr>
        <td width="100%">
            <div id="ColorFrame" style="width:55%; height: 207px; overflow:auto;" runat="server">
                <asp:datalist id="DatalistMaterialImages" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
                    RepeatLayout="Table" ItemStyle-BorderStyle="Solid" ItemStyle-BorderWidth="1"
	                ItemStyle-BorderColor="Gainsboro" ItemStyle-VerticalAlign="Top" 
                    CellSpacing="0" CellPadding="3" DataKeyField="StyleMaterialID">
	                <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" HorizontalAlign="Left"></ItemStyle>
	                <ItemTemplate>
		                <table border="0" cellpadding="0" cellspacing="0" width="110">
			                <tr>
				                <td valign="top" width="110" height="110" runat="server" id="tdImage">
                                    <label style="width:100%; height:100%; display: block;">
			                            <asp:CheckBox runat="server" ID="chbSelectMaterial" />
                                        <asp:HiddenField runat="server" ID="hdnStyleMaterialID" EnableViewState="false"/>
                                    </label>
                                </td>
			                </tr>
			                <tr>
				                <td>
					                <asp:Label id="lblMaterialNo" CssClass="font" runat="server"></asp:Label> &nbsp;
                                </td>
			                </tr>
			                <tr>
				                <td>
					                <asp:Label id="lblMaterialName" CssClass="font" runat="server"></asp:Label>&nbsp;
                                </td>
			                </tr>
                            <tr>
				                <td>
					                <asp:CheckBox ID="chbMainMaterial" CssClass="font" runat="server" Text='<%# GetSystemText("Main Material") %>' />
                                </td>
			                </tr>
		                </table>
	                </ItemTemplate>
                </asp:datalist>
            </div>
        </td>
    </tr>
</table>
