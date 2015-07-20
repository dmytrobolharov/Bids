<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_MultiDimension_Item.aspx.vb" Inherits="plmOnApp.Material_MultiDimension_Item1" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Material_MultiDimension_Item</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="Table13" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							CausesValidation="False" ></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<TR>
					<TD></TD>
				</TR>
			</TABLE>
			<br>
			<br>
			<br>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview><asp:panel id="pnlGeneral" runat="server">
				<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
					height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<TR>
						<TD>&nbsp;
							<asp:Label id="lbHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material</asp:Label></TD>
					</TR>
				</TABLE>
				<TABLE id="Table16" cellSpacing="1" cellPadding="1" width="900" border="0">
					<TR>
						<TD width="900">
							<uc1:Material_Header id="Material_Header1" runat="server"></uc1:Material_Header></TD>
						<TD vAlign="top" width="150">
							<asp:Image id="imgMaterial" Runat="server"></asp:Image></TD>
					</TR>
				</TABLE>
				<BR>
				<BR>
			</asp:panel><asp:panel id="pnlColorway" runat="server">
<TABLE class="TableHeader" height="30" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR class="font">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD class="fontHead" width="300">
							<cc1:confirmedimagebutton id="btnSaveCombo" runat="server" 
								Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnDeleteCombo" runat="server" 
								></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCloseCombo" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
						<TD class="fontHead" width="125">
							<DIV align="right"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="No. of Combo(s):"></asp:Label></DIV>
						</TD>
						<TD width="35">
							<asp:dropdownlist id="dpNewRow" runat="server" EnableViewState="false" CssClass="fontHead">
								<asp:ListItem Value="0" Selected="True">0</asp:ListItem>
								<asp:ListItem Value="1">1</asp:ListItem>
								<asp:ListItem Value="2">2</asp:ListItem>
								<asp:ListItem Value="3">3</asp:ListItem>
								<asp:ListItem Value="4">4</asp:ListItem>
								<asp:ListItem Value="5">5</asp:ListItem>
								<asp:ListItem Value="10">10</asp:ListItem>
								<asp:ListItem Value="15">15</asp:ListItem>
								<asp:ListItem Value="20">20</asp:ListItem>
							</asp:dropdownlist></TD>
						<TD width="100">
							<cc1:confirmedimagebutton id="BtnColor" runat="server" 
								Message="NONE"></cc1:confirmedimagebutton></TD>
						<TD>&nbsp;</TD>
					</TR>
				</TABLE>
<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<TR>
						<TD>&nbsp;
							<asp:label id="lblCombo" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Color Combo</asp:label></TD>
					</TR>
				</TABLE>
<asp:datagrid id="Datagrid2" runat="server" DataKeyField="MaterialLinkColorwayID" AutoGenerateColumns="false">
					<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
					<Columns>
						<asp:TemplateColumn>
							<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="Red"></ItemStyle>
							<HeaderTemplate>
								<asp:Image id="imgDelete" runat="server" ImageUrl="../System/Icons/icon_delete.gif"></asp:Image>
								<INPUT id="Hidden1" onclick="CheckAll(this);" type="hidden" name="checkAll" runat="server">
							</HeaderTemplate>
							<ItemTemplate>
								<asp:CheckBox id="chkDelete" runat="server" ForeColor="Red" ToolTip='<%#GetSystemText("click here to delete item")%>'></asp:CheckBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<asp:Label id="lblMainColor" runat="server"><%=GetSystemText("Combo Name")%></asp:Label>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox ID="txtMainColor" Runat="server"></asp:TextBox>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<asp:Label id="lblColorIcon" runat="server"></asp:Label>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:label ID="lblColorLink" Runat="server"></asp:label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<asp:Label id="lblSystemColorHeader" runat="server"><%=GetSystemText("System Color")%></asp:Label>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:label ID="lblSystemColor" Runat="server"></asp:label>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<HeaderTemplate>
								<asp:Label id="Label1" runat="server"><%=GetSystemText("Sort")%></asp:Label>
							</HeaderTemplate>
							<ItemTemplate>
								<asp:TextBox ID="txtSort" Runat="server" Columns="5" MaxLength="5"></asp:TextBox>
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:datagrid><BR><BR><!-----  COLORS ----->
<asp:datalist id="DataList2" runat="server" DataKeyField="MaterialLinkColorwayID" CellSpacing="0"
					CellPadding="0" BorderWidth="1" OnItemDataBound="DataList2_ItemEventArgs"
					RepeatColumns="3" RepeatDirection="Horizontal">
					<ItemStyle HorizontalAlign="Left" VerticalAlign="Top" BackColor="White"></ItemStyle>
					<ItemTemplate>
						<TABLE borderColor="darkgray" cellSpacing="0" borderColorDark="gainsboro" cellPadding="0"
							width="100%" borderColorLight="ghostwhite" border="1">
							<TBODY>
								<TR>
									<TD id="TH_Material" width="400" runat="server">
										<asp:datalist id=DataList1 runat="server" EnableViewState="true" DataKeyField="MaterialLinkColorwayItemID" OnItemDataBound="DataList1_ItemEventArgs" Width="100%" Enabled="true" DataSource='<%#ColorwayItemDataSource( DataBinder.Eval(Container.DataItem, "MaterialLinkColorwayID") )%>' GridLines="Horizontal" BorderColor="Gainsboro" BorderStyle="Solid">
											<ItemStyle CssClass="font"></ItemStyle>
											<HeaderStyle CssClass="TableHeaderOver"></HeaderStyle>
											<HeaderTemplate>
										<%=GetSystemText("Material")%>:</TD>
									<td height="25" Class="TableHeaderOver"><%=GetSystemText("Placement")%>:</HeaderTemplate>
										<ItemTemplate>
											<%#Container.DataItem("MaterialName")%></td>
									<td height="35" Class="font">
						<%=GetSystemText("placement")%>
					</ItemTemplate>
				</asp:datalist></TD>
			<TD id="TB_Color" runat="server" align="left" valign="top">
					<table cellSpacing="0" cellPadding="1" width="200" border="0">
						<tr>
							<td class="TableHeaderOver" noWrap width="80" height="25">
								<asp:Label id="Label2" runat="server"><%=GetSystemText("Style Combo")%>:</asp:Label></td>
							<td class="TableHeaderOver" height="25" noWrap>
								<asp:Label id="lblColorwayName" runat="server" /><!--<%#Container.DataItem("MainColor")%><INPUT id=txtMainColor type=text maxLength=200 value='<%#Container.DataItem("MainColor")%>' runat="server">--></td>
							<td class="TableHeaderOver" height="25">
								<asp:ImageButton id="btnColorPop" runat="server" ImageUrl="../System/Icons/icon_search.gif" CommandName="ColorStd"
									Visible="false"></asp:ImageButton></td>
						</tr>
					</table>
					<asp:datalist id=Datalist3 runat="server" EnableViewState="true" Width="200" OnItemDataBound="DataList3_ItemEventArgs" DataKeyField="MaterialLinkColorwayItemID" BorderStyle="Solid" BorderColor="Gainsboro" GridLines="Horizontal" DataSource='<%#ColorwayItemDataSource(DataBinder.Eval(Container.DataItem, "MaterialLinkColorwayID"))%>' Enabled="true" OnItemCommand="DataList3_ItemCommand">
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
			<td height="35" Class="font">(<%#Container.DataItem("ColorNo")%>)
					<%#Container.DataItem("ColorName")%>
					<INPUT id="MaterialID" type="hidden" name="MaterialID" runat="server"> <INPUT id="MaterialLinkColorwayItemID" type="hidden" name="MaterialLinkColorwayItemID"
						runat="server"> <INPUT id="MaterialLinkColorwayID" type="hidden" name="MaterialLinkColorwayID" runat="server">
					<INPUT id="MaterialColorID" type="hidden" name="MaterialColorID" runat="server">
					</ItemTemplate> </asp:datalist></td>
			</TR></TBODY></TABLE> </ItemTemplate> </asp:datalist>				
				
			</asp:panel></form>
            <script language="javascript">
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
            </script>
	</body>
</HTML>
