<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DesignDetail.aspx.vb" Inherits="plmOn2Report.Style_DesignDetail"   enableViewState="False" EnableSessionState="False" buffer="False" Transaction="Disabled" %>
<form id="Form1" method="get" runat="server">
	<TABLE borderColor="#ffffff" height="495" cellSpacing="0" cellPadding="0" width="100%"
		border="1">
		<TR>
			<TD><asp:repeater id="Repeater1" runat="server">
					<ItemTemplate>
						<IMG alt="" src="../System/Images/495X1.jpg" height="495" width="0.5">
						<asp:Image id="imgDesign" runat="server"></asp:Image>
					</ItemTemplate>
				</asp:repeater></TD>
		</TR>
	</TABLE>
</form>
