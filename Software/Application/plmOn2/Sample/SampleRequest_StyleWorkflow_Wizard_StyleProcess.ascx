<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_StyleWorkflow_Wizard_StyleProcess.ascx.vb" Inherits="plmOnApp.SampleRequest_StyleWorkflow_Wizard_StyleProcess" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fonthead">&nbsp;<asp:Label ID="lblText" runat="server" ></asp:Label>
			</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<TABLE width="100%" align="center" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0">
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD class="fonthead" align="center" width="150"><asp:Label ID="lblStyleSetH" runat="server" ></asp:Label></TD>
					<TD align="center" width="20"></TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								<asp:Label ID="lblMilestoneAvailable" runat="server" ></asp:Label></B></FONT></TD>
					<TD width="50"></TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								<asp:Label ID="lblMilestoneSelected" runat="server" ></asp:Label> </B></FONT>
					</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD align="center" width="150">
						<asp:listbox id="lstStyleSet" Height="250px" Width="150px" CssClass="fonthead" Runat="server"
							AutoPostBack="True"></asp:listbox></TD>
					<TD align="center" width="20">&nbsp;</TD>
					<TD align="center" width="200">
						<asp:listbox id="lstSelect" runat="server" CssClass="fonthead" Width="200px" Height="250px" SelectionMode="Multiple"
							BorderStyle="Outset"></asp:listbox></TD>
					<TD align="center" width="50">
						<asp:imagebutton id="btnaddall" runat="server"></asp:imagebutton>
						<BR>
						<asp:imagebutton id="btnadditem"  runat="server"></asp:imagebutton>
						<BR>
						<asp:imagebutton id="btnremoveitem"  runat="server"></asp:imagebutton>
						<BR>
						<asp:imagebutton id="btnremoveall" runat="server"></asp:imagebutton>
						<BR>
					</TD>
					<TD align="center" width="200">
						<asp:ListBox id="lstSelected" CssClass="fonthead" Width="200px" Height="250px" SelectionMode="Multiple"
							Runat="server"></asp:ListBox></TD>
					<TD align="center" width="50">
						<asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton>
						<BR>
						<asp:imagebutton id="btnColmovedwn" Runat="server"></asp:imagebutton>
					</TD>
					<TD>&nbsp;</TD>
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
			<asp:ImageButton id="btnBack"  runat="server"></asp:ImageButton>
			<asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton>
			<asp:ImageButton id="btnNext"  runat="server"></asp:ImageButton>
		</TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
