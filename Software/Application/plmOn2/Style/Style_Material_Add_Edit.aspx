<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Material_Add_Edit.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_Edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Material_Edit</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSaveMaterial" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:confirmedimagebutton id="btnEditImage" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton></td>
					<td><cc1:confirmedimagebutton id="btnAddColor" runat="server" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table height="75" cellSpacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
				border="0">
				<TBODY>
					<tr>
						<td>
							<table cellSpacing="0" cellpadding="0" width="800" border="0">
								<TBODY>
									<tr>
										<td>&nbsp;</td>
										<td>
											<DIV align="right"><IMG src="../System/Icons/icon_32_5.gif"></DIV>
										</td>
										<td class="fontHead" style="FONT-SIZE: 12pt">&nbsp;<asp:Label ID="lblMtHeader" runat="server" ></asp:Label></td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>
											<DIV align="right"></DIV>
										</td>
										<td>
											<table cellSpacing="0" cellpadding="0" width="100%" border="0">
												<TBODY>
													<tr>
														<td>&nbsp;</td>
														<td width="50"><cc1:confirmedimagebutton id="btnBack" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
														<td><cc1:confirmedimagebutton id="btnDone" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
													</tr>
												</TBODY>
											</table>
										</td>
										<td>&nbsp;</td>
									</tr>
								</TBODY>
							</table>
						</td>
					</tr>
				</TBODY>
			</table>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td valign="top" width="50%">
						<table class="TableHeader" height="32" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
								</td>
								<td class="fontHead" width="75">
                                    <asp:Label ID="lblColorH" runat="server" ></asp:Label></td>
								<td class="fontHead">&nbsp;</td>
							</tr>
						</table>
						<asp:datalist id="DataList1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
							RepeatColumns="7" OnItemCommand="DataList1_ItemCommand" DataKeyField="ColorPaletteID" OnItemDataBound="DataList1_ItemEventArgs">
							<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro"></ItemStyle>
							<ItemTemplate>
								<table height="100" cellSpacing="0" cellpadding="0" width="65" border="0">
									<tr height="50" width="65">
										<td valign="top"><IMG alt="" runat="server" id="imgColorPalette">
										</td>
									</tr>
									<tr height="25">
										<td bgColor="#ffffff"><FONT color="#000000" size="1">
												<asp:label id="dlColorCode" runat="server"></asp:label></FONT></td>
									</tr>
									<tr height="25">
										<td bgColor="#ffffff"><FONT color="#000000" size="1">
												<asp:label id="dlColorName" runat="server"></asp:label></FONT></td>
									</tr>
								</table>
								<INPUT id="Selected_ID" type="hidden" name="Selected_ID" runat="server"> <INPUT id="Selected_ColorSource" type="hidden" name="Selected_ColorSource" runat="server">
								<INPUT id="Selected_ColorNotes" type="hidden" name="Selected_ColorNotes" runat="server">
								<INPUT id="Selected_R" type="hidden" name="Selected_R" runat="server"> <INPUT id="Selected_G" type="hidden" name="Selected_G" runat="server">
								<INPUT id="Selected_B" type="hidden" name="Selected_B" runat="server"> <INPUT id="Selected_HEX" type="hidden" name="Selected_HEX" runat="server">
								<INPUT id="Selected_LL" type="hidden" name="Selected_LL" runat="server"> <INPUT id="Selected_LA" type="hidden" name="Selected_LA" runat="server">
								<INPUT id="Selected_LB" type="hidden" name="Selected_LB" runat="server">
							</ItemTemplate>
						</asp:datalist><br>
						<table class="TableHeader" height="32" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10">
									<IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
								</td>
								<td class="fontHead">
                                    <asp:Label ID="lblImageH" runat="server" ></asp:Label></td>
							</tr>
						</table>
						<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton><br>
					</td>
					<td valign="top" width="50%">
						<table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" width="100"><asp:label id="lblMaterialSizeType" runat="server"></asp:label></td>
								<td height="30">
									<table cellSpacing="2" cellpadding="0" width="250" border="0">
										<tr class="fontHead">
											<td>&nbsp;</td>
											<td noWrap width="85">
<asp:Label ID="lblNumOfRows" runat="server"></asp:Label>
</td>
											<td width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
													<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
													<asp:ListItem Value="2">2</asp:ListItem>
													<asp:ListItem Value="3">3</asp:ListItem>
													<asp:ListItem Value="4">4</asp:ListItem>
													<asp:ListItem Value="5">5</asp:ListItem>
													<asp:ListItem Value="10">10</asp:ListItem>
													<asp:ListItem Value="15">15</asp:ListItem>
													<asp:ListItem Value="20">20</asp:ListItem>
												</asp:dropdownlist></td>
											<td width="150"><cc1:confirmedimagebutton id="imgBtnAdd" runat="server" ></cc1:confirmedimagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<asp:datagrid id="Datagrid2" runat="server" OnItemCommand="DataGrid2_ItemCommand" DataKeyField="MaterialSizeID"
							OnItemDataBound="DataGrid2_ItemEventHandler" Width="250" AutoGenerateColumns="False" PageSize="1000"
							BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<FooterStyle></FooterStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" NAME="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkDelete" runat="server"></asp:CheckBox>
										<asp:TextBox id="txtMaterialSizeVersion" runat="server" Visible="false" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="lblMaterialSize" runat="server"></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtMaterialSize" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											MaxLength="100" Columns="30"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblMaterialPrice" runat="server"></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtMaterialPrice" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											maxlength="5" columns="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
