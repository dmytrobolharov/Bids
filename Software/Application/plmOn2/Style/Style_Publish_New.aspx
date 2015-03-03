<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Publish_New.aspx.vb" Inherits="plmOnApp.PageStylePublishNew" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header>
			<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td class="fontHead" height="25">
						&nbsp;<asp:Label ID="lblPub" runat="server" Text="Publishing..."></asp:Label>
					</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0" bgColor="#ffffff">
				<tr>
					<td valign="top" width="400">
						<table cellSpacing="1" cellpadding="0" width="100%" bgColor="#cccccc" border="0">
							<tr class="fontHead" bgColor="#ffffff">
								<td style="WIDTH: 15px; HEIGHT: 20px" width="15" height="20">&nbsp;</td>
								<td style="HEIGHT: 20px" width="100" class="fontHead">
									<asp:Label ID="lblPubNo" runat="server" Text="Publish No.:"></asp:Label>
								</td>
								<td style="HEIGHT: 22px">&nbsp;<FONT color="#ff0000"> <asp:Label ID="lblAuto" runat="server" Text="[Auto Number]"></asp:Label></FONT></td>
							</tr>
							<tr class="fontHead" bgColor="#ffffff">
								<td style="WIDTH: 15px" width="15" height="20">&nbsp;</td>
								<td width="100" class="fontHead">
									<asp:Label ID="lblPubName" runat="server" Text="Publish Name:"></asp:Label>
								</td>
								<td>
									<asp:textbox id="txtPublishStyleName" runat="server" Width="225px" CssClass="font" MaxLength="100"></asp:textbox>
									<asp:RequiredFieldValidator id="rv_TechPackName" runat="server" CssClass="FontHead" ErrorMessage="*" ControlToValidate="txtPublishStyleName" Display="Dynamic"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td style="WIDTH: 15px" width="15" bgColor="#ffffff" height="20"></td>
								<td class="fontHead" width="100" bgColor="#ffffff"><asp:Label ID="lblStDt" runat="server" Text="Start Date:"></asp:Label></td>
								<td bgColor="#ffffff">
									<asp:TextBox id="txtStartDate" runat="server"></asp:TextBox><A href="javascript:calendar('txtStartDate')"><IMG height='17' src='../System/Icons/icon_calendar.gif' width='18' border='0'></A></td>
							</tr>
							<tr>
								<td style="WIDTH: 15px" width="15" bgColor="#ffffff" height="20"></td>
								<td class="fontHead" width="100" bgColor="#ffffff"><asp:Label ID="lblEdDt" runat="server" Text="End Date:"></asp:Label></td>
								<td bgColor="#ffffff">
									<asp:TextBox id="txtEndDate" runat="server"></asp:TextBox><A href="javascript:calendar('txtEndDate')"><IMG height='17' src='../System/Icons/icon_calendar.gif' width='18' border='0'></A></td>
							</tr>
							<tr>
								<td style="WIDTH: 15px" width="15" bgColor="#ffffff" height="20"></td>
								<td class="fontHead" width="100" bgColor="#ffffff"><asp:Label ID="lblPubSt" runat="server" Text="Publish Stage:"></asp:Label></td>
								<td bgColor="#ffffff">
									<asp:DropDownList id="ddlPublishStage" runat="server" Width="224px"></asp:DropDownList></td>
							</tr>
							<tr class="fontHead" bgColor="#ffffff">
								<td style="WIDTH: 15px" width="15" height="20">&nbsp;</td>
								<td width="100" class="fontHead"><asp:Label ID="lblNotes" runat="server" Text="Notes:"></asp:Label></td>
								<td>
									<asp:textbox id="txtPublishStyleNotes" runat="server" Width="225px" CssClass="font" MaxLength="4000"
										TextMode="MultiLine" Rows="5"></asp:textbox></td>
							</tr>
							<tr class="fontHead" bgColor="#ffffff">
								<td style="WIDTH: 15px" width="15" height="20">&nbsp;</td>
								<td colSpan="2" class="fontHead"></td>
							</tr>
							<tr class="fontHead" bgColor="#ffffff">
								<td style="WIDTH: 15px" width="15" height="20">&nbsp;</td>
								<td width="100" class="fontHead">&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
					<td valign="top">
						<asp:datagrid id="DataGrid1" runat="server" Width="100%" OnItemDataBound="DataGrid1_ItemEventArgs"
							AutoGenerateColumns="False" PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
							EnableViewState="true">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemStyle Width="1px"></ItemStyle>
									<ItemTemplate>
										<INPUT type="hidden" value='<%#Container.DataItem("WorkFlowID")%>' name='hdWorkflow' ID='hdWorkflow' runat="server">
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<ItemTemplate>
										<DIV align="center">
											<asp:Image id="Image1" runat="server"></asp:Image>
											<asp:Image id="Image2" runat="server"></asp:Image>
											<asp:Image id="Image3" runat="server"></asp:Image>
											<asp:Image id="Image4" runat="server"></asp:Image>
											<INPUT id="WorkStatus1" type="hidden" runat="server" NAME="WorkStatus1"> <INPUT id="WorkStatus2" type="hidden" runat="server" NAME="WorkStatus2">
											<INPUT id="WorkStatus3" type="hidden" runat="server" NAME="WorkStatus3"> <INPUT id="WorkStatus4" type="hidden" runat="server" NAME="WorkStatus4">
										</DIV>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label ID="lblHeaderTechPage" runat="server"><%#GetSystemText("Pages")%>...</asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label ID="lblTechPage" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
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
