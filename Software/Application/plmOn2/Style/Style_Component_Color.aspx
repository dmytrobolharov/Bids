<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component_Color.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component_Color" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Palette</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="ToolbarTop" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSaveColorList" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:bwimagebutton id="btnColorFolder" runat="server" ></cc1:bwimagebutton></td>
					<td width="75"><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellspacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="550">
						<table class="ToolbarShort" height="20" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr class="fontHead">
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td><input onclick="CheckAllSelected(this);" type="checkbox" name="DataList1:_ctl1:checkAllSelected">&nbsp;<%=GetSystemText("Select All") & " " & strColor & GetSystemText("s")%>
								</td>
							</tr>
						</table>
						<asp:label id="lblPalette" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana" Visible="False">Color Palette</asp:label>
						<asp:datalist id="DataList1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
							OnItemCommand="DataList1_ItemCommand" RepeatColumns="7" DataKeyField="ColorPaletteID" OnItemDataBound="DataList1_ItemEventArgs">
							<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table height="100" cellspacing="0" cellpadding="0" width="65" border="0">
									<tr height="50" width="65">
										<td valign="top">
											<table cellspacing="0" cellpadding="0" width ="65" runat="server" id="tblColorpalette">
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
						</asp:datalist>
					<td valign="top">
						<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" height="20"><%=strColor & " " & GetSystemText("Palette") & "..."%></td>
							</tr>
						</table>
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td bgColor="#ffffff">
									<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
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
											<td class="fontHead" align="right" width="110"><asp:label id="lblRecordsperPage" runat="server" Text="Records per Page:"></asp:label></td>
										</tr>
									</table>
									<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
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
									<table cellspacing="0" cellpadding="0" width="100%" border="0">
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
								</td>
							</tr>
						</table>
						<table id="TB_Palette" borderColor="#000000" cellspacing="1" cellpadding="1" width="100%"
							border="0" runat="server">
						</table>
						<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" height="20"><%=strColor & " " & GetSystemText("List") & "..."%></td>
							</tr>
						</table>
						<table id="TD_ImgFolder" cellspacing="1" cellpadding="0" border="0" runat="server">
							<tr bgColor="#ffffff">
								<td><cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
								<td><asp:label id="lblSortBy" CssClass="font" Runat="server"><b>&nbsp;Sort by:</b></asp:label></td>
								<td><asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
								<td><cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
								<td></td>
							</tr>
						</table>
						<table cellspacing="1" cellpadding="0" width="100%" border="0">
							<tr bgColor="#ffffff">
								<td><asp:datagrid id="DataGrid1" runat="server" OnItemCommand="DataGrid1_ItemCommand" DataKeyField="MaterialColorID"
										OnItemDataBound="ItemDataBoundEventHandler" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
										PageSize="1000" AutoGenerateColumns="False">
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
													<%= strColor  %>
												</HeaderTemplate>
												<ItemTemplate>
													<table cellspacing="0" cellpadding="0">
														<tr>
															<td height="16" width="16"><asp:Image Runat ="server" id="imgColorChip" > </asp:Image></td>
														</tr>
													</table>
												</ItemTemplate>
											</asp:TemplateColumn>
											
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblHeaderColorCode" runat="server" Width="80">
														<%#GetSystemText("Vendor") & " " & strColorNo%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtColorCode" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														maxlength="50" Width="100px"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblHeaderColorName" runat="server" Width="80">
														<%#GetSystemText("Vendor") & " " & strColorName%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtColorName" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														MaxLength="100" Width="130px"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="Label1" runat="server">
														<%#strColor%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtColor" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														MaxLength="100" Columns="30" Width="150px" Enabled="False"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblHeaderColorNote" runat="server"><%#GetSystemText("Notes")%></asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtNote" runat="server" Width="100px" BorderColor="#E0E0E0" BorderStyle="Solid"
														BorderWidth="1px" MaxLength="50"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<DIV align="center">
														<asp:Label id="lblSort" runat="server"><%#GetSystemText("Order")%></asp:Label></DIV>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtSort" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														maxlength="5" columns="5"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
									</asp:datagrid></td>
							</tr>
						</table>
						<P>&nbsp;</P>
						<P>&nbsp;</P>
					</td>
				</tr>
			</table>
		</form>
		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		
		function CheckAllSelected( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkSelected") != -1 )
			e.checked= actVar ;
		}
		}		
		</script>
	</body>
</html>
