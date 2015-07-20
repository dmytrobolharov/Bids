<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Vendor_Replace.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Vendor_Replace" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
			<TABLE height="35" cellSpacing="1" cellPadding="1" width="375" border="0">
				<TR>
					<TD class="fontHead" style="WIDTH: 58px">
						<P align="center">
                            <asp:Label ID="lblSearchH" runat="server" ></asp:Label></P>
					</TD>
					<TD width="200"><asp:textbox id="txtSearch" runat="server" Width="250px"></asp:textbox></TD>
					<TD><asp:imagebutton id="btnSearch" runat="server" ></asp:imagebutton></TD>
				</TR>
			</TABLE>
			<asp:datagrid id="dgPartnerVendor" runat="server" Width="400" DataKeyField="TradePartnerVendorID"
				AutoGenerateColumns="false">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate" BackColor="White"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Width="25px"></HeaderStyle>
						<ItemTemplate>
							<cc1:ConfirmedImageButton id="btnSelect" runat="server"  Message="NONE"
								CommandName="Select"></cc1:ConfirmedImageButton>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderVendorCode" runat="server" CssClass="fontHead"><%#GetSystemText("Vendor Code")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblVendorCode" runat="server" CssClass="font"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderVendorName" runat="server" CssClass="fontHead"><%#GetSystemText("Vendor Name")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblVendorName" runat="server" CssClass="font"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							&nbsp;
							<asp:Label id="lblHeaderVendorCountry" runat="server" CssClass="fontHead"><%#GetSystemText("Country")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblVendorCountry" runat="server" CssClass="font"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid></form>
            <script language="javascript">
	            function btnClose_Click() {
		            <%= strExitScript %>
                    return false;
                }
            </script>
	</body>
</HTML>
