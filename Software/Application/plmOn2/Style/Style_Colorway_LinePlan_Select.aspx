<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Colorway_LinePlan_Select.aspx.vb" Inherits="plmOnApp.Style.Colorway.Style_Colorway_LinePlan_Select" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">

    
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" 
                            style="height: 24px"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblBodyHeader" runat="server" ForeColor="#E0E0E0" 
                            Font-Size="X-Large" Font-Names="Tahoma,Verdana" Text="Color Folder"></asp:label></td>
				</tr>
			</table>
			<table cellspacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top">
						<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="top">
					<td>
						<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<tr valign="middle">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td width="16"><asp:checkbox id="cbThumbnail" runat="server" AutoPostBack="True"></asp:checkbox></td>
								<td class="fontHead" width="100"><asp:label id="lblThumbnail" runat="server" Text="Thumbnail?"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								<td class="fontHead" align="right" width="110"><asp:label id="lblRecordsperPage" runat="server" Text="Records per Page:"></asp:label></td>
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
								<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
							</tr>
						</table>
						<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td>&nbsp;</td>
								<td valign="top" width="100%">
									<table height="45">
										<tr>
											<td>&nbsp;</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="ColorPaletteID" 
                            BorderStyle="Solid" BorderWidth="1px">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
				</tr>
			</table>
		</form>
		<SCRIPT language="javascript">
			var frm = document.Form1 ;
			function CheckAll( checkAllBox )
			{
			var actVar = checkAllBox.checked ;
			for(i=0;i< frm.length;i++)
			{
				e=frm.elements[i];
				if ( e.type=='checkbox' && e.name.indexOf("chkSelected") != -1 )
				e.checked= actVar ;
			}
			}
		</SCRIPT>

    
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
