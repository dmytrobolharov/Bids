<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_Style_ColorRemove.aspx.vb" Inherits="plmOnApp.Line_List_Folder_Style_ColorRemove" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Remove Color</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="TableHeader" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="imgBtnsave" runat="server" ToolTip="Save ..." 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnMaterialClose" runat="server" ToolTip="Close ..."
							 Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<TR>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleColorID" OnItemDataBound="DataGrid1_ItemEventArgs"
							AutoGenerateColumns="false" Width="300px">
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
								<asp:TemplateColumn HeaderStyle-Width="75">
									<HeaderTemplate>										
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label ID="txtColorCombo" Runat="server"></asp:Label>
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
</HTML>
