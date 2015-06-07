<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="../Material/Material_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Material_Add_Color.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Material_Add_Color" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Palette</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSaveColorList" runat="server" AlternateText="Click here to save color palette..."
							Message="NONE" ></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:bwimagebutton id="btnColorFolder" runat="server" AlternateText="Click here to edit color folder..."
							></cc1:bwimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
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
											<DIV align="right"><IMG src="../System/Icons/icon_32_3.gif"></DIV>
										</td>
										<td class="fontHead" style="FONT-SIZE: 12pt">&nbsp;<asp:Label ID="lblSel" runat="server" Text="Select Material"></asp:Label> <%= Me.strColorway %>...</td>
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
														<td width="50"><cc1:confirmedimagebutton id="btnback" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
														<td><cc1:confirmedimagebutton id="btnNext" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
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
					<td width="800"><uc1:material_header id="Material_Header1" runat="server"></uc1:material_header></td>
				</tr>
			</table>
			<table cellSpacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="550" bgColor="#ffffff">
						<table class="TableHeader" height="20" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="fontHead">
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td><input onclick="CheckAllSelected(this);" type="checkbox" name="DataList1:_ctl1:checkAllSelected">&nbsp;
									<asp:label id="lblRecordCount" runat="server">Select All Colors</asp:label></td>
							</tr>
						</table>
						<asp:datalist id="DataList1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
							RepeatColumns="7" DataKeyField="ColorPaletteID" OnItemDataBound="DataList1_ItemEventArgs">
							<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro"></ItemStyle>
							<ItemTemplate>
								<table height="100" cellSpacing="0" cellpadding="0" width="65" border="0">
									<tr height="50" width="65">
										<td>
											<table cellSpacing="0" cellpadding="0" width ="100%" runat="server" id="tblColorpalette">
												<tr height="60" width="65" valign="top">
													<td>
														<asp:CheckBox ID="chkSelected" Runat="server"></asp:CheckBox></td>
												</tr>
											</table>
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
						</asp:datalist><BR>
						<table class="TableHeader" height="23" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" height="20"><%#GetSystemText("Image")%> ...</td>

							</tr>
						</table>
						<cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton>
					<td valign="top">
						<table class="TableHeader" height="23" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" height="20"><%=GetSystemText(strColor & " Palette") & "..."%></td>
							</tr>
						</table>
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<tr valign="middle">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
							</tr>
						</table>
						<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
								<td valign="top" width="100%">
									<table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td bgColor="#ffffff">
									<asp:datagrid id="Datagrid2" runat="server" AllowSorting="True" DataKeyField="ColorFolderID" PageSize="10">
										<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
										<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
										<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
										<PagerStyle Visible="False"></PagerStyle>
									</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
								</td>
							</tr>
						</table>
						<table id="TB_Palette" borderColor="#000000" cellSpacing="1" cellpadding="1" border="0"
							runat="server" width="100%">
						</table>
						<table class="ToolbarShort" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" height="20"><%=GetSystemText("Color List...")%></td>
							</tr>
						</table>
						<table id="TD_ImgFolder" cellSpacing="1" cellpadding="0" border="0" runat="server">
							<tr bgColor="#ffffff">
								<td><cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
								<td><asp:label id="lblSortBy" Runat="server" CssClass="fontHead"></asp:label></td>
								<td><asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
								<td><cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
								<td></td>
							</tr>
						</table>
						<table class="ToolbarShort" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr bgColor="#ffffff">
								<td width="16">&nbsp;</td>
								<td><asp:datagrid id="DataGrid1" runat="server" DataKeyField="MaterialColorID" OnItemDataBound="DataGrid1_OnItemDataBound"
										BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" PageSize="1000" AutoGenerateColumns="False">
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
													<asp:Label id="lblHeaderColor" runat="server">
														<%# GetUserText(strColor)%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<table cellpadding="0" cellspacing="0" border="0">
														<tr>
															<td height="16" width="16"><IMG alt="" runat="server" id="imgColorPalette" ></td>
														</tr>
													</table>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<%=GetUserText("Vendor Color")%>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtVendorColorName" runat="server" Width="85px" BorderColor="#E0E0E0" BorderStyle="Solid"
														BorderWidth="1px" Columns="30" MaxLength="50"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblHeaderColorCode" runat="server">
														<%#GetUserText(strColorNo)%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtColorCode" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														columns="15" maxlength="50" Width="50px"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblHeaderColorName" runat="server">
														<%#GetUserText(strColorName)%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtColorName" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														MaxLength="100" Columns="30" Width="85px"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<DIV align="center">
														<asp:Label id="lblSort" runat="server"><%#GetUserText("Order")%></asp:Label></DIV>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtSort" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														maxlength="5" columns="5"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
									</asp:datagrid></td>
								<td></td>
							</tr>
						</table>
						<P>&nbsp;</P>
						<P>&nbsp;</P>
					</td>
				</tr>
			</table>
		</form>
		<script language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }

		    function CheckAllSelected(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
		                e.checked = actVar;
		        }
		    }		
		</script>
	</body>
</html>

