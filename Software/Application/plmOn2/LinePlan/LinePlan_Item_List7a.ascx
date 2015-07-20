<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_List7a.ascx.vb" Inherits="plmOnApp.LinePlan_Item_List7a" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<table cellSpacing="1" cellPadding="0" width="100%" border="0">
	<tr>
		<td vAlign="top" width="100%">
			<table class="ToolbarShort" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR class="fontHead">
					<td align="center" width="10" height="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<TD><b><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;<asp:Label ID="lblRec" runat="server" Text="Records Found"></asp:Label></B></TD>
				</TR>
			</table>
			<asp:datalist id="DataList1" runat="server" DataKeyField="ColorPaletteID" RepeatColumns="8"
				RepeatDirection="Horizontal" EnableViewState="False">
				<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
				<ItemTemplate>
					<TABLE height="100" cellSpacing="0" cellPadding="0" width="65" border="0">
						<TR>
							<TD valign="top" id="tdImageHeight" runat="server" >
								<asp:ImageButton id="imgColorChip" runat="server">
								</asp:ImageButton>
							</TD>
						</TR>
						<TR height="15">
							<TD bgColor="#ffffff">
									<asp:label id="dlColorCode" runat="server"></asp:label></TD>
						</TR>
						<TR height="25">
							<TD bgColor="#ffffff">
									<asp:label id="dlColorName" runat="server"></asp:label></TD>
						</TR>
					</TABLE>
				</ItemTemplate>
			</asp:datalist>
        </tr>
</table>