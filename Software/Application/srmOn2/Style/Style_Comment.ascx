<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Comment.ascx.vb" Inherits="srmOnApp.Style_Comment" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<table cellSpacing="0" cellPadding="0" width="100%" border="0" height="25">
	<tr class="TableHeader">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server"></asp:imagebutton></td>
		<td class="fontHead">&nbsp;
			<asp:Label id="lblComment" runat="server">Comments</asp:Label></td>
	</tr>
</table>
<asp:panel id="Panel1" runat="server" BorderWidth="1" CssClass="font" Width="100%"
	BorderColor="DodgerBlue" BorderStyle="Solid" BackColor="#ffffff">
	<asp:datalist id="DataList1" runat="server" BackColor="White" BorderStyle="Solid" BorderColor="WhiteSmoke"
		Width="100%" BorderWidth="1px" DataKeyField="StyleCommentID">
		<HeaderTemplate>
			<table bordercolor="#999999" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr class="ToolbarBlue">
					<td class="font" width="20" height="20">&nbsp;</td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white"><asp:label id="lblAddress" runat="server"><%#GetSystemText("Comments")%></asp:label></td>
					<td class="font" style="FONT-WEIGHT: bold; COLOR: white" width="200"><asp:label id="Label1" runat="server"><%#GetSystemText("Modified By")%></asp:label></td>
				</tr>
			</table>
		</HeaderTemplate>
		<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
		<FooterTemplate>
		</FooterTemplate>
		<ItemStyle BackColor="White"></ItemStyle>
		<ItemTemplate>
			<TABLE width="100%">
				<TR>
					<TD class="font"><%#Container.DataItem("StyleComment")%></TD>
					<TD class="font" width="200"><%#Container.DataItem("MUser")%>&nbsp;<%#Container.DataItem("MDate")%></TD>
				</TR>
			</TABLE>
		</ItemTemplate>
	</asp:datalist>
</asp:panel>
