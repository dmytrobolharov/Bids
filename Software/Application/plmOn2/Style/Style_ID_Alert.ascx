<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_ID_Alert.ascx.vb" Inherits="plmOnApp.Style_ID_Alert" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR>
		<TD height="5"></TD>
	</TR>
</TABLE>
<table width="100%" border="1" cellspacing="0" cellpadding="0" borderColor="royalblue"
	bgColor="#cddeee" id="tb_StyleIDAlert" runat="server">
	<tr>
		<td><table width="800" border="0" cellspacing="0" cellpadding="0" height="35" id="Table2">
				<tr>
					<td width="10">&nbsp;</td>
					<td width="35" class="fontHead">&nbsp;
						<asp:Image id="imgBlock" runat="server" ImageUrl="../System/Icons/icon_info_32.gif"></asp:Image></td>
					<td class="fontHead">&nbsp;
						<asp:Label id="lblStyleNumberAlert" runat="server" ForeColor="Black" CssClass="fontHead">New Style Number</asp:Label>&nbsp;
						<cc1:ConfirmedLinkButton id="lnk_UpdateStyleNo" runat="server"></cc1:ConfirmedLinkButton></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
