<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Link_Edit.aspx.vb" Inherits="plmOnApp.Material_Link_Edit"%>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Material Link</title>
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" 
							ToolTip="" CausesValidation="False" Visible="false"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnGoto" runat="server" Message="NONE" ></cc1:bwimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lblMaterial2" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material</asp:label></TD>
				</TR>
			</TABLE>
			<BR>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<td width="900"><uc1:material_header id="Material_Header1" runat="server"></uc1:material_header></td>
					<td width="200"><asp:image id="imgMaterial" Runat="server"></asp:image></td>
				</TR>
			</TABLE>
			<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<td width="900"><BR>
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder><BR>
					</td>
				</TR>
			</TABLE>
			<br>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="50%">
						<asp:datalist id="DataList1" runat="server" ItemStyle-VerticalAlign="Top" SelectedItemStyle-VerticalAlign="Top"
							EnableViewState="True" RepeatDirection="Horizontal" RepeatColumns="7" DataKeyField="ColorPaletteID">
							<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro"></ItemStyle>
							<ItemTemplate>
								<TABLE height="100" cellSpacing="0" cellPadding="0" width="65" border="0">
									<TR height="75" width="75">
										<TD height="75">
											<asp:Image id="btnColorChip" Runat="server" Height="75" Width="75" />
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
									<TR>
										<TD bgColor="PaleGoldenrod"><FONT color="#000000" size="1">
												<asp:label id="dlColorNote" runat="server"></asp:label></FONT></TD>
									</TR>
								</TABLE>
							</ItemTemplate>
						</asp:datalist>
					</td>
					<td vAlign="top" width="50%">
						<asp:datagrid id="Datagrid2" runat="server" DataKeyField="MaterialSizeID" Width="250" AutoGenerateColumns="False"
							PageSize="1000" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<FooterStyle></FooterStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="lblMaterialSize" runat="server"></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtMaterialSize" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											MaxLength="100" Columns="30" ReadOnly="True"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblMaterialPrice" runat="server"></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtMaterialPrice" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											maxlength="5" columns="5" ReadOnly="True"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="Label1" runat="server"><%=GetSystemText("Sort")%></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSort" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											maxlength="5" columns="5" ReadOnly="True"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
