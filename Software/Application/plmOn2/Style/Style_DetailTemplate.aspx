<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DetailTemplate.aspx.vb" Inherits="plmOnApp.Style_DetailTemplate" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle"></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="80"><cc1:confirmedimagebutton id="btnImgClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
					<td width="80"></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Select Design Detail Template</asp:label></td>
				</tr>
			</table>
            <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	            <tr valign="middle">
		        <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		        <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
		        <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
		        <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
		        <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
		        <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
		        <td width="10">&nbsp;</td>
		        <td nowrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
		        <td width="16"><asp:checkbox id="cbThumbnail" runat="server" AutoPostBack="True" Visible="False"></asp:checkbox></td>
		        <td class="fontHead" align="right" width="110">
                <asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
		        <td width="25">
		            <asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
				        <asp:ListItem Value="5">5</asp:ListItem>
				        <asp:ListItem Value="10">10</asp:ListItem>
				        <asp:ListItem Value="15">15</asp:ListItem>
				        <asp:ListItem Value="20">20</asp:ListItem>
				        <asp:ListItem Value="25">25</asp:ListItem>
				        <asp:ListItem Value="30">30</asp:ListItem>
				        <asp:ListItem Value="40">40</asp:ListItem>
				        <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
			        </asp:dropdownlist>
		        </td>
		        <td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
	        </tr>
        </table>
			
			
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="top">
					<td>

						<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
								<td width="100%"><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="TemplateStyleDetailID" AutoGenerateColumns="False">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Width="50px"></HeaderStyle>
									<ItemStyle Width="50px"></ItemStyle>
									<HeaderTemplate>
										<asp:label id="lblCopy" runat="server" CssClass="fonthead"><%#GetSystemText("Copy")%></asp:label>
									</HeaderTemplate>
									<ItemTemplate>
										<cc1:confirmedimagebutton id="imgBtnCopy" runat="server" CommandName="Copy" 
											 Message="NONE" ></cc1:confirmedimagebutton>
										<asp:TextBox id="txtStyleNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TemplateStyleDetailName")%>' Visible="false">
										</asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
				</tr>
			</table>
		</form>
	</body>
</html>
