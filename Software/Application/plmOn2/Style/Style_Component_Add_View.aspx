<%@ Register TagPrefix="uc1" TagName="ctrl_Style_Component_Where" Src="Style_Component_Where.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="../Material/Material_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Add_View.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Add_View" %>
<%@ Register TagPrefix="uc1" TagName="Style_Component_Header" Src="Style_Component_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Material_Edit</title>		
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body onblur="this.focus();" onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:panel id="Panel0" runat="server">
				<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
					<tr>
						<td></td>
					</tr>
				</table>
			</asp:panel><asp:panel id="Panel1" runat="server">
				<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
					runat="server">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td style="WIDTH: 93px">
							<cc1:confirmedimagebutton id="btnAddMaterial" runat="server" Message="NONE"
								></cc1:confirmedimagebutton></td>
						<td style="WIDTH: 122px">
							<asp:CheckBox id="cbMainMaterial" runat="server" Text="Main Material ?" ToolTip="Click here to select main material..."></asp:CheckBox></td>
						<td>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"
								></cc1:confirmedimagebutton></td>
					</tr>
				</table>
				<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
				<table cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr bgColor="#ffffff">
						<td valign="top" width="50%">
							<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="fontHead" width="100">
										<asp:label id="lblMaterialColor" runat="server">Material Colors</asp:label></td>
									<td></td>
								</tr>
							</table>
							<asp:datalist id="DataList1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
								RepeatColumns="7" DataKeyField="ColorPaletteID">
								<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro"></ItemStyle>
								<ItemTemplate>
									<table height="100" cellspacing="0" cellpadding="0" width="65" border="0">
										<tr height="50" width="65">
											<td bgColor='<%#(Container.DataItem("Hex").ToString)%>' valign=top>&nbsp;
											</td>
										</tr>
										<tr height="25">
											<td bgColor="#ffffff"><FONT color="#000000" size="1">
													<asp:label id="dlColorCode" runat="server">
														<%#(Container.DataItem("ColorCode").ToString)%>
													</asp:label></FONT></td>
										</tr>
										<tr height="25">
											<td bgColor="#ffffff"><FONT color="#000000" size="1">
													<asp:label id="dlColorName" runat="server">
														<%#(Container.DataItem("ColorName").ToString)%>
													</asp:label></FONT></td>
										</tr>
									</table>
									<INPUT id="Selected_ID" type="hidden" name="Selected_ID" runat="server"> <INPUT id="Selected_ColorSource" type="hidden" name="Selected_ColorSource" runat="server">
									<INPUT id="Selected_ColorNotes" type="hidden" name="Selected_ColorNotes" runat="server">
									<INPUT id="Selected_R" type="hidden" name="Selected_R" runat="server"> <INPUT id="Selected_G" type="hidden" name="Selected_G" runat="server">
									<INPUT id="Selected_B" type="hidden" name="Selected_B" runat="server"> <INPUT id="Selected_HEX" type="hidden" name="Selected_HEX" runat="server">
									<INPUT id="Selected_LL" type="hidden" name="Selected_LL" runat="server"> <INPUT id="Selected_LA" type="hidden" name="Selected_LA" runat="server">
									<INPUT id="Selected_LB" type="hidden" name="Selected_LB" runat="server">
								</ItemTemplate>
							</asp:datalist><BR>
						</td>
						<td valign="top" width="50%">
							<asp:datagrid id="Datagrid2" runat="server" DataKeyField="MaterialSizeID" Width="250" BorderColor="#E0E0E0"
								AutoGenerateColumns="False" PageSize="1000" BorderWidth="1px" BorderStyle="Solid" OnItemCommand="DataGrid2_ItemCommand"
								OnItemDataBound="DataGrid2_ItemEventHandler">
								<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
								<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<asp:Label id="lblMaterialSize" runat="server"></asp:Label>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="txtMaterialSize" runat="server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<DIV align="center">
												<asp:Label id="lblMaterialPrice" runat="server"></asp:Label></DIV>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="txtMaterialPrice" runat="Server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></td>
					</tr>
				</table>
			</asp:panel><asp:panel id="Panel2" runat="server">
				<asp:image id="imgMaterial" runat="server" BorderColor="Transparent"></asp:image>
			</asp:panel>
			<asp:panel id="Panel3" runat="server">
				<asp:datagrid id="dgStyletype" runat="server" Width="100%" BorderColor="Silver" AutoGenerateColumns="false"
					ShowHeader="False">
					<Columns>
						<asp:TemplateColumn>
							<ItemTemplate>
								<table cellspacing="0" cellpadding="0" width="100%" border="0">
									<tr class="TableHeader">
										<td width="10" bgColor="white" height="24"></td>
										<td class="fontHead" bgColor="white">Version No.
											<%# DataBinder.Eval(Container.DataItem, "MChange") %>
										</td>
									</tr>
								</table>
								<uc1:ctrl_Style_Component_Where id="Ctrl_Style_Component_Where1" runat="server" MV='<%# DataBinder.Eval(Container.DataItem, "MChange") %>' MTID='<%# DataBinder.Eval(Container.DataItem, "MaterialID") %>'>
								</uc1:ctrl_Style_Component_Where>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid>
			</asp:panel>
		</form>
	</body>
</html>
