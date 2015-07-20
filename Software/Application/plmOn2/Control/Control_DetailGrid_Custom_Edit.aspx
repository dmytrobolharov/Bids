<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DetailGrid_Custom_Edit.aspx.vb" Inherits="plmOnApp.Control_DetailGrid_Custom_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					    <cc1:bwimagebutton id="btnSizeSort" runat="server" ></cc1:bwimagebutton>
					    <cc1:bwimagebutton id="btnRemove" runat="server" ></cc1:bwimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
				</tr>
			</table>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR bgColor="#ffffff">
					<TD vAlign="top"><asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" PageSize="100" AllowSorting="True"
							DataKeyField="TemplateDetailGridItemID" BackColor="White">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid>
						<TABLE cellSpacing="2" cellPadding="0" width="500" border="0">
							<TR class="fontHead">
								<TD width="10">&nbsp;</TD>
								<TD noWrap width="85"><asp:Label ID="lblNumOfRows" runat="server"></asp:Label></TD>
								<TD width="35"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
										<asp:ListItem Value="2">2</asp:ListItem>
										<asp:ListItem Value="3">3</asp:ListItem>
										<asp:ListItem Value="4">4</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD width="300"><cc1:confirmedimagebutton id="btnAddRow" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
							</TR>
						</TABLE>
						<asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>
			<BR>
			
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
