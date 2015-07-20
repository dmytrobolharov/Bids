<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Color_Select.aspx.vb" Inherits="plmOnApp.Material_Color_Select" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Palette</title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSaveColorList" runat="server" 
							Message="NONE"></cc1:confirmedimagebutton></TD>
					<td width="80"><cc1:bwimagebutton id="btnColorFolder" runat="server"
							></cc1:bwimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label>
					</td>
				</tr>
			</table>
			
			
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" height="25">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" ImageUrl="../System/Icons/icon_Next.gif" runat="server"></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" ImageUrl="../System/Icons/icon_Down.gif" runat="server"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:Label id="lblMaterialDetail" runat="server"></asp:Label></td>
				</tr>
			</table>
			
			<asp:panel id="Panel1" runat="server" BorderWidth="0" CssClass="font" Width="100%" BackColor="#ffffff">
				<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
					<TR>
						<TD width="900">
							<uc1:Material_Header id="Material_Header2" runat="server"></uc1:Material_Header></TD>
						<TD></TD>
					</TR>
				</TABLE>
			</asp:panel>
								
		

			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" width="550" bgColor="#ffffff">
						<table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR class="fontHead">
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<TD><input onclick="CheckAllSelected(this);" type="checkbox" name="DataList1:_ctl1:checkAllSelected">&nbsp;
									<asp:label id="lblSelectAll" runat="server"></asp:label></TD>
							</TR>
						</table>
						<asp:label id="lblPalette" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"
							Visible="False"></asp:label><asp:datalist id="DataList1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
							RepeatColumns="7" DataKeyField="ColorPaletteID" OnItemDataBound="DataList1_ItemEventArgs">
							<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<TABLE height="100" cellSpacing="0" cellPadding="0" width="65" border="0">
									<tr height="60" width="65">
										<td>
											<table cellSpacing="0" cellPadding="0" width ="65" style='BACKGROUND-IMAGE: url(<%# string.Concat("../System/Control/ThumbColorJPG.aspx?S=65&amp;CFID=" + DataBinder.Eval(Container.DataItem,"ColorFolderId").tostring + "&amp;CPID=" + DataBinder.Eval(Container.DataItem,"ColorPaletteID").tostring) %>)'>
												<tr height="60" width="65" valign="top">
													<td>
														<asp:CheckBox ID="chkSelected" Runat="server"></asp:CheckBox></td>
												</tr>
											</table>
										</td>
									</tr>
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
						</asp:datalist><BR>
						<table class="TableHeader" height="23" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" height="20"><asp:label ID="lblImage" runat="server" Text="Image..."></asp:label></td>
							</tr>
						</table>
						<cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton>
					<td vAlign="top">
						<table class="TableHeader" height="23" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" height="20"><%=GetSystemText(strColor)%><asp:Label ID="lblPalettecolor" runat="server" text="Palette..."></asp:Label></td>
							</tr>
						</table>
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
							</TR>
						</TABLE>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
								<td vAlign="top" width="100%">
									<table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td bgColor="#ffffff"><asp:datagrid id="Datagrid2" runat="server" DataKeyField="ColorFolderID" PageSize="10" AllowSorting="True">
										<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
										<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
										<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
										<PagerStyle Visible="False"></PagerStyle>
									</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
							</tr>
						</table>
						<BR>
						<table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" height="20"><%=GetSystemText(strColor)%><asp:Label ID="lblListcolor" runat="server" Text="List..."></asp:Label></td>
							</tr>
						</table>
						<table id="TD_ImgFolder" cellSpacing="1" cellPadding="0" border="0" runat="server">
							<tr bgColor="#ffffff">
								<TD><cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
								<td><asp:label id="lblSortBy" CssClass="font" Runat="server"></asp:label></td>
								<td><asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
								<TD><cc1:confirmedimagebutton id="btnSort" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
								<TD></TD>
							</tr>
						</table>
						<table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr bgColor="#ffffff">
								<td width="16">&nbsp;</td>
								<td><asp:datagrid id="DataGrid1" runat="server" DataKeyField="MaterialColorID" OnItemDataBound="DataGrid1_OnItemDataBound"
										PageSize="1000" AutoGenerateColumns="False" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
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
														<%#GetSystemText(strColor)%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<table cellpadding="0" cellspacing="0" border="0">
														<tr>
															<td height="16" width="16"><asp:Image Runat="server" ID="imgColorChip"></asp:Image></td>
														</tr>
													</table>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblHeaderColorCode" runat="server" Width="80px">
														<%#GetSystemText("Vendor ") & strColorNo%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtColorCode" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														maxlength="50" Width="50px"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblHeaderColorName" runat="server" Width="80px">
														<%#GetSystemText(strColorName)%>
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
														<%#GetSystemText(strColor)%>
													</asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtColor" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														MaxLength="100" Columns="30" Width="150px" Enabled="False"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<asp:Label id="lblHeaderColorNote" runat="server"><%=GetSystemText("Notes")%></asp:Label>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtNote" runat="server" Width="100px" BorderColor="#E0E0E0" BorderStyle="Solid"
														BorderWidth="1px" MaxLength="50"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
											<asp:TemplateColumn>
												<HeaderTemplate>
													<DIV align="center">
														<asp:Label id="lblSort" runat="server"><%=GetSystemText("Order")%></asp:Label></DIV>
												</HeaderTemplate>
												<ItemTemplate>
													<asp:TextBox id="txtSort" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
														maxlength="5" columns="5"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateColumn>
										</Columns>
									</asp:datagrid></td>
								<TD></TD>
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
</HTML>
