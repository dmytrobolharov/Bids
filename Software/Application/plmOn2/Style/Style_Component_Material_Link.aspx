<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Material_Link.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Material_Link" %>
<%@ Register TagPrefix="uc1" TagName="Style_Component_Header" Src="Style_Component_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Material_Link_Item" Src="..\Material\Material_Link_Item.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Component_Add_Version" Src="Style_Component_Add_Version.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style_Component_Material_Link</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<uc1:style_component_add_version id="Style_Component_Add_Version1" runat="server"></uc1:style_component_add_version><br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<asp:panel id="pnlMultiDimension" runat="server">
				<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr valign="middle">
						<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td width="80">&nbsp;</td>
						<td width="80"></td>
						<td width="75">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<table height="5" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
					<tr>
						<td></td>
					</tr>
				</table>
				<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
					height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td>&nbsp;
							<asp:Label id="lblMaterial" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material</asp:Label></td>
					</tr>
				</table>
				<table id="Table18" cellspacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<UC1:STYLE_COMPONENT_HEADER id=Style_Component_Header2 runat="server" SMID='<%# Request.Querystring("SMID") %>'>
							</UC1:STYLE_COMPONENT_HEADER></td>
						<td></td>
					</tr>
				</table>
				<table id="Table14" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr bgColor="#ffffff">
						<td valign="top">
							<asp:datagrid id="dgComponent" runat="server" ShowHeader="False" AutoGenerateColumns="false" BorderColor="Silver"
								Width="100%">
								<Columns>
									<asp:TemplateColumn>
										<ItemTemplate>
											<table cellspacing="0" cellpadding="0" width="100%" border="0">
												<tr class="TableHeader">
													<td width="10" bgColor="white" height="24"></td>
													<td class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></td>
												</tr>
											</table>
											<uc1:Material_Link_Item id="Material_Link_Item1" runat="server" CTID='<%# DataBinder.Eval(Container.DataItem, "MaterialType") %>' MGID='<%# _MaterialID  %>' >
											</uc1:Material_Link_Item>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></td>
					</tr>
				</table>
			</asp:panel>
			<asp:panel id="pnlColorway" runat="server"><BR><BR><!-----  COLORS ----->
<asp:datalist id="DataList2" runat="server" cellspacing="0" CellPadding="0" BorderWidth="0" OnItemDataBound="DataList2_ItemEventArgs"
					RepeatColumns="3" RepeatDirection="Horizontal" DataKeyField="MaterialLinkColorwayID">
					<ItemStyle HorizontalAlign="Left" VerticalAlign="Top" BackColor="White"></ItemStyle>
					<ItemTemplate>
						<table borderColor="darkgray" cellspacing="0" borderColorDark="gainsboro" cellpadding="0"
							width="100%" borderColorLight="ghostwhite" border="0">
							<TBODY>
								<tr>
									<td id="TH_Material" width="400" runat="server" Class="TableHeaderGreen50" >
										<asp:datalist id=DataList1 runat="server" EnableViewState="true" DataKeyField="MaterialLinkColorwayItemID" Width="100%" Enabled="true" 
											DataSource='<%#ColorwayItemDataSource( DataBinder.Eval(Container.DataItem, "MaterialLinkColorwayID") )%>' 
											GridLines="Horizontal" BorderColor="Gainsboro" BorderStyle="Solid">
											<ItemStyle CssClass="font"></ItemStyle>
											<HeaderStyle CssClass="fontHead" Height="47" ></HeaderStyle>
											<HeaderTemplate>
										<%#GetSystemText("Material")%>:</td>
									<td height="35" ></HeaderTemplate>
										<ItemTemplate>
											<%#Container.DataItem("MaterialName")%></td>
									<td height="35" Class="font" width="2">
					</ItemTemplate>
				</asp:datalist></td>
				<td id="TB_Color" runat="server" align="left" valign="top">
					<table cellspacing="0" cellpadding="0" width="250" border="0" Class="TableHeaderGreen50">
						<tr height="50" >
							<td class="fontHead" noWrap  align=center  ><asp:image id="imgColorway" runat="server" BorderWidth="2" BorderColor ="Gray"
								Visible="true" Width="20px" Height="20px"></asp:image ><br>&nbsp;&nbsp;<asp:Label id="lblColorwayName" runat="server" />
							</td>
						</tr>
					</table>
					<asp:datalist id=Datalist3 runat="server" EnableViewState="true" Width="250" OnItemDataBound="DataList3_ItemEventArgs" DataKeyField="MaterialLinkColorwayItemID" BorderStyle="Solid" BorderColor="Gainsboro" GridLines="Horizontal" DataSource='<%#ColorwayItemDataSource(DataBinder.Eval(Container.DataItem, "MaterialLinkColorwayID"))%>' Enabled="true" >
						<ITEMSTYLE CssClass="font"></ITEMSTYLE>
						<HEADERSTYLE CssClass="fontHead"></HEADERSTYLE>
						<ITEMTEMPLATE>
							<div align="center" >
								<table cellpadding="0" cellspacing="0" >
									<tr >
										<td>
											<asp:image id="imgBtnLib" runat="server" Width="20px" Height="20px" BorderWidth="2" BorderColor ="Gray" ></asp:image></td>
									</tr>
								</table>
							</div>
				</td>
				<td height="35" Class="font">(<%#Container.DataItem("ColorCode")%>) <%#Container.DataItem("ColorName")%>
					<INPUT id="MaterialID" type="hidden" name="MaterialID" runat="server"> <INPUT id="MaterialLinkColorwayItemID" type="hidden" name="MaterialLinkColorwayItemID"
						runat="server"> <INPUT id="MaterialLinkColorwayID" type="hidden" name="MaterialLinkColorwayID" runat="server">
					<INPUT id="MaterialColorID" type="hidden" name="MaterialColorID" runat="server">
					</ItemTemplate> </asp:datalist></td>
				</tr></TBODY></table> </ItemTemplate> </asp:datalist>
							
			</asp:panel>
		</form>
	</body>
</html>
