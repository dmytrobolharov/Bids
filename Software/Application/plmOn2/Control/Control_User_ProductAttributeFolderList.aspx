<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_User_ProductAttributeFolderList.aspx.vb" Inherits="plmOnApp.Control_User_ProductAttributeFolderList" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title></title>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

		<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td><cc1:confirmedimagebutton id="btnAdd" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				<td class="FontHead" align="right" width="75"></td>
				<td width="40"></td>
				<td></td>
			</tr>
		</table>
		
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                        Font-Size="X-Large" ForeColor="#999999"></asp:label></td>
                      
			</tr>
		</table>
		<table cellSpacing="2" cellPadding="0" width="100%" border="0" 
            style="background-color: #FFFFFF">
			<tr>
				<td width="900">
                    <asp:Panel ID="Panel1" runat="server">
                        <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
                    </asp:Panel>
                </td>
				<td></td>  
			</tr>
		</table>
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="top"></td>
			</tr>
		</table>
        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr vAlign="top">
				<td>
					<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<tr vAlign="middle">
							<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
							<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
							<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
							<td width="10">&nbsp;</td>
							<td noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
							<td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
							<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
									<asp:ListItem Value="5">5</asp:ListItem>
									<asp:ListItem Value="10">10</asp:ListItem>
									<asp:ListItem Value="15">15</asp:ListItem>
									<asp:ListItem Value="20">20</asp:ListItem>
									<asp:ListItem Value="25">25</asp:ListItem>
									<asp:ListItem Value="30">30</asp:ListItem>
									<asp:ListItem Value="40">40</asp:ListItem>
									<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
								</asp:dropdownlist></td>
							<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
						</td>
					</TABLE>
					<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						<tr>
							<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
							<td vAlign="top" width="100%">
								<table height="45">
									<tr>
										<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" >
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
					</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			    </td>
			</tr>
		</table>			    
    </div>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
