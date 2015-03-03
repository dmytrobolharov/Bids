<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Workflow_LinkWhereUsed.aspx.vb" Inherits="plmOnApp.Style_Workflow_LinkWhereUsed" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>where used</title>

		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
		
		<script language="javascript">
			function SelectColor(sColor,sTxtBox) 
			{
			opener.document.Form1[sTxtBox].value = sColor;
			self.close();
			}
		</script>
	</head>
	<body >
		<form id="Form1" method="post" runat="server" >
		    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
					Height="0px"></asp:imagebutton><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					&nbsp;<asp:checkbox id="cbThumbnail"  AutoPostBack="True" runat="server"></asp:checkbox></TD>					
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Medium" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="top">
					<td>
						<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<tr valign="middle">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" width="10"></td>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								<td noWrap align="center" width="75"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								<td class="fontHead" align="right" width="110"><asp:label id="lblRecordsperPage" runat="server">POM per Page:</asp:label></td>
								<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1000">ALL</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
										<asp:ListItem Value="75">75</asp:ListItem>
										<asp:ListItem Value="100">100</asp:ListItem>
									</asp:dropdownlist></td>
								<td width="10"><asp:button id="btnRepage" onclick="RePage" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
							</tr>
						</table>
						<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
								<td width="100%"><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleID" >
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle></asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
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
			
		function disableEnterKey()
		{
		if (window.event.keyCode == 13) window.event.keyCode = 0;
		}
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
