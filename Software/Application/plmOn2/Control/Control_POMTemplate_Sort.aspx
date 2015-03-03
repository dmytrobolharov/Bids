<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_POMTemplate_Sort.aspx.vb" Inherits="plmOnApp.Control_POMTemplate_Sort" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Sort</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<asp:Panel id="pnlSort" runat="server">
				<TABLE cellSpacing="0" cellPadding="0" border="0">
					<TR vAlign="middle">
						<TD width="150">
							<asp:label id="lblSortBy" CssClass="font" Runat="server" Font-Bold="True"></asp:label>&nbsp;
							<asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></TD>
						<TD>
							<cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
					</TR>
				</TABLE>
			</asp:Panel>
			<asp:datagrid id="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
				BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="POMTempItemID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="lblPOMHeader" runat="server"><%#GetSystemText("POM")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<%#DataBinder.Eval(Container.DataItem,"POM").tostring%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="Label1" runat="server"><%#GetSystemText("Description")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<%#DataBinder.Eval(Container.DataItem,"PointMeasur").tostring%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="Label2" runat="server"><%#GetSystemText("Sort")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox runat="server" ID="txtSort" Text='<%#DataBinder.Eval(Container.DataItem,"Sort").tostring%>' Width="40" MaxLength="4">
							</asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
