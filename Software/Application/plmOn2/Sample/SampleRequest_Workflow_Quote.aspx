<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Quote.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Quote" %>
<%@ Register TagPrefix="uc1" TagName="Style_Costing_Material" Src="../Style/Style_Costing_Material.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Quote_Variation_Selected" Src="../Style/Style_Quote_Variation_Selected.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
		    function calendar(sTxtBoxName) {
		        windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
		        windowDatePicker.focus();
		    }
		    function customwindow(strWindowUrl) {
		        windowCustom = window.open("../System/Control/" + strWindowUrl + "", "Custom", "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=50,top=50");
		        windowCustom.focus();
		    }
		</script>
	</HEAD>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><asp:button id="btnDefault" runat="server" Height="1px" Width="1px" Text=""></asp:button><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
                        <cc1:BWImageButton id="btnNewIssue" runat="server" Message="NONE" CausesValidation="False"></cc1:BWImageButton>
					</TD>
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
							<cc1:confirmedlinkbutton id="hl_Status" runat="server" Message="NONE"></cc1:confirmedlinkbutton></TD>
						<TD class="fontHead" vAlign="middle" align="center" width="25"></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="100%"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD vAlign="top" width="300">
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeader">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;
									<asp:label id=lbHeaderTradePartner runat="server" CssClass="fonthead" text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>'>
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
					</TD>
					<td vAlign="top">
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeader">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;
									<asp:label id="lblQuoteComment" runat="server" CssClass="fonthead" ></asp:label></TD>
							</TR>
						</TABLE>
						<asp:textbox id="txtQuoteComment" runat="server" Width="400px" Height="100px" TextMode="MultiLine"></asp:textbox></td>
				</TR>
			</TABLE>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeader">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead"><asp:label id="lbQuote" runat="server"></asp:label>&nbsp;</TD>
							</TR>
						</TABLE>
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder><asp:panel id="pnlContainer" runat="server">
							<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader">
									<TD style="HEIGHT: 24px" vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
									<TD class="fontHead" style="HEIGHT: 24px">
										<asp:label id="lbQuoteSpecial" runat="server"></asp:label>&nbsp;</TD>
								</TR>
							</TABLE>
							<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffff99" border="0">
								<TR>
									<TD>
										<asp:placeholder id="plhContainer" runat="server"></asp:placeholder></TD>
								</TR>
							</TABLE>
						</asp:panel>
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<TR class="TableHeader">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead"><asp:label id="lblFreightCost" runat="server"><%#GetSystemText("Freight Cost")%></asp:label>&nbsp;</TD>
							</TR>
						</TABLE>
						<asp:datagrid id="dgFreightCost" runat="server" Width="300px" BorderColor="Silver" BorderStyle="Solid"
							BorderWidth="1px" PageSize="100" AutoGenerateColumns="False">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center"></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<DIV align="center">
											<asp:CheckBox id="cbFreightCostSelected" runat="server"></asp:CheckBox></DIV>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderFreightMethod" Text="Method" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<DIV align="center">
											<asp:Label id="lblFreightMethod" runat="server" Width="50"></asp:Label></DIV>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderStyle-Width="75px">
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderMargin" Text="Margin" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblMargin" runat="server" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderTotalLandCost" Text="TLC" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblTotalLandCost" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderFreightCost" Text="Frt Cost" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblFreightCost" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderFreightRate" Text="Frt Rate" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblFreightRate" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></TD>
					<TD width="70%">
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server" id="tblVendorHeader">
							<TR class="TableHeaderYellow">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;<asp:label id="lblVendor" runat="server"></asp:label></TD>
							</TR>
						</TABLE>
						<TABLE borderColor="#ffffff" cellSpacing="2" cellPadding="2" border="3" runat="server" id="tblVendorData">
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
						<TABLE height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="TableHeaderYellow">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD class="fontHead">&nbsp;
									<asp:label id="lblVendorQuote" runat="server" CssClass="fonthead" ></asp:label></TD>
							</TR>
						</TABLE>
						<asp:placeholder id="plhVendorQuote" runat="server"></asp:placeholder></TD>
				</TR>
			</TABLE>
			<TABLE class="TableHeader" id="Table1" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>&nbsp;<asp:Label ID="lblMainMaterial" runat="server" ><%#GetSystemText("Main Material")%></asp:Label></TD>
				</TR>
			</TABLE>
			<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top" width="900" bgColor="#ffffff"><asp:placeholder id="phStyleMaterial" runat="server"></asp:placeholder></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
