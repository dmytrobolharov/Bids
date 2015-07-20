<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QuoteItem_Edit.aspx.vb" Inherits="plmOnApp.QuoteItem_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Costing_Material" Src="../Style/Style_Costing_Material.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Quotation</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
			function customwindow(strWindowUrl)
			{
			windowCustom = window.open("../System/Control/" + strWindowUrl + "","Custom","toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=50,top=50");
			windowCustom.focus();
			}
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" height="24" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSaveStyle" runat="server" Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR>
						<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD class="fontHead" width="25">
							<DIV align="center"><asp:image id="imgQuoteStatus" runat="server" ImageUrl="../System/Icons/icon_ball_gray.gif"></asp:image></DIV>
						</TD>
						<TD class="fontHead" vAlign="middle"><asp:label id="lbCostType" runat="server"></asp:label>&nbsp;<asp:label id="lblQuoteStatus" runat="server"></asp:label>&nbsp;
							<cc1:confirmedlinkbutton id="hl_Status" runat="server" Message="Are you sure you want to edit status?"></cc1:confirmedlinkbutton></TD>
						<TD class="fontHead" vAlign="middle" align="center" width="25"></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="850"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<TD><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></TD>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD vAlign="top" width="300">
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeaderYellow">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;<asp:label id="lblVendor" runat="server">Vendor</asp:label></TD>
							</TR>
						</TABLE>
						<TABLE id="Table3" borderColor="#ffffff" cellSpacing="2" cellPadding="2" border="3">
							<TR>
								<TD></TD>
								<TD><asp:label id="lbVendorName" runat="server" CssClass="fonthead"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:label id="lbVendorAddress1" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:label id="lbVendorAddress2" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:label id="lbVendorCityState" runat="server" CssClass="font"></asp:label></TD>
							</TR>
						</TABLE>
					</TD>
					<td vAlign="top">
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeader">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;
									<asp:label id=lbHeaderTradePartner runat="server" text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>' CssClass="fonthead">
									</asp:label>&nbsp;(<asp:label id="lblTradePartnerClass" runat="server" CssClass="fontHead"></asp:label>)</TD>
							</TR>
						</TABLE>
						<TABLE borderColor="#ffffff" cellSpacing="2" cellPadding="2" border="3">
							<TR>
								<TD></TD>
								<TD><asp:label id="lbTradePartnerName" runat="server" CssClass="fonthead"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:label id="lbAddress1" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:label id="lbAddress2" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD><asp:label id="lbCityState" runat="server" CssClass="font"></asp:label></TD>
							</TR>
						</TABLE>
					</td>
				</TR>
			</TABLE>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR vAlign="top">
					<TD width="100%">
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeaderYellow">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;
									<asp:label id="lblVendorQuote" runat="server" text="Vendor Quote" CssClass="fonthead"></asp:label></TD>
							</TR>
						</TABLE>
						<asp:placeholder id="plhVendorQuote" runat="server"></asp:placeholder></TD>
				</TR>
			</TABLE>
			<TABLE class="TableHeader" id="Table1" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>&nbsp;Main Material</TD>
				</TR>
			</TABLE>
			<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top" width="900" bgColor="#ffffff"><asp:placeholder id="phStyleMaterial" runat="server"></asp:placeholder></TD>
					<TD></TD>
				</TR>
			</TABLE>
			<br>
		</form>
	</body>
</HTML>
