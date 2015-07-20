<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_List_Main.aspx.vb" Inherits="plmOnApp.Material_List_Main" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Style_Main</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table width="100%" height="27" border="0" cellpadding="0" cellspacing="0" class="TableHeader">
				<tr>
					<td width="100%">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" bgcolor="#ffffff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><div align="right"><img src="../System/Images/bar_MaterialFolder.gif" width="300"></div>
								</td>
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
											<asp:Label ID="lblIssuesRequest" runat="server" Text="Issues & Request..."></asp:Label>												
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_sort.gif" width="16" height="16"></div>
											</td>											
											<td class="fontHead">
											<asp:Label ID="lblWho" runat="server" Text="Who, Where, When Change..."></asp:Label>											
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_team.gif" width="16" height="16"></div>
											</td>											
											<td class="fontHead">
											<asp:Label ID="lblWhoBeen" runat="server" Text="Who's been here..."></asp:Label>											
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
