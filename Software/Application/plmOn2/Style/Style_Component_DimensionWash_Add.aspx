<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_DimensionWash_Add.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_DimensionWash_Add" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Material Dimension</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnRemove" runat="server" ToolTip="Remove..."  Message="Do you want to continue?"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
							ForeColor="#E0E0E0">Material Summary</asp:label></td>
				</tr>
			</table>
			<asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="False" Width="100%">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="Red"></ItemStyle>
						<HeaderTemplate>
							<asp:Image id="imgDelete" runat="server" ImageUrl="../System/Icons/icon_delete.gif"></asp:Image>
							<INPUT id="checkAll" onclick="CheckAll(this);" type="hidden" name="checkAll" runat="server">
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server" ForeColor="Red" ToolTip='<%#GetsystemText("click here to delete item") %>'></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#ffcc33"></ItemStyle>
						<HeaderTemplate>
						    <asp:Label id="lblHeaderDimension" runat="server" ><%#GetSystemText("Dimension") & "&nbsp;"%></asp:Label>
							<INPUT id="checkDimensionAll" onclick="CheckTrackAll(this);" type="hidden" name="checkDimensionAll"
								runat="server">
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDimension" runat="server" ToolTip='<%#GetsystemText("click here to add this item") %>'></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					    <HeaderTemplate>
					        <asp:Label id="lblHeaderImage" runat="server" ><%#GetSystemText("Image")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Image id=imgFile runat="server" >
							</asp:Image><INPUT id="txtMaterialID" type="hidden" runat="server"><INPUT id="txtMainMaterial" type="hidden" runat="server" NAME="txtMainMaterial">
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle HorizontalAlign="Center" Width="50px" CssClass="TableHeaderRed"></HeaderStyle>
						<ItemStyle HorizontalAlign="Center" BackColor="MistyRose"></ItemStyle>
						<HeaderTemplate>
					        <asp:Label id="lblHeaderMain" runat="server" ><%#"&nbsp;" & GetSystemText("Main") & "&nbsp;"%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblRadio" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					    <HeaderTemplate>
					        <asp:Label id="lblHeaderMaterial" runat="server" ><%#GetSystemText("Material")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblMaterial" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					     <HeaderTemplate>
					        <asp:Label id="lblHeaderTreatment" runat="server" ><%#GetSystemText("Treatment/Size")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:DropDownList id="dpSize" runat="server" CssClass="font" Width="100px"></asp:DropDownList>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					    <HeaderTemplate>
					        <asp:Label id="lblHeaderQty" runat="server" ><%#GetSystemText("Qty")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox ID="txtQty" runat="Server" Columns="5" MaxLength="10"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					    <HeaderTemplate>
					        <asp:Label id="lblHeaderUOM" runat="server" ><%#GetSystemText("UOM")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:DropDownList id="dpUOM" runat="server" CssClass="font" Width="50px"></asp:DropDownList>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					    <HeaderTemplate>
					        <asp:Label id="lblHeaderPrice" runat="server" ><%#GetSystemText("Price")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox ID="txtPrice" runat="Server" Columns="5" MaxLength="10"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					    <HeaderTemplate>
					        <asp:Label id="lblHeaderDetail" runat="server" ><%#GetSystemText("Detail")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<table cellspacing="1" cellpadding="1" width="100%" border="0">
								<tr>
									<td class="fontHead" width="90">
										<asp:CheckBox id="cbColorway" runat="server" Text='<%# string.Concat ( Me.strColorway) %>' ToolTip='<%# string.Concat(GetsystemText("Click here to add") &amp; Me.strColorway  &amp;  "..." ) %>' ></asp:CheckBox></td>
								</tr>
								<tr>
									<td class="fontHead" width="85">
										<asp:CheckBox id="cbArtwork" runat="server" Text='<%# string.Concat ( Me.strArtwork ) %>' ToolTip='<%# string.Concat(GetsystemText("Click here to add") &amp; Me.strArtwork &amp;  "..." ) %>'   ></asp:CheckBox></td>
								</tr>
								<tr>
									<td class="fontHead" width="85">
										<asp:CheckBox id="cbLicensee" runat="server" Text="Licensee" ToolTip='<%#GetsystemText("Click here to add licensee") & "..." %>'></asp:CheckBox></td>
								</tr>
							</table>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					    <HeaderTemplate>
					        <asp:Label id="lblHeaderSort" runat="server"><%#GetSystemText("Sort")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox id="txtSort" runat="Server" Columns="5" MaxLength="4"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
					     <HeaderTemplate>
					        <asp:Label id="lblHeaderPlacement" runat="server"><%#GetSystemText("Placement")%></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:TextBox id="txtPlacement" runat="server" Width="200px" Rows="4" MaxLength="4000" TextMode="MultiLine"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
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
			function CheckTrackAll( checkAllBox )
			{
			var actVar = checkTrackAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("chkTrack") != -1 )
				e.checked= actVar ;
			}
			}			
		</SCRIPT>
	</body>
</html>
