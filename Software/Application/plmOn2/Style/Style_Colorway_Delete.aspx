<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Colorway_Delete.aspx.vb" Inherits="plmOnApp.Style.Colorway.Style_Colorway_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="TableHeader" cellspacing="0" cellpadding="0" width="100%"
				border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="imgBtnsave" runat="server" Message="NONE" 
							ToolTip="Save Material..."></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnMaterialClose" runat="server" Message="NONE"
						 ToolTip="Close it and Go to Material List..."></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<tr>
						<td>
							<UL class="fonthead">
								<LI>
								<%=GetSystemText("Click on check box to delete")%> &nbsp; <%= Me.strColorway %>
								<LI>
								<%=GetSystemText("Enter Order number to sort")%>  &nbsp; <%= Me.strColorway %></LI></UL>
						</td>
					</tr>
				</TBODY>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td><asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="false" OnItemDataBound="DataGrid1_ItemEventArgs"
							DataKeyField="StyleColorID">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" NAME="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="Label1" runat="server"><%#GetSystemText("Order")%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox ID="txtSort" Runat="server" Columns="5" MaxLength="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="Label2" runat="server"><%= Me.strColorway %></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox ID="txtMainColor" Runat="server"></asp:TextBox>
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
	</body>
</html>
