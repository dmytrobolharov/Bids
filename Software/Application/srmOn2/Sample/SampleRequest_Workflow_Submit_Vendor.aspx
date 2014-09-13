<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Vendor.aspx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Vendor"%>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="uc2" TagName="TradePartner_Header" Src="SampleRequest_Partner_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		 <title runat="server" id="PageTitle"></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
<%--		<script language="javascript">
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
		</script>--%>
	</HEAD>
	<body>    
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle" height="24">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnVendorReplace" runat="server"></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="btnNewIssue" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</TD>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900">
						<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<td><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
				</tr>
			</table>
            <uc2:TradePartner_Header ID="TradePartner_Header1" runat="server" visible="false"></uc2:TradePartner_Header>
			<table  id="tbcAgentVendorInfo" runat="server" cellSpacing="1" cellPadding="1" width="100%" border="0" bgColor="#ffffff">
				<tr>
					<td width="400" vAlign="top">
						<table id="Table2" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr class="TableHeader">
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<td class="fontHead">&nbsp;
									<asp:label id="lbHeaderTradePartner" runat="server" text='' CssClass="fonthead">
									</asp:label>&nbsp;(
									<asp:label id="lblTradePartnerClass" runat="server" CssClass="fontHead"></asp:label>)</td>
							</tr>
						</table>
						<table id="Table3" borderColor="#ffffff" cellSpacing="2" cellPadding="2" border="0" width="100%">
							<tr>
								<td></td>
								<td>
									<asp:label id="lbTradePartnerName" runat="server" CssClass="fonthead"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbAddress1" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbAddress2" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbCityState" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:CheckBox id="cbShareAgent" runat="server" ForeColor="Red" CssClass="fontHead"></asp:CheckBox></TD>
							</tr>
						</table>
					</td>
					<td width="400" vAlign="top">
						<table id="Table5" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr class="TableHeaderYellow">
								<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<td class="fontHead">&nbsp;
									<asp:label id="lbHeaderTradePartnerVendor" runat="server" text='' CssClass="fonthead">
									</asp:label></TD>
							</tr>
						</table>
						<table id="Table4" borderColor="#ffffff" cellSpacing="2" cellPadding="2" border="0" width="100%">
							<tr>
								<td></td>
								<td>
									<asp:label id="lbVendorName" runat="server" CssClass="fonthead"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbVendorAddress1" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbVendorAddress2" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:label id="lbVendorCityState" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
							</tr>
						</table>
					</td>
					<td></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
