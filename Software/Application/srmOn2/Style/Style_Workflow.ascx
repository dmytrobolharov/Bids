<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Workflow.ascx.vb" Inherits="srmOnApp.Style_Workflow" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" debug="True" %>
<script language="javascript">
	function calendar(sTxtBoxName)
	{
	windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
	windowDatePicker.focus();
	}
</script> <!--
<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr vAlign="middle">
		<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td vAlign="middle" align="left" width="500"><cc1:confirmedimagebutton id="btnEdit" Message="NONE" ImageUrl="../System/Button/btn_edit.gif" runat="server"></cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="btnSave" runat="server" ImageUrl="../System/Button/btn_save.gif" Message="NONE"></cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="btnAddMaterial" runat="server" ImageUrl="../System/Button/btn_addMaterial.gif"
				Message="NONE"></cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="btnSummary" runat="server" ImageUrl="../System/Button/btn_summary.gif" Message="NONE"></cc1:confirmedimagebutton>
			
			<cc1:confirmedimagebutton id="btnChangeLog" runat="server" ImageUrl="../System/Button/btn_log.gif" Message="NONE"></cc1:confirmedimagebutton></td>
		<td class="FontHead" vAlign="middle" align="center" width="75">Select Set:&nbsp;</td>
		<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
				CssClass="font"></asp:dropdownlist></td>
		<td><asp:imagebutton id="imgBtnGo" ImageUrl="../System/Icons/icon_go.gif" runat="server"></asp:imagebutton></td>
	</tr>
</table>-->

	<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server"  id="tbNav">
		<TR vAlign="middle">
			<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			<td id="tblExpand"  style="width:85"><img runat="server" id="btnExpandAll" alt="" onclick="expandall(1)"  />
            <img id="btnCollapseAll" runat="server" alt="" onclick="expandall(0)" style="display: none" /></td>
			<TD><cc1:bwimagebutton id="btnPrint" runat="server" /></TD>
		</TR>
	</TABLE>

<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td class="fontHead" vAlign="middle"><asp:label id="lblHeader" runat="server"></asp:label>&nbsp;
			<cc1:ConfirmedLinkButton id="hl_Status" runat="server" Message="Are you sure you want to edit status?"></cc1:ConfirmedLinkButton></td>
		<td class="fontHead" vAlign="middle" align="center" width="25"></td>
	</tr>
</table>
