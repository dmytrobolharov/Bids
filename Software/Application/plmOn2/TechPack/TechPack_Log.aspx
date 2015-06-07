<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Log.aspx.vb" Inherits="plmOnApp.TechPack_Log" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Tech Pack Log</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body onblur="this.focus();" onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td height="20"><cc1:confirmedimagebutton id="btnTechDelete" runat="server" Message="Are you sure you want to delete tech pack log?"
							></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:Label ID="lblHeader" runat="server" Text="Tech Pack Log..."></asp:Label>
&nbsp;</td>
				</tr>
			</table>
			<asp:datagrid id="dgTechActive" runat="server" AutoGenerateColumns="False" PageSize="100" BorderWidth="1px"
				BorderStyle="Solid" BorderColor="#E0E0E0" ShowHeader="False" Width="100%">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Width="100%"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<ItemStyle Width="20px"></ItemStyle>
						<ItemTemplate>
							<%#Container.DataItem("TechPackLogID")%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<ItemTemplate>
							<%#Container.DataItem("TechPackLog")%>
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
