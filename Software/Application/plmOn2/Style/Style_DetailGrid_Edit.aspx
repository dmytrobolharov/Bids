<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DetailGrid_Edit.aspx.vb" Inherits="plmOnApp.Style.DetailGrid.Style_DetailGrid_Edit" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td noWrap width="650"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnSizeSort" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnCopy" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnTemplate" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnRemove" runat="server" ></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
                         <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton></td>
					<td class="FontHead" align="right" width="75">&nbsp;<asp:Label id="lblSelectSet" runat="server" >Select Set:</asp:Label></td>
					<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
							CssClass="font"></asp:dropdownlist></td>
					<td><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton></td>
				</tr>
			</table>
			<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit>
			<asp:panel id="pnlChange" runat="server">
			    <uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td valign="top">
						<asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" PageSize="100" AllowSorting="True"
							DataKeyField="StyleDetailGridID" BackColor="White">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid>
						<table cellspacing="2" cellpadding="0" width="500" border="0">
							<tr class="fontHead">
								<td width="10">&nbsp;</td>
								<td noWrap width="85"><asp:Label id="lblNoofRow" runat="server">No. of Row(s):</asp:Label></td>
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
								<td width="300"><cc1:confirmedimagebutton id="btnAddRow" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
							</tr>
						</table>
						<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
				</tr>
			</table>
			<BR>
			<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
					<td class="TableBar">
						<asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
						<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
