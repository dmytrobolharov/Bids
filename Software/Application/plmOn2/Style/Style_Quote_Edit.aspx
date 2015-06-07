<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_Edit.aspx.vb" Inherits="plmOnApp.Style.Quote.Style_Quote_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Quote_Variation_Message" Src="Style_Quote_Variation_Message.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Quote_Variation_Selected" Src="Style_Quote_Variation_Selected.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="24" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveStyle" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnAddStyle" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnDeleteRFQ" runat="server"  CausesValidation="false"></cc1:confirmedimagebutton>
						<cc1:BWImageButton id="btnNewIssue" runat="server" Message="NONE"  CausesValidation="False"></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr valign="top">
					<td width="400">
						<table borderColor="#ffffff" cellSpacing="2" cellpadding="2" width="400" border="3">
							<tr>
								<td></td>
								<td width="125"><asp:label id=lbHeaderTradePartner runat="server" text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>' CssClass="fonthead">
									</asp:label></td>
								<td><asp:label id="lbTradePartnerName" runat="server" CssClass="fonthead"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbHeaderAddress1" runat="server"></asp:label></td>
								<td><asp:label id="lbAddress1" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbHeaderAddress2" runat="server"></asp:label></td>
								<td><asp:label id="lbAddress2" runat="server" CssClass="font"></asp:label></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lblHeaderCityState" runat="server"></asp:label></td>
								<td><asp:label id="lbCityState" runat="server" CssClass="font"></asp:label></td>
							</tr>
						</table>
					</td>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<BR>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<asp:panel id="pnlVariation" runat="server">
                <asp:Panel ID="pnlSeasonYear"  runat="server" >
                    <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                        border="0">
                        <tr valign="middle">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                            <td width="125" align="right" nowrap="nowrap">
                                <asp:Label runat="server" ID="Label1" class="fontHead" >Select Season / Year:</asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                </asp:Panel> 
				<asp:datalist id="dlVariation" runat="server" Width="300px" RepeatDirection="Horizontal">
					<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="LightGray"
						VerticalAlign="Top" BackColor="White"></ItemStyle>
					<ItemTemplate>
						<table class="TableHeader" height="24" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr valign="middle">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>
									<asp:Label id=lblVariation runat="server" CssClass="fontHead" Text='<%# string.Concat("Variation " + DataBinder.Eval(Container.DataItem, "Variation").ToString) %>'>
									</asp:Label></td>
							</tr>
						</table>
                        <asp:PlaceHolder ID="plhQuote" runat="server"></asp:PlaceHolder>
						<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="TableHeader">
								<td style="HEIGHT: 24px" valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" style="HEIGHT: 24px">
									<asp:label id="lbTradeCosting" runat="server"><%#GetSystemText("Costing")%>...</asp:label>&nbsp;</td>
							</tr>
						</table>
						<table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td>
									<asp:placeholder id="plhTradeCosting" runat="server"></asp:placeholder></td>
							</tr>
						</table>
					</ItemTemplate>
					<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
				</asp:datalist>
			</asp:panel><asp:panel id="pnlMessage" runat="server">
				<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td width="80">
							<cc1:confirmedimagebutton id="btnSendMessage" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
						<td class="FontHead" align="right" width="75">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<table cellSpacing="0" cellpadding="0" width="800" border="0">
					<tr>
						<td style="WIDTH: 453px" valign="top" bgColor="#ffffff">
							<table class="TableHeader" height="24" cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr valign="middle">
									<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td><asp:Label ID="lblSendTo" runat="server" Text="Send To..."></asp:Label></td>
								</tr>
							</table>
							<asp:datalist id="dlTeam" runat="server" Width="100%" ShowFooter="False" CellPadding="0" CellSpacing="1"
								DataKeyField="TeamID" BorderWidth="0" BorderStyle="None">
								<HeaderTemplate>
									<table>
										<tr>
											<td colspan="3" class="fontHead">&nbsp;<%#GetSystemText("Select Team")%>...</td>
										</tr>
									</table>
								</HeaderTemplate>
								<AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="font" BackColor="AliceBlue"></ItemStyle>
								<ItemTemplate>
									<table>
										<tr>
											<td width="20">
												<asp:CheckBox ID="chkTeam" runat="server"></asp:CheckBox></td>
											<td class="font" width="125"><%#Container.DataItem("FirstName")%>&nbsp;<%#Container.DataItem("LastName")%></td>
											<td class="font"><%#Container.DataItem("Email")%>
												<INPUT id="Mail" type="hidden" runat="server" NAME="Mail" value='<%# Container.DataItem("Email")%>'>
												<INPUT id="To" type="hidden" runat="server" NAME="To" value='<%#Container.DataItem("FirstName") & " " & Container.DataItem("LastName")%>'>
											</td>
										</tr>
									</table>
								</ItemTemplate>
								<HeaderStyle Height="24px" CssClass="TableHeaderOver"></HeaderStyle>
							</asp:datalist>
							<asp:datalist id="dlTradePartner" runat="server" Width="100%" ShowFooter="False" CellPadding="0"
								DataKeyField="TradePartnerID">
								<HeaderTemplate>
									&nbsp;<%#GetSystemText("Select Trade Partner")%>...
								</HeaderTemplate>
								<AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="font" BackColor="AliceBlue"></ItemStyle>
								<ItemTemplate>
									<table height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
										<tr>
											<td class="fontHead">&nbsp;<%# DataBinder.Eval(Container.DataItem, "TradePartnerName")%></td>
										</tr>
									</table>
									<asp:DataGrid id=dgTradeContact runat="server" Width="100%" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="TradePartnerContactId" DataSource='<%# TradePartnerContactDataTable(DataBinder.Eval(Container.DataItem, "TradePartnerId").ToString) %>' ShowHeader="False">
										<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
										<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
										<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
										<Columns>
											<asp:TemplateColumn ItemStyle-Width="20px">
												<HeaderTemplate>
												</HeaderTemplate>
												<ItemTemplate>
													<INPUT type="checkbox" name='<%#Container.DataItem("TradePartnerContactID").Tostring%>' value='<%#Container.DataItem("TradePartnerContactID").Tostring%>'>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn ItemStyle-Width="125px">
												<HeaderTemplate>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:Label id="lblContactName" runat="server"><%#Container.DataItem("FirstName")%>&nbsp;<%#Container.DataItem("LastName")%></asp:Label>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:Label id="lblContactEmail" runat="server">
														<%#Container.DataItem("Email").ToString%>
													</asp:Label>
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
									</asp:DataGrid>
								</ItemTemplate>
								<HeaderStyle Height="24px" CssClass="TableHeaderOver"></HeaderStyle>
							</asp:datalist>
							<table cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td width="10">&nbsp;</td>
									<td class="fontHead" style="WIDTH: 67px" width="67">&nbsp;</td>
									<td>
										<asp:RequiredFieldValidator id="rfvSubject" runat="server" CssClass="fontHead" ControlToValidate="txtSubject"></asp:RequiredFieldValidator></td>
								</tr>
								<tr>
									<td style="HEIGHT: 3px" width="10">&nbsp;</td>
									<td class="fontHead" style="WIDTH: 67px; HEIGHT: 3px" width="67">Subject:</td>
									<td style="HEIGHT: 7px">
										<asp:textbox id="txtSubject" runat="server" Width="325px"></asp:textbox></td>
								</tr>
								<tr>
									<td style="HEIGHT: 100px" width="10">&nbsp;</td>
									<td class="fontHead" style="WIDTH: 68px; HEIGHT: 100px" valign="top" width="68">
										<table id="Table3" height="5" cellSpacing="0" cellpadding="0" width="100%" border="0">
											<tr>
												<td></td>
											</tr>
										</table>
										<asp:Label ID="lblMessage" runat="server" Text="Message:"></asp:Label></td>
									<td style="HEIGHT: 100px">
										<asp:textbox id="txtMessage" runat="server" Width="325px" TextMode="MultiLine" Height="200px"></asp:textbox></td>
								</tr>
							</table>
							<BR>
							<asp:label id="txtMessageHistory" runat="server"></asp:label></td>
						<td valign="top" bgColor="#ffffff">
							<asp:datalist id="dlMessageVariation" runat="server" Width="300px">
								<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="LightGray"
									VerticalAlign="Top" BackColor="White"></ItemStyle>
								<ItemTemplate>
									<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0" height="24">
										<tr valign="middle">
											<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
											<td>
												<asp:Label id="lblVariationSend" runat="server" CssClass="fontHead" Text='<%# string.Concat("Variation " + DataBinder.Eval(Container.DataItem, "Variation").ToString) %>'>
												</asp:Label></td>
										</tr>
									</table>
									<uc1:Style_Quote_Variation_Message id="Style_Quote_Variation_Message1" StyleQuoteID = '<%# Request.Querystring("SQID") %>' StyleDevelopmentID ='<%# string.Concat(DataBinder.Eval(Container.DataItem, "StyleDevelopmentID").ToString) %>' StyleVariation = '<%# string.Concat(DataBinder.Eval(Container.DataItem, "Variation").ToString) %>' runat="server">
									</uc1:Style_Quote_Variation_Message>
								</ItemTemplate>
								<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
							</asp:datalist></td>
					</tr>
				</table>
			</asp:panel>
			<asp:Panel id="pnlLog" runat="server">
				<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td width="80">
							<cc1:confirmedimagebutton id="btnDeleteLog" runat="server" ></cc1:confirmedimagebutton></td>
						<td class="FontHead" align="right" width="75">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<asp:DataGrid id="dgLog" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
					AutoGenerateColumns="False">
					<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
					<Columns>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<%#GetSystemText("Status")%> 
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblStatus" runat="server" text='<%#Container.DataItem("StyleMessageLog").ToString%>'/>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<%#GetSystemText("Created By")%>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:Label id="lblCreatedby" runat="server"><%#Container.DataItem("CUser")%>&nbsp;<%# SystemHandler.GetLocalTime(Container.DataItem("CDate"))%></asp:Label>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:DataGrid>
			</asp:Panel>
			<BR>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
