<%@ Control Language="vb" AutoEventWireup="false" Codebehind="LinePlanAttributePopupMain.ascx.vb" Inherits="plmOnApp.LinePlanAttributePopupMain" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<LINK href="../CSS/Style.css" type="text/css" rel="stylesheet">
<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fonthead">
			&nbsp;<asp:Label ID="lblHeader" runat="server" ></asp:Label></td>
	</tr>
</table>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
                        <asp:Label ID="lblAttributeAvailable" runat="server" ></asp:Label></B></FONT></TD>
					<TD width="50"></TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
                        <asp:Label ID="lblAttributeSelected" runat="server" ></asp:Label> </B></FONT>
					</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelect" BorderStyle="Outset" SelectionMode="Multiple" Height="250px" Width="250px"
							CssClass="fonthead" runat="server"></asp:listbox></TD>
					<TD align="center" width="50"><asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
						<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveall" runat="server"></asp:imagebutton><BR>
					</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelected" SelectionMode="Multiple" Height="250px" Width="250px" CssClass="fonthead"
							Runat="server"></asp:listbox></TD>
					<TD align="center" width="50"><asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnColmovedwn"  Runat="server"></asp:imagebutton></TD>
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
			<asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton>
			<asp:imagebutton id="btnClose" runat="server"></asp:imagebutton>
		</TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
