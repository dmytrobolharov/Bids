<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Add_Version.ascx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Add_Version" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE id="Space1" height="5" cellspacing="0" cellPadding="0" width="100%" border="0">
	<TR>
		<TD></TD>
	</TR>
</TABLE>
<TABLE id="TB_Version" borderColor="#cc0000" cellspacing="0" cellPadding="0" width="99%"
	align="center" border="1" runat="server">
	<TR>
		<TD>
			<TABLE id="Table1" cellspacing="1" width="100%" bgColor="white" border="0">
				<TR>
					<TD style="WIDTH: 24px" width="25">&nbsp;<IMG src="../System/Icons/icon_conflict.gif"></TD>
					<TD class="font"><asp:label id="lblNewVersion" align="right"  runat="server">&nbsp;There is an new version available.&nbsp;</asp:label>
						<cc1:ConfirmedLinkButton id="lnkVersionUpdate" runat="server" ForeColor="Blue" CssClass="FontHead">Click here to update.</cc1:ConfirmedLinkButton></TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
</TABLE>
