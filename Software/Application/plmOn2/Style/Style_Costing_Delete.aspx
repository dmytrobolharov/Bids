<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Costing_Delete.aspx.vb" Inherits="plmOnApp.Style.Costing.Style_Costing_Delete" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Delete</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="TableHeader" cellspacing="0" cellpadding="0" width="100%"
				border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnDelete" runat="server" Message="Are you sure you want to delete selected costing?"
							 ToolTip="Delete Costing..."></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							ToolTip="Close Window..."></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="30" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<tr>
						<td>
							<UL class="fonthead">
								<LI>
									<%=GetSystemText("Click on check box to delete costing")%>
								</LI>
							</UL>
						</td>
					</tr>
				</TBODY>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td><asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="false" OnItemDataBound="DataGrid1_ItemEventArgs"
							DataKeyField="StyleCostingID" Width="100%">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn HeaderStyle-Width="20">
									<HeaderTemplate>
										<input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" NAME="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="lblCostingHeader" runat="server"><%#GetSystemText("Costing")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label ID="lblCostingType" Runat="server" CssClass="fontHead"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
		</form>
		<script language="javascript">
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
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
