<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_WorkflowStatus.ascx.vb" Inherits="plmOnApp.Sourcing_WorkflowStatus" %>

<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td align="center" width="10">
            <asp:image id="Image2" height="15" width="3" ImageUrl="../System/Images/bbTbSCnr.gif" runat="server"></asp:image>
        </td>
		<td class="fontHead" width="25">
			<div align="center">
                <asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_ball_gray.gif" runat="server"></asp:image>
            </div>
		</td>
		<td class="fontHead" valign="middle">
            <asp:label id="lblHeader" runat="server"></asp:label>&nbsp;
			<asp:LinkButton id="hl_Status" runat="server" CausesValidation="false"></asp:LinkButton>
        </td>
		<td class="fontHead" valign="middle" align="center" width="25"></td>
	</tr>
</table>
