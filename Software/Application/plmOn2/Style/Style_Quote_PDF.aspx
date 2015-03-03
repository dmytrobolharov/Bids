<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Quote_PDF.aspx.vb" Inherits="plmOnApp.Style.Quote.StyleQuotePDF" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>RFQ Pdf...</title>	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
				<tr>
					<td width="800"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0" bgColor="#ffffff">
				<tr>
					<td valign="top" width="400">
						<asp:datagrid id="DataGrid1" runat="server" Width="100%" OnItemDataBound="DataGrid1_ItemEventArgs"
							AutoGenerateColumns="False" PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
							EnableViewState="true">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemStyle Width="20px"></ItemStyle>
									<ItemTemplate>
										<INPUT type="hidden" value='<%#Container.DataItem("WorkFlowID")%>' name='hdWorkflow' ID='hdWorkflow' runat="server">
										<asp:CheckBox ID="cbWorkflow" runat="server" Visible='true'></asp:CheckBox>
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
										<asp:Label ID="lblHeaderTechPage" runat="server"><%#GetSystemText("Quotation Pages")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label ID="lblTechPage" runat="server"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td valign="top">
						<cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
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
