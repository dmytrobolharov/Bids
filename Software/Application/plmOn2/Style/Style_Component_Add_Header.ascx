<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Add_Header.ascx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Add_Header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<table id="TB_Header" borderColor="gold" cellspacing="0" cellPadding="0" width="100%" border="1"
	runat="server">
	<tr>
		<td>
			<table cellspacing="1" width="100%" bgColor="#ffff99" border="0">
				<tr>
					<td style="WIDTH: 24px" width="25">&nbsp;<IMG src="../System/Icons/icon_info.gif"></td>
					<td class="font"><asp:label id="lblMessage" runat="server">&nbsp;You are about to add this material to style...&nbsp;</asp:label></td>
						<cc1:confirmedlinkbutton id="lnkAddMaterial" runat="server" ForeColor="Blue" CssClass="fontHead">Click here to add to style</cc1:confirmedlinkbutton></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
