<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_FabricGrid.ascx.vb" Inherits="plmOnApp.Style.Measurements.Style_FabricGrid" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr class="TableHeader">
		<td valign="middle" align="center" width="10px"><img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20px">
		    <img id="imgBtnExp" runat="server" onclick="return toggleFabricGrid(this, true)" style="cursor:pointer;" src="../System/Icons/icon_Next.gif" alt="" />
		    <img id="imgBtnCol" runat="server" onclick="return toggleFabricGrid(this, false)" style="cursor:pointer; display:none;" src="../System/Icons/icon_Down.gif" alt="" />
		</td>
		<td class="fontHead">
			<asp:label id="lblFabricGrid" runat="server"></asp:label>
		</td>
	</tr>
</table>
<div id="fabricGridContent" style="display:none;">
    <asp:DataGrid ID="FabricGrid" runat="server" AutoGenerateColumns="false" DataKeyField="CADModel2BOMId">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderStyle BorderWidth="1pt" BorderColor="Gainsboro" />
                <HeaderTemplate>
                    <asp:CheckBox ID="chbUnlinkAll" onclick="checkAllFabrics(this)" runat="server" />
                </HeaderTemplate>
                <ItemStyle CssClass="SelectCheckbox" BorderWidth="1pt" BorderColor="Gainsboro" />
                <ItemTemplate>
                    <asp:CheckBox ID="chbUnlink" runat="server" />
                    <asp:HiddenField ID="hdnModelName" runat="server" Value='<%# Container.DataItem("ModelName") %>' />
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:BoundColumn DataField="ModelName" ItemStyle-Width="100px" ItemStyle-BorderWidth="1px" ItemStyle-BorderColor="Gainsboro" ItemStyle-BorderStyle="solid"></asp:BoundColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <%#GetSystemText("Fabric Type")%>
                </HeaderTemplate>
                <ItemStyle BorderWidth="1px" BorderColor="Gainsboro" BorderStyle="Solid" />
                <ItemTemplate>
                    <asp:DropDownList ID="selFabricType" runat="server"></asp:DropDownList>
                    <asp:HiddenField ID="hdnFabricType" runat="server" />       
                    <asp:HiddenField ID="hdnFabricTypeName" runat="server" />          
                </ItemTemplate>                    
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <%#GetSystemText("Material Code")%>
                </HeaderTemplate>
                <ItemStyle BorderWidth="1px" BorderColor="Gainsboro" BorderStyle="Solid" />
                <ItemTemplate>
                    <asp:DropDownList ID="selMaterial" runat="server"></asp:DropDownList>
                    <asp:HiddenField ID="hdnMaterial" runat="server" />
                    <asp:HiddenField ID="hdnMaterialName" runat="server" />
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid> 
    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />
    <cc1:ConfirmedImageButton ID="btnUnlink" runat="server" Message="NONE" />
    <input type="hidden" ID="MatGridIsExpanded" value='<%= _MatGridIsExpanded %>' runat="server" />
</div>
<script type="text/javascript">
    function checkAllFabrics(chb) {
        var checked = chb.checked,
            frm = document.forms[0],
            i = frm.length,
            e;

        while (i--) {
            e = frm.elements[i];
            if (e.type === "checkbox" && e.name.indexOf("chbUnlink") !== -1 && e.name.indexOf("FabricGrid") !== -1 && !e.disabled) {                
                e.checked = checked;
            }
        }
    }

    (function(window) {
        // fix for ie6, other browsers don't allow selecting disabled options
        var selected = {};
        window.saveSelectedIndex = function(sel) {
            selected[sel.id] = sel.selectedIndex;
        };

        window.checkForDisabled = function(sel) {
            if (sel.options[sel.selectedIndex].disabled) {
                sel.selectedIndex = selected[sel.id];
                return false;
            }
            
            selected[sel.id] = sel.selectedIndex;

            return true;
        };
    })(window)
</script>
