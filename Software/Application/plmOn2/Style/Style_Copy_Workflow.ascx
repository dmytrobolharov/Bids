<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Copy_Workflow.ascx.vb" Inherits="plmOnApp.Style_Copy_Workflow" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" debug="True" %>
<script language="javascript">
	function calendar(sTxtBoxName)
	{
	windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
	windowDatePicker.focus();
	}
</script>
<table class="TableHeader" height="25" cellspacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td class="fontHead" width="25">
			<div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_ball_gray.gif" runat="server"></asp:image></div>
		</td>
		<td class="fontHead" vAlign="middle"><asp:label id="lblHeader" runat="server"></asp:label>&nbsp;
			<asp:Label id="lbl_Status" runat="server"></asp:Label></td>
		<td class="fontHead" vAlign="middle" align="center" width="25"></td>
	</tr>
</table>
