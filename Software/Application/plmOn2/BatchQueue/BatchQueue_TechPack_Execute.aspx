<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQueue_TechPack_Execute.aspx.vb" Inherits="plmOnApp.BatchQueue_TechPack_Execute" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title>Tech Pack Batch Queue</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	</head>
	
	<body onbeforeunload="busyBox.Show();">
        <script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">								           
							
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
						<cc1:confirmedimagebutton id="btnCancel" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr vAlign="top">
					<td>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="BatchQueueID" AllowSorting="False">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid>
					</td>
				</tr>
			</table>

			<div id="BusyBoxDiv" style="BORDER-RIGHT: gainsboro 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: gainsboro 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: gainsboro 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: gainsboro 0px solid; POSITION: absolute; BACKGROUND-COLOR: transparent; TEXT-ALIGN: center">
				<p style="WIDTH: 220px; TEXT-ALIGN: center">
					<table cellSpacing="1" cellPadding="1" width="100%" border="0">
						<tr>
							<td width="50" height="32">
							    <img id="BusyBoxImg" height="32" src="../system/images/busy_Layer_0.gif" width="32">
							</td>
							<td class="fontHead">
							    <asp:Label ID="lblPleaseWait" runat="server" Text="Please Wait..."></asp:Label>
                                <br />
								<asp:Label ID="lblTechPackProcessing" runat="server" Text="Tech Pack Processing"></asp:Label>
							</td>
						</tr>
					</table>
				</p>
			</div>

			<script language="javascript" type="text/javascript">
			    // Instantiate our BusyBox object
			    var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);
			</script>

		</form>
	</body>
</html>
