<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_TradePartnerVendorColor_Add.aspx.vb" Inherits="plmOnApp.Material_TradePartnerVendorColor_Add" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Select Vendor</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<cc1:confirmedimagebutton id="btnSaveMaterial" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: white thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Custom</asp:label></TD>
				</TR>
			</TABLE>
			<asp:panel id="pnlSearch" runat="server">
				<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
					<TR>
						<TD width="800" bgColor="#ffffff"></TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" align="center" bgColor="#ffffff" border="0">
					<TR>
						<TD>
							<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<TD>
										<TABLE class="TableHeader" id="Table3" height="25" cellSpacing="0" cellPadding="0" width="100%"
											bgColor="#ffffff" border="0">
											<TR vAlign="middle">
												<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
												<TD width="20">
													<asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
												<TD width="20">
													<asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
												<TD noWrap align="center" width="125">
													<asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
												<TD width="20">
													<asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
												<TD width="20">
													<asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
												<TD width="10">&nbsp;</TD>
												<TD noWrap>
													<asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
											</TR>
										</TABLE>
										<TABLE id="Table5" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white"
											border="0">
											<TR>
												<TD>
													<TABLE id="Table7" cellSpacing="1" cellPadding="1" width="100%" border="0">
														<TR>
															<TD>
																<asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></TD>
														</TR>
													</TABLE>
												</TD>
												<TD vAlign="top" width="100%">
													<TABLE id="Table6" height="45">
														<TR>
															<TD>
																<asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></TD>
														</TR>
													</TABLE>
												</TD>
											</TR>
										</TABLE>
										<asp:datagrid id="DataGrid1" runat="server" PageSize="50" AllowSorting="True" DataKeyField="TradePartnerVendorID">
											<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
											<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
											<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
											<PagerStyle Visible="False"></PagerStyle>
										</asp:datagrid>
										<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD>&nbsp;
						</TD>
					</TR>
				</TABLE>
				<TABLE id="Table4" style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
					height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
					<TR>
						<TD align="center" width="50">&nbsp;</TD>
						<TD align="center" width="500"></TD>
						<TD align="center">&nbsp;</TD>
					</TR>
				</TABLE>
			</asp:panel><asp:panel id="pnlVendor" runat="server" Visible="false">
				<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD>
							<cc1:confirmedimagebutton id="btnDelete" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose2" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
					</TR>
				</TABLE>
				<TABLE class="ToolbarShort" cellSpacing="0" cellPadding="0" width="500" border="0">
					<TR bgColor="#ffffff">
						<TD>
							<asp:datagrid id="Datagrid2" runat="server" PageSize="1000" DataKeyField="MaterialTradePartnerId"
								AutoGenerateColumns="False" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
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
											<asp:Label id="lblHeader2" runat="server" Width="80px"><%#GetSystemText("Trade Partner Code")%></asp:Label>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblTradePartnerCode" runat="server" Width="80px"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<asp:Label id="lblHeader1" runat="server"><%#GetSystemText("Trade Partner Name")%></asp:Label>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblTradePartnerName" runat="server"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<asp:Label id="Label3" runat="server" Width="80px"><%#GetSystemText("Trade Partner Vendor Code")%></asp:Label>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblTradePartnerVendorCode" runat="server" Width="80px"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn>
										<HeaderTemplate>
											<asp:Label id="Label4" runat="server" Width="80px"><%#GetSystemText("Trade Partner Vendor Name")%></asp:Label>
										</HeaderTemplate>
										<ItemTemplate>
											<asp:Label id="lblTradePartnerVendorName" runat="server" Width="80px"></asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></TD>
					</TR>
				</TABLE>
			</asp:panel></form>
		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++) 			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
				e.checked= actVar ;
			}
		}
		</script>
        <script language="javascript">
            function btnClose_Click() {
              <%= strExitScript %>
              return false;
            }
        </script>
	</body>
</HTML>
