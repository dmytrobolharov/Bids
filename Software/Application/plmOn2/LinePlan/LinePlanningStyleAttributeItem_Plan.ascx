﻿<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="LinePlanningStyleAttributeItem_Plan.ascx.vb" Inherits="plmOnApp.LinePlanningStyleAttributeItem_Plan" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR vAlign="top">
		<TD>
			<asp:datagrid id="DataGrid1" runat="server" DataKeyField="LinePlanStyleAttributeItemID">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
	</TR>
</TABLE>