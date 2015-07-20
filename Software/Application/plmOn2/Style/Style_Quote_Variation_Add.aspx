<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_Variation_Add.aspx.vb" Inherits="plmOnApp.Style.Quote.Style_Quote_Variation_Add" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Image_Folder</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" autocomplete="on">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblImageHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Select Style...</asp:label></td>
				</tr>
			</table>

			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<tr valign="top">
						<td width="400">
							<table borderColor="#ffffff" cellSpacing="2" cellpadding="2" width="400" border="3">
								<TBODY>
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
								</TBODY>
							</table>
						</td>
						<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					</tr>
				</TBODY>
			</table>
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
			<table cellSpacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top"><asp:datalist id="DataList1" runat="server" Width="100%" DataKeyField="StyleID" RepeatColumns="100"
							RepeatDirection="Horizontal" EnableViewState="True">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table class="TableHeader" height="24" cellSpacing="0" cellpadding="0" width="100%" border="0">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:Label id="Label1" runat="server" CssClass="fontHead" Text='<%# IIf(DataBinder.Eval(Container.DataItem, "StyleDevelopmentName").ToString = "", GetSystemText("Variation") + " " + DataBinder.Eval(Container.DataItem, "Variation").ToString, DataBinder.Eval(Container.DataItem, "StyleDevelopmentName").ToString) %>'>
											</asp:Label></td>
									</tr>
								</table>
								<table class="TableHeaderBlue" id="Table6" height="25" cellSpacing="0" cellpadding="0"
									width="100%" border="0" runat="server">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:Label id="lblVariationSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>'>
											</asp:Label></td>
									</tr>
								</table>
								<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
									<tr>
										<td height="25">&nbsp;
											<asp:CheckBox id="cbSelectStyle" runat="server" ForeColor="Crimson" CssClass="fontHead" Text="Click here to select style..."></asp:CheckBox></td>
									</tr>
								</table>
								<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
									<tr>
										<td valign="middle" align="center" width="25">&nbsp;</td>
										<td class="fonthead" width="75">
											<asp:Label id="lblCostingType" runat="server" Text='<%#GetSystemText("Costing Type")%>'></asp:Label></td>
										<td>
											<asp:DropDownList id="ddlCosting" runat="server"></asp:DropDownList></td>
									</tr>
								</table>
								<table borderColor="silver" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<tr>
										<td valign="top" width="200" bgColor="#ffffff" height="150"><BR>
											<IMG alt="" id="ImgQuoteVarAdd" runat="server"  ></td>
									</tr>
									<tr>
										<td>
											<table>
												<tr>
													<td class="font">
														<asp:Label id="lbStyleNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "StyleNo") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id="lbSizeRange" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeRange") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id="lbSizeClass" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "SizeClass") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id="lbImgDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'>
														</asp:Label></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								<input id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "DesignSketchID") %>' name="txtImageID" runat="server" />
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></td>
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
