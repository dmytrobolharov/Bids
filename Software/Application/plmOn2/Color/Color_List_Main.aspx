<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_List_Main.aspx.vb" Inherits="plmOnApp.Color_List_Main" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Color</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
		<link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	</HEAD>
	<body MS_POSITIONING="GridLayout">
	    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" bgcolor="#ffffff">
						<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
							height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td>&nbsp;<asp:label id="lblColorHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Color Palette...</asp:label></td>
							</tr>
						</table>
						<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="33%">&nbsp;</td>
								<td width="33%">&nbsp;</td>
								<td width="33%">&nbsp;</td>
							</tr>
						</table>
						<table width="100%" height="50%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="33%">&nbsp;</td>
								<td width="33%">&nbsp;</td>
								<td width="33%">&nbsp;</td>
							</tr>
						</table>
						<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" background="../System/Images/MiddleFill.jpg">
							<tr valign="top">
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_issue.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead">
												<asp:Label id="lblIssuesRequest" runat="server" Text="Issues & Request..."/>
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_sort.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead"><asp:Label id="lblWhoWhereWhenChange" runat="server" Text="Who, Where, When Change..."/>
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_team.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead"><asp:Label id="lblWhosBeenHere" runat="server" Text="Who's been here..."/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td width="200" bgcolor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
