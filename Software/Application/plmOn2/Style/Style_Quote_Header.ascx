<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_Header.ascx.vb" Inherits="plmOnApp.Style.Quote.Style_Quote_Header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	<TR vAlign="top">
		<TD>
			<TABLE id="Table2" borderColor="#ffffff" cellSpacing="2" cellPadding="2" width="400" border="3">
				<TR>
					<TD></TD>
					<TD width="125">
						<asp:label id="lbHeaderTradePartner" CssClass="fonthead" runat="server"></asp:label></TD>
					<TD>
						<asp:label id="lbTradePartnerName" CssClass="fonthead" runat="server"></asp:label></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<asp:label id="lbHeaderAddress1" runat="server"></asp:label></TD>
					<TD>
						<asp:label id="lbAddress1" CssClass="font" runat="server"></asp:label></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<asp:label id="lbHeaderAddress2" runat="server"></asp:label></TD>
					<TD>
						<asp:label id="lbAddress2" CssClass="font" runat="server"></asp:label></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<asp:label id="lblHeaderCityState" runat="server"></asp:label></TD>
					<TD>
						<asp:label id="lbCityState" CssClass="font" runat="server"></asp:label></TD>
				</TR>
			</TABLE>
		</TD>
		<TD>
			<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
	</TR>
</TABLE>
