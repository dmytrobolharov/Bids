<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_DetailGrid_Delete.aspx.vb" Inherits="plmOnApp.Control_DetailGrid_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Delete</title>
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
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<br />
			<asp:CheckBox runat="server" ID="chkDeleteTemplate"    CssClass="fontRed"  Font-Bold="true" />
			<br /><br />
			<asp:datagrid id="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
				BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="TemplateDetailGridItemId">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle CssClass="TableHeaderRed" Width="20"></HeaderStyle>
						<ItemStyle BackColor="Pink"></ItemStyle>
						<HeaderTemplate>
							<img id="checkAll" src="../System/Icons/icon_delete.gif" />
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server" ToolTip="Remove item..."></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
