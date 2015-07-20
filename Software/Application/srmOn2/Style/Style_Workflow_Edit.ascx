<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Workflow_Edit.ascx.vb" Inherits="srmOnApp.Style_Workflow_Edit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" debug="True" %>

<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
<BR>
<cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>
<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
	<tr>
		<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td class="fontHead" width="25">
			<div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_ball_gray.gif" runat="server"></asp:image></div>
		</td>
		<td class="fontHead" valign="middle"><asp:label id="lblHeader" runat="server"></asp:label>&nbsp;
			<asp:LinkButton id="hl_Status" runat="server"></asp:LinkButton></td>
		<td class="fontHead" valign="middle" align="center" width="25"></td>
	</tr>
</table>
