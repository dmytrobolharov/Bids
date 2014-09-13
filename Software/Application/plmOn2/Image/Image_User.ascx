<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Image_User.ascx.vb" Inherits="plmOnApp.Image_User" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TBODY>
		<TR vAlign="middle">
			<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			<TD vAlign="middle" align="left" width="400">
				<cc1:bwimagebutton id="imgWhereEdit"  runat="server" DESIGNTIMEDRAGDROP="8"></cc1:bwimagebutton></TD>
			<TD align="right"></TD>
		</TR>
	</TBODY>
</TABLE>
<asp:datagrid id="DataGrid1" runat="server" DataKeyField="TeamID">
	<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	<HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
	<PagerStyle Visible="False"></PagerStyle>
</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
