<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Report_Search.aspx.vb" Inherits="plmOnApp.Report_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Search</title>
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<SCRIPT language="JavaScript" type="text/javascript">
		<!--
		function DoPageLoad() 
		{
			
			var Timer = setTimeout('self.focus();', 1000);
		}
		// -->
		</SCRIPT>
	</HEAD>
	<body onbeforeunload="busyBox.Show();" onload="DoPageLoad();">
		<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				height="27">
				<TR>
					<TD vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<asp:Label id="lblHeader" runat="server"></asp:Label></TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" vAlign="top"><table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" runat="server" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<iframe src="<%=SqlReportUrl%>" height="85%" width="100%" scrolling="no" frameborder=no>
			</iframe><br>
			<div id="BusyBoxDiv" style="BORDER-RIGHT: gainsboro 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: gainsboro 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: gainsboro 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: gainsboro 0px solid; POSITION: absolute; BACKGROUND-COLOR: transparent; TEXT-ALIGN: center">
				<p style="WIDTH: 220px; TEXT-ALIGN: center">
				<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
					<TR>
						<TD height="32" width="50"><img id="BusyBoxImg" src="../system/images/busy_Layer_0.gif" width="32" height="32"></TD>
						<TD class="fontHead"><asp:label id="lblPleaseWait" runat="server" CssClass="fontHead">Please Wait...</asp:label><br>
							<asp:label id="lblReportLoading" runat="server" CssClass="fontHead">Report Loading</asp:label></TD>
					</TR>
				</TABLE>
				</p>
			</div>
			<script language="javascript" type="text/javascript">
				// Instantiate our BusyBox object
				var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);
			</script>
		</form>
	</body>
</HTML>
