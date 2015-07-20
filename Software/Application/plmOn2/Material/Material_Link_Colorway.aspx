<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Link_Colorway.aspx.vb" Inherits="plmOnApp.Material_Link_Colorway" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Material_Link_Colorway</title>
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="Table13" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD height="30"><cc1:confirmedimagebutton id="btnClose" runat="server" CausesValidation="False" ToolTip="" 
							Message="NONE" Visible="FALSE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Multi-Level Material</asp:label></TD>
				</TR>
			</TABLE>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="white">
				<tr>
					<td width="900"><uc1:Material_Header id="Material_Header1" runat="server"></uc1:Material_Header></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<TABLE class="TableHeader" height="30" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR class="font">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD class="fontHead"><cc1:confirmedimagebutton id="btnSaveCombo" runat="server" 
							Message="NONE" visible="false"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<!-----  COLORS -----><asp:datalist id="DataList2" runat="server" CellSpacing="0" CellPadding="0" BorderWidth="1" OnItemDataBound="DataList2_ItemEventArgs"
				RepeatColumns="3" RepeatDirection="Horizontal" DataKeyField="MaterialLinkColorwayID">
				<ItemStyle HorizontalAlign="Left" VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<TABLE borderColor="darkgray" cellSpacing="0" borderColorDark="gainsboro" cellPadding="0"
						width="100%" borderColorLight="ghostwhite" border="1">
						<TBODY>
							<TR>
								<TD id="TH_Material" width="400" runat="server">
									<asp:datalist id=DataList1 runat="server" EnableViewState="true" DataKeyField="MaterialLinkColorwayItemID" OnItemDataBound="DataList1_ItemEventArgs" Width="100%" Enabled="true" 
										DataSource='<%#ColorwayItemDataSource( DataBinder.Eval(Container.DataItem, "MaterialLinkColorwayID") )%>' GridLines="Horizontal" BorderColor="Gainsboro" BorderStyle="Solid">
										<ItemStyle CssClass="font"></ItemStyle>
										<HeaderStyle CssClass="TableHeaderOver"></HeaderStyle>
										<HeaderTemplate>
									<%=GetSystemText("Material")%>:</TD>
								<td height="25" Class="TableHeaderOver"></HeaderTemplate>
									<ItemTemplate>
										<%#String.Concat(Container.DataItem("MaterialNo") + " - " + Container.DataItem("MaterialName"))%></td>
								<td height="35" Class="font" width="2">
				</ItemTemplate>
			</asp:datalist></TD>
			<TD id="TB_Color" runat="server" align="left" valign="top">
				<table cellSpacing="0" cellPadding="1" width="200" border="0">
					<tr>
						<td class="TableHeaderOver" noWrap width="80" height="25">
							<asp:Label id="Label2" runat="server"><%=GetSystemText("Color Combo")%>:</asp:Label></td>
						<td class="TableHeaderOver" height="25" noWrap>
							<asp:Label id="lblColorwayName" runat="server" /></td>
						<td class="TableHeaderOver" height="25">
							<asp:ImageButton id="btnColorPop" runat="server" ImageUrl="../System/Icons/icon_search.gif" CommandName="ColorStd"
								Visible="false"></asp:ImageButton></td>
					</tr>
				</table>
				<asp:datalist id=Datalist3 runat="server" EnableViewState="true" Width="200" OnItemDataBound="DataList3_ItemEventArgs" DataKeyField="MaterialLinkColorwayItemID" 
				BorderStyle="Solid" BorderColor="Gainsboro" GridLines="Horizontal" 
				DataSource='<%#ColorwayItemDataSource(DataBinder.Eval(Container.DataItem, "MaterialLinkColorwayID"))%>' Enabled="true" OnItemCommand="DataList3_ItemCommand">
					<ITEMSTYLE CssClass="font"></ITEMSTYLE>
					<HEADERSTYLE CssClass="fontHead"></HEADERSTYLE>
					<ITEMTEMPLATE>
						<div align="center">
							<table cellpadding="0" cellspacing="0" border="1" bordercolor="Gray">
								<TR height="20" width="20">
									<TD>
										<asp:imagebutton id="imgBtnLib" runat="server" Width="20px" CommandName="ColorChip" Height="20px"></asp:imagebutton></TD>
								</TR>
							</table>
						</div>
			</TD>
			<td height="35" Class="font">(<%#Container.DataItem("ColorCode")%>)
				<%#Container.DataItem("ColorName")%>
				<INPUT id="MaterialID" type="hidden" name="MaterialID" runat="server"> <INPUT id="MaterialLinkColorwayItemID" type="hidden" name="MaterialLinkColorwayItemID"
					runat="server"> <INPUT id="MaterialLinkColorwayID" type="hidden" name="MaterialLinkColorwayID" runat="server">
				<INPUT id="MaterialColorID" type="hidden" name="MaterialColorID" runat="server">
				</ItemTemplate> </asp:datalist></td>
			</TR></TBODY></TABLE> </ItemTemplate> </asp:datalist></form>
	</body>
</HTML>
