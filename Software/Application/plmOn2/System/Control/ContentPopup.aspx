<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ContentPopup.aspx.vb" Inherits="plmOnApp.ContentPopup"   %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Select</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../CSS/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			function SelectWindowCustom(sValue,sTxtBox) 
			{
			opener.document.Form1[sTxtBox].value = sValue;
			self.close();
            }
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" >
        
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server" CausesValidation="True" ValidationGroup="Group1" Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0" bgColor="#ffffff">
				<TR>
					<TD width="25" height="30">&nbsp;</TD>
					<TD height="30">&nbsp;
						<asp:Label id="lblHeader" runat="server" CssClass="fonthead"></asp:Label></TD>
				</TR>
			</TABLE>
			<asp:datagrid id="dgContent" runat="server" Width="500px" AutoGenerateColumns="False" PageSize="100"
				BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Width="25px"></HeaderStyle>
						<HeaderTemplate>
							&nbsp;
							<asp:Image id="imgDelete" runat="server" ImageUrl="../Icons/icon_delete.gif"></asp:Image>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Content %">
						<HeaderStyle Width="100px"></HeaderStyle>
						<ItemTemplate>
    						<asp:TextBox id="txtContentPerc" runat="Server"  MaxLength="4" Columns="10"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="txtContentPerc" Display="Static" ErrorMessage="*" tooltip="Numbers only" ValidationExpression="^\d+$" runat="server" ValidationGroup="Group1" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" tooltip="Numbers only" ControlToValidate="txtContentPerc" ValidationExpression="^([1-9]+[0-9]*)$" ValidationGroup="Group1">*</asp:RegularExpressionValidator>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Content Type">
						<ItemTemplate>
							<asp:DropDownList id="dpContentType" runat="server" CssClass="font" Width="125px" AutoPostBack="True"
								OnSelectedIndexChanged="dpContentType_SelectedIndexChanged"></asp:DropDownList>
							<asp:TextBox id="txtMaterialContentId" runat="server" Visible="False"></asp:TextBox>
							<asp:TextBox id="txtMaterialContentName" runat="server" Visible="False"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
	</body>
</HTML>
