<%@ Control Language="vb" AutoEventWireup="false" Codebehind="BatchQueue_MaterialReplace_HeaderTo.ascx.vb" Inherits="plmOnApp.BatchQueue_MaterialReplace_HeaderTo" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr class="TableHeader">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20">
		    <asp:imagebutton id="imgBtnExpT" OnClientClick="return ShowHeaderContentT(this)" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton>
		    <asp:imagebutton id="imgBtnColT" OnClientClick="return HideHeaderContentT(this)" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton>
		</td>
		<td class="fontHead">
			<asp:label id="lblHeaderDetail" runat="server"></asp:label>
		</td>
	</tr>
</table>
<div id="divHeaderContentT" style="display:none">
		
    <table id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	    <tr>
		    <td width="900">
			    <asp:placeholder id="plhMtHeaderControlsHolderT" runat="server" EnableViewState="False"></asp:placeholder></td>
	    </tr>
    </table>


</div>

