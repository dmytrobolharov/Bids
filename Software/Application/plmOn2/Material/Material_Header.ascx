<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Material_Header.ascx.vb" Inherits="plmOnApp.Material_Header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:Panel ID="pnlVisibilityTrigger" runat="server">
<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr class="TableHeader">
		<td valign="middle" align="center" width="10" style="height:20px;"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" OnClientClick="return ToggleMaterialHeader(true)" ToolTip="Show Material Header..." CausesValidation="false"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" OnClientClick="return ToggleMaterialHeader(false)" ToolTip="Hide Material Header..." CausesValidation="false"></asp:imagebutton></td>
		<td class="fontHead">&nbsp;
			<asp:label id="lblMaterialDetail" runat="server"><%= String.Format("({0}) {1}", strMaterialNo, strMaterialName)%></asp:label>
        </td>
	</tr>
</table>
</asp:Panel>
<div id="material-header">
    <asp:placeholder id="plhMtHeaderControlsHolder" runat="server" EnableViewState="False"></asp:placeholder>
</div>
<script type="text/javascript">
    (function () {
        if ('<%= IsCollapsible %>' == 'False') return;

        var imbBtnExpand = document.getElementById('<%= imbBtnExpand.ClientID %>'),
            imgBtnCollapse = document.getElementById('<%= imgBtnCollapse.ClientID %>'),
            divMaterialHeader = document.getElementById('material-header');

        window.ToggleMaterialHeader = function (show) {
            if (show) {
                divMaterialHeader.style.display = 'block';
                imbBtnExpand.style.display = 'none';
                imgBtnCollapse.style.display = '';
            } else {
                divMaterialHeader.style.display = 'none';
                imbBtnExpand.style.display = '';
                imgBtnCollapse.style.display = 'none';
            }

            return false;
        }

        ToggleMaterialHeader('<%= IsCollapsed %>' == 'False')
    })();
</script>
