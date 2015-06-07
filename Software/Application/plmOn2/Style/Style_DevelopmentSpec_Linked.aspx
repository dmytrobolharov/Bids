<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DevelopmentSpec_Linked.aspx.vb" Inherits="plmOnApp.Style.DevelopmentSpec.Style_DevelopmentSpec_Linked" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Linked POM</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="Do you want to break pom link ?"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td valign="top" width="600"><asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler" Width="400px">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblHeaderPOM" Text="POM" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<DIV align="center">
											<asp:Label id="lblPOM" runat="server" Width="50"></asp:Label></DIV>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="left">
											<asp:Label id="lblHeaderPointMeasur" Text='<%#GetSystemText("Point of Measurement")%>' runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblPointMeasur" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblHeaderTol" runat="server" ForeColor="Red">&nbsp;<%#GetSystemText("TOL")%>&nbsp;</asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:label id="lblTOL" runat="server" ForeColor="Red"></asp:label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblHeaderTolN" runat="server" ForeColor="Red"><%#GetSystemText("TOL(NONWASH)")%></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:label id="lblTOLN" runat="server" ForeColor="Red"></asp:label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<div align="center">
											<asp:Label id="lblSampleSize" runat="server" /></div>
									</HeaderTemplate>
									<ItemTemplate>
										<div align="center">
											<asp:Label id="lblSpec" runat="server" Width="50" /></div>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td valign="top">&nbsp;</td>
				</tr>
			</table>
		</form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox )
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
				e.checked= actVar ;
			}
			}
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
