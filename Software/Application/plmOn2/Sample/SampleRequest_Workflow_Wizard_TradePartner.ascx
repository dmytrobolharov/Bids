<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard_TradePartner.ascx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard_TradePartner" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<tr>
		<td width="50" height="50">&nbsp;</td>
		<td class="fontHead">&nbsp;
			<asp:label id="lblTradePartnerHeader" runat="server"></asp:label></td>
	</tr>
</table>
<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
	<TR>
		<TD width="800" bgColor="#ffffff"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></TD>
	</TR>
</TABLE>
<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
	<tr>
		<TD width="50">&nbsp;</TD>
		<TD>
			<TABLE id="Table2" height="35" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="75" class="fontHead">
						<P align="center">
                            <asp:Label ID="lblSearch" runat="server" ></asp:Label></P>
					</TD>
					<TD width="150">
						<asp:TextBox id="txtSearch" runat="server" Width="200px"></asp:TextBox></TD>
					<TD width="30">
						<asp:imagebutton id="btnSearch" runat="server" ></asp:imagebutton></TD>
					<TD><asp:checkbox id="cbQuoteExist" runat="server" CssClass="fontHead"
							ForeColor="Red" AutoPostBack="True" Checked="True"></asp:checkbox></TD>
				</TR>
			</TABLE>
		</TD>
	</tr>
</TABLE>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		<td>
			<TABLE id="Table3" cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff"
				border="0">
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fontHead"><asp:label id="lblTradePartnerAvailable" runat="server"></asp:label></B></FONT></TD>
					<TD width="50"></TD>
					<TD align="center" width="200"><FONT face="Microsoft Sans Serif" color="#000000" size="2"><B class="fontHead"><asp:label id="lblTradePartnerSelected" runat="server"></asp:label></B></FONT></TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelect" runat="server" CssClass="fontHead" Width="350px" Height="250px" SelectionMode="Multiple"
							BorderStyle="Outset"></asp:listbox></TD>
					<TD align="center" width="50"><asp:imagebutton id="btnaddall" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveitem" runat="server"></asp:imagebutton><BR>
						<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><BR>
					</TD>
					<TD align="center" width="200"><asp:listbox id="lstSelected" CssClass="fontHead" Width="350px" Height="250px" SelectionMode="Multiple"
							Runat="server"></asp:listbox></TD>
					<TD align="center" width="50"><asp:imagebutton id="btnColmoveup"  Runat="server"></asp:imagebutton><BR>
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
		<TD align="center" width="500"><asp:imagebutton id="btnBack" runat="server" ></asp:imagebutton><asp:imagebutton id="btnSave" runat="server" ></asp:imagebutton><asp:imagebutton id="btnNext" runat="server" ></asp:imagebutton></TD>
		<TD align="center">&nbsp;</TD>
	</TR>
</TABLE>
