<%@ Register TagPrefix="uc1" TagName="Style_Component_Header" Src="Style_Component_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Colorway_Color.aspx.vb" Inherits="plmOnApp.Style.Colorway.Style_Colorway_Color" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		
        <title runat="server" id="PageTitle"></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					    id="btnSaveMaterial" runat="server"  visible="False" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnRemoveColor" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
				    	id="btnNoApplicable" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;
						<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Material</asp:label></td>
				</tr>
			</table>
			<uc1:style_component_header id=Style_Component_Header1 runat="server" SMID='<%# Request.Querystring("SMID") %>' EnableViewState="False">
			</uc1:style_component_header>
			<table cellspacing="1" cellpadding="1" width="100%" border="0">
				<tr>
					<td style="WIDTH: 198px" valign="top" bgColor="#ffffff">
						<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="10">&nbsp;</td>
								<td><asp:label id="lblSelectedColor" runat="server">Selected Color</asp:label>
								</td>
							</tr>
						</table>
						<table id="Table1" borderColor="silver" height="100" cellspacing="0" cellpadding="0" width="65"
							align="center" border="1">
							<tr height="75" width="65">
								<td id="tdHex" runat="server"><asp:imagebutton id="Imagebutton1" runat="server" 
								ImageUrl="../System/Icons/tv_space.gif" CommandName="ColorChip" height="75" width="65" ></asp:imagebutton></td>
							</tr>
							<tr height="25">
								<td bgcolor="#ffffff"><FONT color="#000000" size="1"><asp:label id="lblColorCode" runat="server"></asp:label></FONT></td>
							</tr>
							<tr height="25">
								<td bgcolor="#ffffff"><FONT color="#000000" size="1"><asp:label id="lblColorName" runat="server"></asp:label></FONT></td>
							</tr>
						</table>
					</td>
					<td valign="top" bgColor="#ffffff">
						<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="10">&nbsp;</td>
								<td width="125"><asp:label id="lblAvailableColor" runat="server">Available Color(s)</asp:label>
								</td>
								<td>&nbsp;
									<asp:checkbox id="chkAllColor" runat="server" Text="Apply to All Colors"></asp:checkbox></td>
							</tr>
						</table>
						<asp:datalist id="Datalist1" runat="server" EnableViewState="True" RepeatDirection="Horizontal"
							RepeatColumns="7" OnItemDataBound="DataList1_ItemEventArgs" DataKeyField="MaterialColorID"
							OnItemCommand="DataList1_ItemCommand">
							<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro"
							    VerticalAlign="Top"  ></ItemStyle>
							<ItemTemplate>
								<table height="100" cellspacing="0" cellpadding="0" width="65" border="0">
									<tr height="75" width="65" valign="top">
										<td valign="top">
											<cc1:confirmedimagebutton id="imgBtnLib" runat="server" height="75" width="65" CommandName="Select"  Message="NONE" /><input type="hidden" id="hdnColorName"  runat="server"/></td>
									</tr>
									<tr>
									    <td bgColor="#ffffff" valign="top">
									        <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
										</td>
									</tr>

								</table>
								<asp:TextBox id="txtColorName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ColorName")%>' Visible="false"/>
								<INPUT id="txtMaterialColorID" type="hidden" name="Selected_LB" runat="server">
							</ItemTemplate>
						</asp:datalist></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="500">
						<table class="ToolbarShort" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead"><asp:label id="lblMaterialColor" runat="server">Material Color</asp:label>
								</td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" Width="500" DataKeyField="MaterialColorID"  AutoGenerateColumns="False"
							PageSize="1000" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0" EnableViewState="False" AllowPaging="False"
							 AllowSorting="true" >
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeaderOver"></HeaderStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
						<table cellspacing="2" cellpadding="0" width="100%" border="0">
							<tr class="fontHead">
								<td>&nbsp;</td>
								<td align="right"><cc1:bwimagebutton id="btnAddColor" runat="server"  message="NONE"></cc1:bwimagebutton></td>
							</tr>
						</table>
					</td>
					<td valign="top">
						<table class="ToolbarShort" height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead"><asp:label id="lblMaterialImage" runat="server">Material Image</asp:label>
								</td>
							</tr>
						</table>
						<asp:image id="imgMaterial" runat="server" BorderColor="Transparent"></asp:image></td>
				</tr>
			</table>
		</form>
	</body>
</html>
