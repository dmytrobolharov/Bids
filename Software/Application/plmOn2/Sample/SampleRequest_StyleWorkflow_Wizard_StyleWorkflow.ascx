<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_StyleWorkflow_Wizard_StyleWorkflow.ascx.vb" Inherits="plmOnApp.SampleRequest_StyleWorkflow_Wizard_StyleWorkflow" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fonthead">&nbsp;<asp:Label ID="lblText" runat="server" ></asp:Label></td>
	</tr>
</table>
<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td>
			<TABLE height="300" cellSpacing="1" cellPadding="1" width="900" border="0">
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD vAlign="top"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
				</TR>
			</TABLE>
		</td>
	</tr>
</table>
<TABLE style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="center" width="50">&nbsp;</TD>
		<TD align="center" width="500">
			<asp:imagebutton id="btnSave"  runat="server"></asp:imagebutton>
			<cc1:ConfirmedImageButton id="btnDelete"  runat="server" Message="Are you sure you want to delete this template?"></cc1:ConfirmedImageButton>
			<asp:imagebutton id="btnNext"  runat="server"></asp:imagebutton>
		</TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
