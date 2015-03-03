<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Image_Item_Delete.aspx.vb" Inherits="plmOnApp.Material_Image_Item_Delete"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title><%= GetSystemText("Material Color")%></title>
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
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material Color</asp:label></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" Width="355px" AutoGenerateColumns="False" PageSize="100"
				BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" DataKeyField="MaterialColorID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Width="25px"></HeaderStyle>
						<ItemStyle HorizontalAlign="Center" Width="25px" VerticalAlign="Middle" BackColor="Red"></ItemStyle>
						<HeaderTemplate>
							<asp:Image id="imgDelete" runat="server" ImageUrl="../System/Icons/icon_delete.gif"></asp:Image>
							<INPUT id="checkAll" onclick="CheckAll(this);" type="hidden" name="checkAll" runat="server">
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					    <HeaderTemplate>
							<asp:Label runat="server" ><%=GetSystemText("Image")%></asp:Label>
						</HeaderTemplate>
						<ItemStyle Width="130px"></ItemStyle>
						<ItemTemplate>
							<asp:Image id="imgFile" runat="server"></asp:Image>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate ><asp:Label Runat =server ID="lblColorNameHeader" ></asp:Label></HeaderTemplate>
						<ItemStyle Width="200px"></ItemStyle>
						<ItemTemplate>
							<asp:Label id="lblColorName" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox ) {
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)		{
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
</HTML>
