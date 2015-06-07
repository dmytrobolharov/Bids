<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Workflow_Sample_Edit.aspx.vb" Inherits="plmOnApp.Control_Workflow_Sample_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Style</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSaveClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnAdd" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnDelete" runat="server" CausesValidation="False"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"><asp:datagrid id="DataGrid1" runat="server" Width="800px" 
							AutoGenerateColumns="False" PageSize="100" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="200px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblWorkflowH" runat="server"><%#GetSystemText("Workflow")%></asp:Label>	
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblWorkflow" runat="server">Label</asp:Label><INPUT id="txtWorkflow" type="hidden" runat="server">
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblAssignedToH" runat="server" ><%#GetSystemText("Assigned To")%></asp:Label>
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
                                        <asp:Label ID="lblPartnerOwner" runat="server" ><%#GetSystemText("Partner Owner")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:DropDownList id="dlPartnerOwner" runat="server"></asp:DropDownList>
										<asp:RequiredFieldValidator id="rvPartnerOwner" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="dlPartnerOwner"
											ToolTip="Select Patrner Type..." Display="Dynamic">*</asp:RequiredFieldValidator>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblSubmitDays" runat="server"><%#GetSystemText("Submit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtDays" runat="server" Width="40px" MaxLength="5"></asp:TextBox>
<%--										<asp:RegularExpressionValidator id="rvDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtDays"
											ValidationExpression="^[0-9]+[0-9]{0,2}$" ToolTip="Between 0 to 999 Days" Display="Dynamic"></asp:RegularExpressionValidator>
--%>										<asp:RangeValidator id="rvDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtDays"
											    Type="Integer" MinimumValue="-9999" MaximumValue="99999" ToolTip="Invalid integer format!" Display="Dynamic"></asp:RangeValidator>									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblResubmitDays" runat="server" ><%#GetSystemText("Resubmit Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtRDays" runat="server" Width="40px" MaxLength="5"></asp:TextBox>
<%--										<asp:RegularExpressionValidator id="rvRDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtRDays"
											ValidationExpression="^[0-9]+[0-9]{0,2}$" ToolTip="Between 0 to 999 Days" Display="Dynamic"></asp:RegularExpressionValidator>
--%>										<asp:RangeValidator id="rvRDays" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtRDays"
											    Type="Integer" MinimumValue="-9999" MaximumValue="99999" ToolTip="Invalid integer format!" Display="Dynamic"></asp:RangeValidator>									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblAlertDays" runat="server"><%#GetSystemText("Alert Days")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtAlerts" runat="server" Width="40px" MaxLength="5"></asp:TextBox>
<%--										<asp:RegularExpressionValidator id="rvAlerts" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtAlerts"
											ValidationExpression="^[0-9]+[0-9]{0,2}$" ToolTip="Between 0 to 999 Days" Display="Dynamic"></asp:RegularExpressionValidator>
--%>										<asp:RangeValidator id="rvAlerts" runat="server" CssClass="fontHead" ErrorMessage="*" ControlToValidate="txtAlerts"
											    Type="Integer" MinimumValue="-9999" MaximumValue="99999" ToolTip="Invalid integer format!" Display="Dynamic"></asp:RangeValidator>									</ItemTemplate>
								</asp:TemplateColumn>
								
								<asp:TemplateColumn>
									<HeaderStyle Height="20px" Width="75px" CssClass="TableHeader"></HeaderStyle>
									<HeaderTemplate>
                                        <asp:Label ID="lblFinalDateH" runat="server"><%#GetSystemText("Final Date")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtFinalDate" runat="server" Width="70px" MaxLength="10" ReadOnly="true"></asp:TextBox><asp:Label ID="lblLink" runat="server" ></asp:Label>
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
</HTML>
