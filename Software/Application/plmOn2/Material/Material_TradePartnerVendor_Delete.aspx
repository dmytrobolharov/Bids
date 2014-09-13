<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_TradePartnerVendor_Delete.aspx.vb" Inherits="plmOnApp.Material_TradePartnerVendor_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Material TradePartner Vendor Delete</title>
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
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
				</tr>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"> Material</asp:label></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" Width="330" AutoGenerateColumns="False" PageSize="100"
				BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" DataKeyField="MaterialTradePartnerColorID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="Red" Width="50"></ItemStyle>
						<HeaderTemplate>
							<div align="center">
								<INPUT id="checkAll" onclick="CheckAll(this);" type="checkbox" name="checkAll" runat="server">
							</div>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
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
					<asp:TemplateColumn >
						<HeaderTemplate>
							<asp:Label id="Label1" runat="server" > <%#GetSystemText(strColorSize)%></asp:Label>
						</HeaderTemplate>

						<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100"></ItemStyle>
						<ItemTemplate>
							<asp:Label id="Label2" runat="server">
								<%#  DataBinder.Eval(Container.DataItem, "MaterialSize")%>
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox ) {
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++) {
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
						e.checked= actVar ;
				}
			}
		</SCRIPT>
	</body>
</HTML>
