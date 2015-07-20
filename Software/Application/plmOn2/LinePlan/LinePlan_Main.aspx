<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Main.aspx.vb" Inherits="plmOnApp.LinePlan_Main" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
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
								<td><div align="right">
										<DIV align="right">
											<asp:Label id="lblHeader" runat="server" Font-Size="XX-Large" ForeColor="Silver">List</asp:Label></DIV>
									</div>
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
												<asp:Label ID="lblIssue" runat="server" Text="Issues Request..."></asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_sort.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead"><asp:Label ID="Label1" runat="server" Text="Who, Where, When Change..."></asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_team.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead"><asp:Label ID="Label2" runat="server" Text="Who's been here..."></asp:Label>
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


