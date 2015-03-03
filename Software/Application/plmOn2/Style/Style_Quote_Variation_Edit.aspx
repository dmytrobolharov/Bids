<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Costing_Material" Src="Style_Costing_Material.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_Variation_Edit.aspx.vb" Inherits="plmOnApp.Style.Quote.Style_Quote_Variation_Edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Costing</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveStyle" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnAddVendor" runat="server"  CommandName="AddVendor"	Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" CausesValidation="false" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header>
			<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0" runat="server">
				<tr>
					<td valign="top">
						<asp:panel id="pnlCosting" runat="server">
							<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr class="TableHeader">
									<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="fontHead">
										<asp:label id="lbQuote" runat="server"> Costing</asp:label>&nbsp;</td>
								</tr>
							</table>
							<asp:placeholder id="phlCostVariation" runat="server"></asp:placeholder>
							<asp:panel id="pnlCostContainer" runat="server">
								<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
									<tr class="TableHeader">
										<td style="HEIGHT: 24px" valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td class="fontHead" style="HEIGHT: 24px">
											<asp:label id="Label1" runat="server">Container</asp:label>&nbsp;</td>
									</tr>
								</table>
								<table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffff99" border="0">
									<tr>
										<td>
											<asp:placeholder id="phlCostContainer" runat="server"></asp:placeholder></td>
									</tr>
								</table>
							</asp:panel> <!--
						<table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr class="TableHeader">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead"><asp:label id="Label2" runat="server">Freight Cost</asp:label>&nbsp;</td>
							</tr>
						</table>
						<asp:datagrid id="dgFreightCost" runat="server" BorderColor="Silver" BorderWidth="1px" Width="300px"
							AutoGenerateColumns="False" PageSize="100" BorderStyle="Solid">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
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
								<asp:TemplateColumn>
									<HeaderStyle Width="75px"></HeaderStyle>
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
						</asp:datagrid>
					-->
						</asp:panel>
					</td>
					<td valign="top" width="100%" bgColor="#ffffff">
						<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="TableHeaderYellow">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead">&nbsp;
									<asp:label id=lbHeaderTradePartner runat="server" CssClass="fonthead" text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>'>
									</asp:label>&nbsp;(
									<asp:label id="lblTradePartnerClass" runat="server" CssClass="fontHead"></asp:label>)</td>
							</tr>
						</table>
						<table id="Table4" borderColor="#ffffff" cellSpacing="2" cellpadding="2" border="0">
							<tr>
								<td></td>
								<td><asp:label id="lbTradePartnerName" runat="server" CssClass="fonthead"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbAddress1" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbAddress2" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbCityState" runat="server" CssClass="font"></asp:label></td>
							</tr>
						</table>
						<table id="Table3" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="TableHeaderYellow">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead">&nbsp;
									<asp:label id="lblTradePartnerQuote" runat="server" CssClass="fonthead" text="Vendor Quote">Agent Quote</asp:label></td>
							</tr>
						</table>
						<asp:placeholder id="plhTradePartnerQuote" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table height="5" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0" runat="server"
				class="TableHeaderGreen">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" width="20">&nbsp;<IMG alt="" src="../System/Icons/icon_paneldown.gif"></td>
					<td>&nbsp;<asp:Label ID="lblSum" runat="server" Text="Vendor Quote Summary"></asp:Label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="top" width="1"></td>
					<td><asp:datalist id="dlCosting" runat="server" BorderColor="Silver" BorderWidth="0px" EnableViewState="True"
							RepeatDirection="Horizontal" RepeatColumns="6" Width="400" BackColor="#ffffff">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td nowrap>
											<cc1:confirmedimagebutton id="btnEditQuote" runat="server"  Message="NONE"
												CommandName="Edit"></cc1:confirmedimagebutton>
											<cc1:confirmedimagebutton id="btnDeleteQuote" runat="server" Message="NONE"
												CommandName="Delete"></cc1:confirmedimagebutton></td>
									</tr>
								</table>
								<table class="TableHeaderOver" height="25" cellSpacing="0" cellpadding="0" width="100%"
									border="0">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:label id="lbTradePartnerVendor" runat="server" CssClass="fonthead"></asp:label></td>
									</tr>
								</table>
								<table cellSpacing="0" cellpadding="0" width="100%" border="0">
									<tr>
										<td valign="top" width="900" bgColor="#ffffff">
											<asp:placeholder id="plhVendorCosting" runat="server"></asp:placeholder></td>
										<td></td>
									</tr>
								</table>
								<asp:Panel id="pnlContainer" runat="server">
									<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
										<tr class="TableHeader">
											<td style="HEIGHT: 24px" valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
											<td class="fontHead" style="HEIGHT: 24px">
												<asp:label id="lbQuoteSpecial" runat="server"><%#GetSystemText("Container")%>...</asp:label>&nbsp;</td>
										</tr>
									</table>
									<table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffff99" border="0">
										<tr>
											<td>
												<asp:placeholder id="plhContainer" runat="server"></asp:placeholder></td>
										</tr>
									</table>
								</asp:Panel><INPUT id=txtStyleCostingId type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleCostingId").ToString %>' runat="server"><INPUT id=txtStyleCostingTypeId type=hidden value='<%# DataBinder.Eval(Container.DataItem, "StyleCostingType") %>' runat="server">
							</ItemTemplate>
						</asp:datalist></td>
				</tr>
			</table>
			<table height="5" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table class="TableHeader" id="Table1" height="25" cellSpacing="0" cellpadding="0" width="100%"
				border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>&nbsp;<asp:Label ID="lblMain" runat="server" Text="Main Material"></asp:Label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="900" bgColor="#ffffff"><uc1:style_costing_material id="Style_Costing_Material1" runat="server"></uc1:style_costing_material></td>
					<td></td>
				</tr>
			</table>
			<BR>
			<table height="24" cellSpacing="0" cellpadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
					<td class="TableBar">
						<asp:Label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
						<asp:Label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
