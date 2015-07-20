<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Image_Header.ascx.vb" Inherits="plmOnApp.Image_Header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<asp:Panel ID="pnlVisibilityTrigger" runat="server">
<table cellspacing="0" cellpadding="0" width="100%" border="0">
	<tr class="TableHeader">
		<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" OnClientClick="return ToggleMaterialHeader(true)" ToolTip="Show Material Header..." CausesValidation="false"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" OnClientClick="return ToggleMaterialHeader(false)" ToolTip="Hide Material Header..." CausesValidation="false"></asp:imagebutton></td>
		<td class="fontHead">&nbsp;
			<asp:label id="lblMaterialDetail" runat="server"><%= String.Format("{0} - {1}", strImageNo, strImageName)%></asp:label>
        </td>
	</tr>
</table>
</asp:Panel>
<asp:Panel ID="pnlImage" runat="server">
    <br />
    <table height="100" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="top">
            <td width="10">
                &nbsp;
            </td>
            <td>
                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
    </table>
    <br />
</asp:Panel>
<script type="text/javascript">
    (function () {
        if ('<%= IsCollapsible %>' == 'False') return;

        var imbBtnExpand = document.getElementById('<%= imbBtnExpand.ClientID %>'),
            imgBtnCollapse = document.getElementById('<%= imgBtnCollapse.ClientID %>'),
            divHeader = document.getElementById('<%= pnlImage.ClientID %>');

        window.ToggleMaterialHeader = function (show) {
            if (show) {
                divHeader.style.display = 'block';
                imbBtnExpand.style.display = 'none';
                imgBtnCollapse.style.display = '';
            } else {
                divHeader.style.display = 'none';
                imbBtnExpand.style.display = '';
                imgBtnCollapse.style.display = 'none';
            }

            return false;
        }

        ToggleMaterialHeader('<%= IsCollapsed %>' == 'False')
    })();
</script>