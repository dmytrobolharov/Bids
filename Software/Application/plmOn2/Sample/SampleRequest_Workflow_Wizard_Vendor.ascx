<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_Vendor.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_Vendor" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0"
	id="Table1">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fonthead">
			&nbsp;
			<asp:Label id="lblVendorHeader" runat="server" CssClass="fontHead"></asp:Label></td>
	</tr>
</table>
<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD width="800" bgColor="#ffffff"><uc1:Style_Header id="Style_Header1" runat="server"></uc1:Style_Header></TD>
	</TR>
</TABLE>
<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
	<tr>
		<TD width="50">&nbsp;</TD>
		<TD>
			<TABLE id="Table2" height="35" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="75" class="fonthead">
						<P align="center">
                            <asp:Label ID="lblSearch" runat="server" ></asp:Label></P>
					</TD>
					<TD width="150">
						<asp:TextBox id="txtSearch" runat="server" Width="200px"></asp:TextBox></TD>
					<TD width="30">
						<asp:imagebutton id="btnSearch" runat="server"></asp:imagebutton></TD>
					<TD><asp:checkbox id="cbQuoteExist" runat="server" CssClass="fontHead" 
							ForeColor="Red" AutoPostBack="True"></asp:checkbox></TD>
				</TR>
			</TABLE>
		</TD>
	</tr>
</TABLE>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0"
				id="Table3">
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD align="center" width="200" class="fontHead">
						<asp:Label id="lblTradePartnerSelected" runat="server"></asp:Label></TD>
					<TD align="center" width="50"></TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								<asp:Label id="lblVendorAvailable" runat="server"></asp:Label></B></FONT></TD>
					<TD width="50"></TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fonthead">
								<asp:Label id="lblVendorSelected" runat="server"></asp:Label>
							</B></FONT>
					</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD align="center" width="200">
						<asp:listbox id="lstTradePartner" CssClass="fonthead" Width="250px" Height="250px" Runat="server"
							AutoPostBack="True"></asp:listbox></TD>
					<TD align="center" width="50"></TD>
					<TD align="center" width="200"><asp:listbox id="lstSelect" BorderStyle="Outset" SelectionMode="Multiple" Height="250px" Width="250px"
							CssClass="fonthead" runat="server"></asp:listbox></TD>
					<TD align="center" width="50"><asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><BR>
						<asp:imagebutton id="btnadditem" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveall" runat="server"></asp:imagebutton><BR>
					</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelected" SelectionMode="Multiple" Height="250px" Width="250px" CssClass="fonthead"
							Runat="server"></asp:listbox></TD>
					<TD align="center" width="50"><asp:imagebutton id="btnColmoveup" Runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnColmovedwn" Runat="server"></asp:imagebutton></TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
		</td>
	</tr>
</table>
<TABLE style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0"
	id="Table4">
	<TR>
		<TD align="center" width="50">&nbsp;</TD>
		<TD align="center" width="500">
			<asp:imagebutton id="btnBack" runat="server" ></asp:imagebutton>
			<asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton>
			<asp:imagebutton id="btnNext" runat="server" ></asp:imagebutton>
		</TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
