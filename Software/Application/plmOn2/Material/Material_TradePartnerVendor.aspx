<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_TradePartnerVendor.aspx.vb" Inherits="plmOnApp.Material_TradePartnerVendor" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Material_Comment" Src="Material_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Material</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle" height="25">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnAddColor" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnDeleteColor" runat="server" ></cc1:bwimagebutton><cc1:bwimagebutton id="btnSort" runat="server" ></cc1:bwimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lbHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material</asp:label></TD>
				</TR>
			</TABLE>
			<asp:panel id="pnlAlert" runat="server" Visible="False">
				<TABLE borderColor="gold" height="75" cellSpacing="0" cellPadding="0" width="900" bgColor="#ffff99"
					border="1">
					<TR>
						<TD>
							<TABLE id="TB_MainMaterial" cellSpacing="0" cellPadding="0" width="600" border="0">
								<TR>
									<TD width="10" height="50">&nbsp;</TD>
									<TD width="50" height="50" rowSpan="2"><IMG src="../System/Icons/icon_warning_32.gif"></TD>
									<TD class="fontHead">
										<asp:Label id="lblAlert" runat="server" Font-Bold="True" CssClass="fontRed"></asp:Label></TD>
									<TD class="fontHead" height="50"></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</asp:panel>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server"></asp:label></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%">
				<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
					height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<TR>
						<TD width="900">
							<uc2:Material_Header id="Material_Header1" runat="server"></uc2:Material_Header></TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
			</asp:panel>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<td width="900"><BR>
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder><BR>
					</td>
				</TR>
			</TABLE>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:panel id="pnlColors" Runat="server">
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR bgColor="#ffffff">
						<TD vAlign="top" width="50%">
							<TABLE class="TableHeader" height="32" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
									</TD>
									<TD class="fontHead" width="75"><%= strColor & "s..."%></TD>
									<TD class="fontHead">&nbsp;
									</TD>
								</TR>
							</TABLE>
							<asp:datalist id="dlMaterialVendorColor" runat="server" ItemStyle-VerticalAlign="Top" SelectedItemStyle-VerticalAlign="Top"
								EnableViewState="True" RepeatDirection="Horizontal" RepeatColumns="6" DataKeyField="MaterialTradePartnerColorID">
								<SelectedItemStyle VerticalAlign="Top"></SelectedItemStyle>
								<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
								<ItemTemplate>
									<TABLE height="100" cellSpacing="0" cellPadding="0" width="65" border="0">
										<TR height="50" width="65">
											<TD height="50">
												<asp:Image id="btnColorChip" Runat="server" />
											</TD>
										</TR>
										<TR height="25">
											<TD bgColor="#ffffff"><FONT color="#000000" size="1">
													<asp:label id="dlColorCode" runat="server"></asp:label></FONT></TD>
										</TR>
										<TR height="25">
											<TD bgColor="#ffffff"><FONT color="#000000" size="1">
													<asp:label id="dlColorName" runat="server"></asp:label></FONT></TD>
										</TR>
									</TABLE>
								</ItemTemplate>
							</asp:datalist></TD>
					</TR>
				</TABLE>
			</asp:panel><asp:panel id="pnlColorVendor" Runat="server">
				<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
					<TR>
						<TD width="1%">
							<asp:datagrid id="DataGrid1" runat="server" BackColor="White" DataKeyField="MaterialTradePartnerColorId"
								BorderColor="#E0E0E0" PageSize="100" AllowSorting="True">
								<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
								<ItemStyle CssClass="ItemTemplate"></ItemStyle>
								<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
								<Columns>
									<asp:TemplateColumn>
										<ItemTemplate>
											<cc1:confirmedimagebutton id="btnEditColor" runat="server" 
												visible="FALSE" Message="NONE" CommandName="Edit"></cc1:confirmedimagebutton>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="ColorImagePath"></asp:BoundColumn>
								</Columns>
								<PagerStyle Visible="False"></PagerStyle>
							</asp:datagrid></TD>
						<TD width="99%"></TD>
					</TR>
				</TABLE>
				<asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			</asp:panel></form>
	</body>
</HTML>
