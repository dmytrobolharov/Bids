<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_RequestSubmitVendor.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitVendor"%>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register src="Material_Header.ascx" tagname="Material_Header" tagprefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>SampleRequest_Workflow_Submit_Vendor</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
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
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle" height="24">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					</TD>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Agent / Vendor</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900">
						<uc2:Material_Header ID="Material_Header1" runat="server" />
                    </td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0" bgColor="#ffffff" id="tbcAgentVendorInfo" runat="server">
				<TR>
					<TD width="400" vAlign="top">
						<TABLE id="Table2" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeader">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;
									<asp:label id="lbHeaderTradePartner" runat="server" text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>' CssClass="fonthead">
									</asp:label>&nbsp;(
									<asp:label id="lblTradePartnerClass" runat="server" CssClass="fontHead"></asp:label>)</TD>
							</TR>
						</TABLE>
						<TABLE id="Table3" borderColor="#ffffff" cellSpacing="2" cellPadding="2" border="0" width="100%">
							<TR>
								<TD></TD>
								<TD>
									<asp:label id="lbTradePartnerName" runat="server" CssClass="fonthead"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:label id="lbAddress1" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:label id="lbAddress2" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:label id="lbCityState" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:CheckBox id="cbShareAgent" runat="server" ForeColor="Red" CssClass="fontHead"></asp:CheckBox>
                                    <asp:HiddenField ID="oldShare" runat="server" />
                                    </TD>
							</TR>
						</TABLE>
					</TD>
					<TD width="400" vAlign="top">
						<TABLE id="Table5" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeaderYellow">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;
									<asp:label id=lbHeaderTradePartnerVendor runat="server" text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>' CssClass="fonthead">
									</asp:label></TD>
							</TR>
						</TABLE>
						<TABLE id="Table4" borderColor="#ffffff" cellSpacing="2" cellPadding="2" border="0" width="100%">
							<TR>
								<TD></TD>
								<TD>
									<asp:label id="lbVendorName" runat="server" CssClass="fonthead"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:label id="lbVendorAddress1" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:label id="lbVendorAddress2" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
									<asp:label id="lbVendorCityState" runat="server" CssClass="font"></asp:label></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
