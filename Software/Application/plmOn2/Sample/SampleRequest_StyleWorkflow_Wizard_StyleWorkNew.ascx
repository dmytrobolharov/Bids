<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_StyleWorkflow_Wizard_StyleWorkNew.ascx.vb" Inherits="plmOnApp.SampleRequest_StyleWorkflow_Wizard_StyleWorkNew" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
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
			<TABLE height="310" cellSpacing="1" cellPadding="1" width="900" border="0">
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD vAlign="top">
						<P class="font">&nbsp;</P>
						<P class="font"><asp:Label ID="lblText1" runat="server" ></asp:Label></P>
						<P class="font"><asp:Label ID="lblText2" runat="server" ></asp:Label></P>
						<P class="font">&nbsp;</P>
						<P><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></P>
					</TD>
				</TR>
			</TABLE>
		</td>
	</tr>
</table>
<TABLE style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="center" width="50">&nbsp;</TD>
		<TD align="center" width="500" colSpan="4"><asp:imagebutton id="btnNext" runat="server"></asp:imagebutton></TD>
		<TD align="center"></TD>
	</TR>
</TABLE>
