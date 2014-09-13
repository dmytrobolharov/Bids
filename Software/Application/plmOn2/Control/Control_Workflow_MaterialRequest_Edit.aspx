<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Workflow_MaterialRequest_Edit.aspx.vb" Inherits="plmOnApp.Control_Workflow_MaterialRequest_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Worklflow</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="550">
					<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="imgAdd" runat="server" ></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnDelete" runat="server"  ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
					<td valign="middle" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td valign="middle" width="140"><asp:label id="lblSortBy" CssClass="font" Runat="server" Font-Bold="True"><b>&nbsp; 
								</b></asp:label><asp:dropdownlist id="ddlSortBy" Runat="server">
							<asp:ListItem ></asp:ListItem>
						</asp:dropdownlist></td>
					<td valign="middle">
					    <cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<br>
			<table cellSpacing="0" cellPadding="0" border="0">
				<tr>
					<td vAlign="top"><asp:datagrid id="DataGrid1" runat="server" Width="600px" AutoGenerateColumns="False" PageSize="100"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										 <asp:Label ID="lblWorkflowHeader" runat="server"><%# GetUserText("Workflow")%></asp:Label>	
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server">Label</asp:Label><INPUT id="txtWorkflow" type="hidden" runat="server">
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblAssignedHeader" runat="server"><%# GetUserText("Assigned To")%></asp:Label>	
									</HeaderTemplate>
									<ItemTemplate>
										<asp:DropDownList id="dlAssignedTo" runat="server"></asp:DropDownList>
										<asp:RequiredFieldValidator id="rvAssignedTo" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="dlAssignedTo"
											ToolTip="Select User..." Display="Dynamic">*</asp:RequiredFieldValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
                                <asp:TemplateColumn>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblPartnerOwner" runat="server"><%# GetUserText("Partner Owner")%></asp:Label>	
									</HeaderTemplate>
									<ItemTemplate>
										<asp:DropDownList id="dlPartnerOwner" runat="server"></asp:DropDownList>
										<asp:RequiredFieldValidator id="rvPartnerOwner" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="dlPartnerOwner"
											ToolTip="Select Partner..." Display="Dynamic">*</asp:RequiredFieldValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="50px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblDaysHeader" runat="server"> <%# GetUserText("Submit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtDays" runat="server" Width="60px" MaxLength="5"></asp:TextBox>
<%--										<asp:RegularExpressionValidator id="rvDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtDays"
											ValidationExpression="^[0-9]+[0-9]{0,2}$" ToolTip="Between 0 to 999 Days" Display="Dynamic"></asp:RegularExpressionValidator>
--%>										<asp:RangeValidator id="rvDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtDays"
											    Type="Integer" MinimumValue="-9999" MaximumValue="99999" ToolTip="Invalid integer format!" Display="Dynamic"></asp:RangeValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
                                <asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="50px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<asp:Label ID="lblDaysHeader" runat="server"> <%# GetUserText("Resubmit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtResubmitDays" runat="server" Width="60px" MaxLength="5"></asp:TextBox>
<%--										<asp:RegularExpressionValidator id="rvDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtDays"
											ValidationExpression="^[0-9]+[0-9]{0,2}$" ToolTip="Between 0 to 999 Days" Display="Dynamic"></asp:RegularExpressionValidator>
--%>										<asp:RangeValidator id="rvResubmitDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtResubmitDays"
											    Type="Integer" MinimumValue="-9999" MaximumValue="99999" ToolTip="Invalid integer format!" Display="Dynamic"></asp:RangeValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										 <asp:Label ID="lblAlertsHeader" runat="server" ><%# GetUserText("Alerts")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtAlerts" runat="server" Width="40px" MaxLength="5"></asp:TextBox>
<%--										<asp:RegularExpressionValidator id="rvAlerts" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtAlerts"
											ValidationExpression="^[0-9]+[0-9]{0,2}$" ToolTip="Between 0 to 999 Days" Display="Dynamic"></asp:RegularExpressionValidator>
--%>										<asp:RangeValidator id="rvAlerts" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtAlerts"
											    Type="Integer" MinimumValue="-9999" MaximumValue="99999" ToolTip="Invalid integer format!" Display="Dynamic"></asp:RangeValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblSort" runat="server">
                                                <asp:Label ID="lblOrderHeader" runat="server"><%# GetUserText("Order")%></asp:Label></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSort" runat="Server" maxlength="2" Width="40px"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
