<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Add_TradePartner.aspx.vb" Inherits="plmOnApp.Material_Add_TradePartner" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Style Workflow</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
		

	</HEAD>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					<cc1:confirmedimagebutton id="btnSaveMaterial" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table id="Table1" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="50" height="50">&nbsp;</td>
					<td class="fonthead">&nbsp;</td>
				</tr>
			</table>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD width="800" bgColor="#ffffff"></TD>
				</TR>
			</TABLE>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
				<tr>
					<TD>
						<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR vAlign="top">
								<TD>
									<TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
										bgColor="#ffffff" border="0">
										<TR vAlign="middle">
											<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
											<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
											<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
											<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
											<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
											<TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
											<TD width="10">&nbsp;</TD>
											<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
											<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></TD>
											<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
													<asp:ListItem Value="5">5</asp:ListItem>
													<asp:ListItem Value="10">10</asp:ListItem>
													<asp:ListItem Value="15">15</asp:ListItem>
													<asp:ListItem Value="20">20</asp:ListItem>
													<asp:ListItem Value="25">25</asp:ListItem>
													<asp:ListItem Value="30">30</asp:ListItem>
													<asp:ListItem Value="40">40</asp:ListItem>
													<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
												</asp:dropdownlist></TD>
											<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" Text="GO"></asp:button></TD>
										</TR>
									</TABLE>
									<TABLE id="Table5" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white"
										border="0">
										<TR>
											<TD>
												<TABLE id="Table7" cellSpacing="1" cellPadding="1" width="100%" border="0">
													<TR>
														<TD><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></TD>
													</TR>
												</TABLE>
											</TD>
											<TD vAlign="top" width="100%">
												<TABLE id="Table6" height="45">
													<TR>
														<TD><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
													</TR>
												</TABLE>
											</TD>
										</TR>
									</TABLE>
									<asp:datagrid id="DataGrid1" runat="server" DataKeyField="TradePartnerVendorId" AllowSorting="True"
										PageSize="50">
										<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
										<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
										<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
										<PagerStyle Visible="False"></PagerStyle>
									</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
							</TR>
						</TABLE>
					</TD>
				</tr>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
			<TABLE id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
				height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
				<TR>
					<TD align="center" width="50">&nbsp;</TD>
					<TD align="center" width="500"></TD>
					<TD align="center">&nbsp;</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
