<%@ Register TagPrefix="uc2" TagName="Style_QuoteItem_Document" Src="Style_QuoteItem_Document.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Costing_Material" Src="Style_Costing_Material.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_QuoteItem_Edit.aspx.vb" Inherits="plmOnApp.Style.Quote.Style_QuoteItem_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Quote_Variation_Selected" Src="Style_Quote_Variation_Selected.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Style_QuoteItem_Comment" Src="Style_QuoteItem_Comment.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Quote</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" height="24" cellSpacing="0" cellpadding="0" width="100%"
				border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        <cc1:confirmedimagebutton id="btnSaveStyle" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="cmdPdfPrint" runat="server" Message="NONE" Visible="False"></cc1:bwimagebutton>
						<cc1:bwimagebutton id="btnEditVendorQuote" runat="server" Visible="False" DESIGNTIMEDRAGDROP="17"></cc1:bwimagebutton>
						<cc1:bwimagebutton id="btnVendorReplace" runat="server" DESIGNTIMEDRAGDROP="195"></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnDelete" runat="server" Message="Do you want to delete this quote?" ></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnNewIssue" runat="server" Message="NONE" CausesValidation="False"></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"  CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<TBODY>
					<tr>
						<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td class="fontHead" width="25">
							<DIV align="center"><asp:image id="imgQuoteStatus" runat="server" ImageUrl="../System/Icons/icon_ball_gray.gif"></asp:image></DIV>
						</td>
						<td class="fontHead" valign="middle"><asp:label id="lbCostType" runat="server"></asp:label>&nbsp;<asp:label id="lblQuoteStatus" runat="server"></asp:label>&nbsp;
							<cc1:confirmedlinkbutton id="hl_Status" runat="server" Message="NONE"></cc1:confirmedlinkbutton></td>
						<td class="fontHead" valign="middle" align="center" width="25"></td>
					</tr>
				</TBODY>
			</table>
            <asp:Panel ID="pnlSeasonYear"  runat="server" >
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0">
                    <tr valign="middle">
                        <td valign="middle" align="left" >
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">&nbsp;&nbsp;&nbsp;&nbsp;<img src="../System/Icons/icon_season.gif" />&nbsp;&nbsp;<asp:Label 
                            runat="server" ID="Label1" class="fontHead" >Season / Year:</asp:Label>&nbsp;&nbsp;<asp:Label ID="lblStyleSeasonYear" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel> 			
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="850"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<td><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" width="100%" bgColor="#ffffff" border="0" bordercolor="red">
				<tr>
					<td width="50%">

					
						<table height="21" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr >
								<td >&nbsp;</td>
							</tr>
						</table>
					
						<table height="30" cellSpacing="0" cellpadding="0" width="100%" border="0" class="TableHeader" >
							<tr >
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead">&nbsp;
									<asp:label id=lbHeaderTradePartner runat="server" CssClass="fonthead" text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>'>
									</asp:label>&nbsp;(<asp:label id="lblTradePartnerClass" runat="server" CssClass="fontHead"></asp:label>)</td>
							</tr>
						</table>
						<table cellSpacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td valign="top" width="300">
									<table borderColor="#ffffff" cellSpacing="2" cellpadding="2" border="3">
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
										<tr>
											<td></td>
											<td>
												<asp:CheckBox id="cbShareAgent" runat="server" CssClass="fontHead" ForeColor="Red"></asp:CheckBox></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table cellSpacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
							<tr valign="top">
								<td>
									<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
										<tr class="TableHeader">
											<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
											<td class="fontHead"><asp:label id="lbQuote" runat="server">Quote Detail</asp:label>&nbsp;</td>
										</tr>
									</table>
									<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder><asp:panel id="pnlContainer" runat="server">
										<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
											<tr class="TableHeader">
												<td style="HEIGHT: 24px" valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
												<td class="fontHead" style="HEIGHT: 24px">
													<asp:label id="lbQuoteSpecial" runat="server">Container...</asp:label>&nbsp;</td>
											</tr>
										</table>
										<table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffff99" border="0">
											<tr>
												<td>
													<asp:placeholder id="plhContainer" runat="server"></asp:placeholder></td>
											</tr>
										</table>
									</asp:panel>
									<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" border="0" width="100%">
										<tr valign="middle">
											<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
											<td>&nbsp;<asp:Label ID="lblFrCost" runat="server" Text="Freight Cost"></asp:Label></td>
										</tr>
									</table>
									<asp:datagrid id="dgFreightCost" runat="server" Width="300px" BorderColor="Silver" BorderStyle="Solid"
										BorderWidth="1px" PageSize="100" AutoGenerateColumns="False">
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
														<asp:CheckBox id="cbFreightCostSelected" visible="False" runat="server"></asp:CheckBox>
														<asp:RadioButton ID="rbFreightCostSelected" Runat="server"></asp:RadioButton>
													</DIV>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<div align="center">
														<asp:Label id="lblHeaderFreightMethod" Text='<%#GetSystemText("Method")%>' runat="server" /></div>
												</HeaderTemplate>
												<ItemTemplate>
													<DIV align="center">
														<asp:Label id="lblFreightMethod" runat="server" Width="50"></asp:Label></DIV>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn HeaderStyle-Width="75px">
												<HeaderTemplate>
													<div align="center">
														<asp:Label id="lblHeaderMargin" Text='<%#GetSystemText("Margin")%>' runat="server" /></div>
												</HeaderTemplate>
												<ItemTemplate>
													<div align="center">
														<asp:Label id="lblMargin" runat="server" /></div>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<div align="center">
														<asp:Label id="lblHeaderTotalLandCost" Text='<%#GetSystemText("TLC")%>' runat="server" /></div>
												</HeaderTemplate>
												<ItemTemplate>
													<div align="center">
														<asp:Label id="lblTotalLandCost" runat="server" Width="50" /></div>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<div align="center">
														<asp:Label id="lblHeaderFreightCost" Text='<%#GetSystemText("Frt Cost")%>' runat="server" /></div>
												</HeaderTemplate>
												<ItemTemplate>
													<div align="center">
														<asp:Label id="lblFreightCost" runat="server" Width="50" /></div>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<div align="center">
														<asp:Label id="lblHeaderFreightRate" Text='<%#GetSystemText("Frt Rate")%>' runat="server" /></div>
												</HeaderTemplate>
												<ItemTemplate>
													<div align="center">
														<asp:Label id="lblFreightRate" runat="server" Width="50" /></div>
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
									</asp:datagrid></td>
							</tr>
						</table>
						<table visible="false" class="TableHeader" id="Table1" height="25" cellSpacing="0" cellpadding="0" border="0"
							runat="server" width="100%">
							<tr valign="middle">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>&nbsp;<asp:Label ID="lblMM" runat="server" Text="Main Material"></asp:Label></td>
							</tr>
						</table>
						<table id="Table2" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td valign="top" bgColor="#ffffff"><asp:placeholder Visible="false" id="phStyleMaterial" runat="server"></asp:placeholder></td>
								<td></td>
							</tr>
						</table>
						<br>
						<table id="Table4" height="24" cellSpacing="0" cellpadding="0" width="100%" border="0"
							runat="server">
							<tr valign="middle">
								<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
								<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
								<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
									<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
								<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
							</tr>
						</table>
					</td>
					<td valign="top" width="50%">
						<cc2:YSTabView id="YSTabView1" runat="server"></cc2:YSTabView>
						<asp:Panel ID="pnlVendor" Runat="server">
							<table height="30" cellSpacing="0" cellpadding="0" width="100%" border="0" class="TableHeaderYellow">
								<tr >
									<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="fontHead">&nbsp;
										<asp:label id="lblVendor" runat="server">Vendor</asp:label></td>
								</tr>
							</table>
							<table id="Table3" borderColor="#ffffff" cellSpacing="2" cellpadding="2" border="3">
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
							</table>
							<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr class="TableHeaderYellow">
									<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="fontHead">&nbsp;
										<asp:label id="lblVendorQuote" runat="server" text="Vendor Quote" CssClass="fonthead"></asp:label></td>
								</tr>
							</table>
							<asp:placeholder id="plhVendorQuote" runat="server"></asp:placeholder>
						</asp:Panel>
						<asp:Panel ID="pnlComments" Runat="server">
							<uc2:Style_QuoteItem_Comment id="Style_QuoteItem_Comment1" runat="server"></uc2:Style_QuoteItem_Comment>
						</asp:Panel>
						<asp:Panel ID="pnlAttachments" Runat="server">
							<uc2:Style_QuoteItem_Document id="Style_QuoteItem_Document1" runat="server"></uc2:Style_QuoteItem_Document>
						</asp:Panel>
					</td>
				</tr>
			</table>
		</form>
		<script language='javascript'> 
		function  SelectRadio (obj) {
			var e ; 
			var frm = document.Form1 ;
			for ( x = 0 ; x < frm.length ; x++ )  {
				e = frm.elements[x] ;
				if ( e.type == 'radio'  && e.name.indexOf ("rbFreightCostSelected")  != -1 ) 
					e.checked = false ;
			} 
			obj.checked = true; 
		} 
		
		
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
