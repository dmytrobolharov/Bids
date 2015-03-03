<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_TradePartnerVendor_Sort.aspx.vb" Inherits="plmOnApp.Material_TradePartnerVendor_Sort"%>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Material TradePartner Vendor Sort</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
				</tr>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material Summary</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" bgColor="#ffffff" border="0">
				<tr>
					<TD><asp:label id="lblSortBy" Runat="server" CssClass="font"><b>&nbsp;Sort by:</b></asp:label></TD>
					<TD><asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></TD>
					<TD><cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
				</tr>
				<tr>
					<td colspan="3"><asp:datagrid id="DataGrid1" runat="server" Width="370" AutoGenerateColumns="False" PageSize="100"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" DataKeyField="MaterialTradePartnerColorID">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="Image">
									<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80"></ItemStyle>
									<ItemTemplate>
										<asp:Image id="imgFile" runat="server"></asp:Image>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
									<HeaderTemplate>
										<asp:Label id="lblHeaderColorCode" runat="server" > <%#strColor + " " + GetSystemText("Code")%></asp:Label>
									</HeaderTemplate>
									<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100"></ItemStyle>
									<ItemTemplate>
										<asp:Label id="lblColorCode" runat="server">
											<%#  DataBinder.Eval(Container.DataItem, "ColorCode")%>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn >
									<HeaderTemplate>
										<asp:Label id="lblHeaderColorName" runat="server" > <%#GetSystemText(strColorName)%></asp:Label>
									</HeaderTemplate>

									<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100"></ItemStyle>
									<ItemTemplate>
										<asp:Label id="lblColorName" runat="server">
											<%#  DataBinder.Eval(Container.DataItem, "ColorName")%>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="Sort">
									<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40"></ItemStyle>
									<ItemTemplate>
										<asp:TextBox ID="txtSort" Runat="server" Width="40" MaxLength="4" Text='<%#  DataBinder.Eval(Container.DataItem, "Sort") %>' >
										</asp:TextBox>
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
