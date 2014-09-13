<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Colorway_Select.aspx.vb" Inherits="plmOnApp.Style.Colorway.Style_Colorway_Select" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title><%= Me.strColorway %></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif"></TD>
					<TD><asp:imagebutton 
					id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton><cc1:confirmedimagebutton 
					id="btnAddColor" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnRemoveColor" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnNoApplicable" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table class="TableHeaderGreen" height="25" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<tr>
					<td width="10">&nbsp;</td>
					<td><asp:label id="lblMaterialSelected" runat="server" CssClass="font" Text="Material Selected"></asp:label></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td bgColor="#ffffff"><asp:label id="lblMaterial" runat="server" CssClass="font"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="1" cellPadding="1" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="10">&nbsp;</td>
								<td><%=getsystemtext("Selected")%> <%= strColor %></td>
							</tr>
						</table>
						<TABLE id="Table1" borderColor="silver" height="100" cellSpacing="0" cellPadding="0" width="65"
							align="center" border="1">
							<TR >
								<TD ><asp:imagebutton id="Imagebutton1" runat="server" Width="65px" CommandName="ColorChip"></asp:imagebutton></TD>
    						</TR>
							<TR >
								<TD><asp:label runat="server" ID="lblAttributes"  CssClass="font"></asp:label></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td width="10">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>

			
			<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td width="10">&nbsp;</td>
					<td><%=getsystemtext("Available")%> <%= strColor %> </td>
				</tr>
			</table>
			
			
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>			
			
			<br />
			<asp:checkbox id="chkAllColor" runat="server" ></asp:checkbox><%=getsystemtext("Apply to All")%> <%= strColorway %>&nbsp;&nbsp;
			<asp:checkbox id="chkAllSizes" runat="server" ></asp:checkbox><%=getsystemtext("Apply to All Sizes")%>&nbsp;&nbsp;
			<asp:checkbox id="chkAllRM" runat="server" Text="Apply to All RM Colourway" />&nbsp;&nbsp;
			<asp:CheckBox ID="chkShowAll"  runat="server" AutoPostBack="true" Text="Show All" />
			
			<asp:datagrid id="dgColors" runat="server" DataKeyField="MaterialColorID" AutoGenerateColumns="False" ShowHeader="False" 
			    AllowPaging="False" >
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<ItemStyle Width="50px"></ItemStyle>
						<ItemTemplate>
						    <cc1:confirmedimagebutton id="imgColor" runat="server"  CommandName="Select" Message="NONE" />
							<input id="txtColorPaletteID" type="hidden" runat="server" />
							<input type = "hidden" id ="hdnDescription" runat ="server" />
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle Visible="False"></PagerStyle>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			
			</form>

	</body>
</html>
