<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Sample_Material.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Sample_Material" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fonthead">&nbsp;<FONT color="darkgray" size="3"><asp:Label ID="lblHeader"
            runat="server" ></asp:Label></FONT></td>
	</tr>
</table>
<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="800"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
		<td></td>
	</tr>
</table>
<BR>
<table id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td>
			<TABLE id="Table3" cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff"
				border="0">
				<TR>
					<TD style="HEIGHT: 19px" align="center" width="20">&nbsp;</TD>
					<TD class="fonthead" style="HEIGHT: 19px" align="center" width="150">
                        <asp:Label ID="lblProcess" runat="server" ></asp:Label></TD>
					<TD style="HEIGHT: 19px" align="center" width="20">&nbsp;</TD>
					<TD style="HEIGHT: 19px" align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
                        <asp:Label ID="lblSubmit" runat="server"></asp:Label></B></FONT></TD>
					<TD style="HEIGHT: 19px" width="50"></TD>
					<TD style="HEIGHT: 19px" align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
                        <asp:Label ID="lblSubmitSelected" runat="server" ></asp:Label>
							</B></FONT>
					</TD>
					<TD style="HEIGHT: 19px">&nbsp;</TD>
					<TD style="HEIGHT: 19px">&nbsp;</TD>
				</TR>
				<TR>
					<TD align="center" width="20">&nbsp;</TD>
					<TD align="center" width="150"><asp:listbox id="lstWorkflow" Height="250px" Width="150px" CssClass="fonthead" Runat="server"
							AutoPostBack="True"></asp:listbox></TD>
					<TD align="center" width="20">&nbsp;</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelect" runat="server" Height="250px" Width="200px" CssClass="fonthead" SelectionMode="Multiple"
							BorderStyle="Outset"></asp:listbox></TD>
					<TD align="center" width="50"><asp:imagebutton id="btnaddall" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveall" runat="server"></asp:imagebutton><BR>
					</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelected" Height="250px" Width="200px" CssClass="fonthead" Runat="server"
							SelectionMode="Multiple"></asp:listbox></TD>
					<TD align="center" width="50"><asp:imagebutton id="btnColmoveup" Runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnColmovedwn" Runat="server"></asp:imagebutton></TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
		</td>
	</tr>
</table>
<TABLE id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	<TR>
		<TD align="center" width="50">&nbsp;</TD>
		<TD align="center" width="500"><asp:imagebutton id="btnBack" runat="server"></asp:imagebutton><asp:imagebutton id="btnSave" runat="server"></asp:imagebutton><asp:imagebutton id="btnNext" runat="server"></asp:imagebutton></TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
