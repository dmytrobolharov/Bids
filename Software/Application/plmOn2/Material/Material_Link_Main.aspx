<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Link_Main.aspx.vb" Inherits="plmOnApp.Material_Link_Main"%>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Material_Link_Item" Src="Material_Link_Item.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Material_Link_Main</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD height="30"><cc1:bwimagebutton id="btnAddMaterial" runat="server" Message="NONE" ></cc1:bwimagebutton><cc1:bwimagebutton id="btnRemoveMaterial" runat="server" Message="NONE" ></cc1:bwimagebutton></TD>
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
			<TABLE class="TableHeader" id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD height="30"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<asp:datagrid id="dgComponent" runat="server" ShowHeader="False" AutoGenerateColumns="false" BorderColor="Silver"
				Width="100%" DataKeyField="MaterialType">
				<Columns>
					<asp:TemplateColumn>
						<ItemTemplate>
							<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader">
									<TD width="10" bgColor="white" height="24"></TD>
									<TD class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></TD>
								</TR>
							</TABLE>
							<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
								<TR>
									<TD width="1%">
										<asp:datagrid id="dgComponentType" runat="server" Width="100%" OnItemDataBound="dgComponentType_ItemDataBound"
											OnEditCommand="dgComponentType_EditCommand" DataKeyField="MaterialLinkID" BorderColor="#E0E0E0" PagerStyle-Visible="false">
											<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
											<ItemStyle CssClass="ItemTemplate"></ItemStyle>
											<HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
											<Columns>
											    <asp:TemplateColumn  Visible="false"> 
											        <HeaderTemplate ><asp:Label  runat="server" ID="lblPlacementeHeader"  CssClass ="fontHead" ><%=GetSystemText("Placement")%></asp:Label></HeaderTemplate>
											        <ItemTemplate >
											            <cc1:bwimagebutton id="btnPlacement" runat="server" Message="NONE"  ></cc1:bwimagebutton>&nbsp;&nbsp;
											        </ItemTemplate>
											    </asp:TemplateColumn>
												<asp:TemplateColumn HeaderStyle-Width="75">
													<ItemTemplate>
														<asp:ImageButton id="imgMaterial" runat="server" CommandName="Edit" ></asp:ImageButton>
														<input type="hidden" runat="server" id="txtMaterialID" />
													</ItemTemplate>
												</asp:TemplateColumn>
											</Columns>
										</asp:datagrid></TD>
									<TD width="99%"></TD>
								</TR>
							</TABLE>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
			<asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</form>
	</body>
</HTML>
