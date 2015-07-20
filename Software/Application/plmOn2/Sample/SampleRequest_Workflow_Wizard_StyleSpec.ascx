<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_StyleSpec.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_StyleSpec" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fontHead">&nbsp;<FONT color="darkgray" size="3"><asp:Label ID="lblHeader" runat="server" ></asp:Label></FONT></td>
	</tr>
</table>
<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="800"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
		<td></td>
	</tr>
</table>
<BR>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fontHead">
                        <asp:Label ID="lblStyleSpecAvailable" runat="server"></asp:Label>
								</B></FONT></TD>
					<TD width="50"></TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fontHead">
                        <asp:Label ID="lblSelectSampleSize" runat="server"></asp:Label>
								
								(<asp:label id="lblSampleSize" runat="server" ForeColor="Red"></asp:label>&nbsp;)
							</B></FONT>
					</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelect" runat="server" CssClass="fontHead" Width="250px" Height="250px" SelectionMode="Multiple"
							BorderStyle="Outset"></asp:listbox></TD>
					<TD align="center" width="50"><BR>
						<BR>
						<BR>
						<BR>
					</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelected" CssClass="fontHead" Width="250px" Height="250px" SelectionMode="Multiple"
							Runat="server"></asp:listbox></TD>
					<TD align="center" width="50"><BR>
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
		<TD align="center" width="500"><asp:imagebutton id="btnBack" runat="server"></asp:imagebutton><asp:imagebutton id="btnSave" runat="server"></asp:imagebutton><asp:imagebutton id="btnNext" runat="server"></asp:imagebutton></TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
