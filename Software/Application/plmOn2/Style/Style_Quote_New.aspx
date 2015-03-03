<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_New.aspx.vb" Inherits="plmOnApp.Style.Quote.Style_Quote_New" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>New Quotation</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" >
        function tradepopupwindow() {
            windowCustom = window.open('../System/Control/TradeQuotePopup.aspx?SID=<%= Request.QueryString("SID") %>&SDID=<%= Request.QueryString("SDID") %>',"TradeQuotePopup","toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=50,top=50");
            windowCustom.focus();
        }        
        </script>

	</head>
	<body MS_POSITIONING="GridLayout">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveStyle" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							CausesValidation="False"></cc1:confirmedimagebutton></td>
				</tr>
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
			<table height="90%" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" bgColor="#ffffff">
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td>
									<div align="right"><asp:label id="lblHeaderNew" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
											ForeColor="#E0E0E0">New Request for Quote</asp:label></div>
								</td>
							</tr>
						</table>
						<asp:panel id="pnlStyle" runat="server">
							<table height="100" cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr valign="top">
									<td style="WIDTH: 418px" valign="top" width="418">
										<table id="Table1" style="WIDTH: 416px; HEIGHT: 135px" cellSpacing="2" cellpadding="1"
											width="416" border="0">
											<tr>
												<td></td>
												<td style="WIDTH: 149px" valign="top" width="149">
													<asp:Label id=lbHeaderTradePartner runat="server" CssClass="fonthead" text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>'>
													</asp:Label><BR>
													<asp:RequiredFieldValidator id="rvTradePartnerId" runat="server" CssClass="fontHead" ControlToValidate="hdnTradePartnerId"
														ErrorMessage="Please select Agent..."></asp:RequiredFieldValidator></td>
												<td style="WIDTH: 201px" valign="top">
													<asp:TextBox id="txtTradePartner" runat="server" Width="200px"></asp:TextBox>
													<asp:TextBox id="txtAddress1" runat="server" Width="200px"></asp:TextBox>
													<asp:TextBox id="txtAddress2" runat="server" Width="200px"></asp:TextBox>
													<asp:TextBox id="txtCityState" runat="server" Width="200px"></asp:TextBox></td>
												<td valign="top"><A href="javascript:tradepopupwindow()"><IMG src="../System/Icons/icon_windowpopup.gif" border="0"></A></td>
											</tr>
										</table>
										<asp:TextBox id="hdnTradePartnerId" runat="server" Width="1px" Height="1px"></asp:TextBox></td>
									<td>
										<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
								</tr>
							</table>
						</asp:panel>
						<table height="100" cellSpacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr valign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
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
