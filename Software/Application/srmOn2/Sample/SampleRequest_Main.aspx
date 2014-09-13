<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Main.aspx.vb" Inherits="srmOnApp.SampleRequest_Main" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Concept</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="Expires" CONTENT="0">
		<meta http-equiv="Cache-Control" CONTENT="no-cache">
		<meta http-equiv="Pragma" CONTENT="no-cache">

			
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
		<script language="JavaScript">
		<!--
		javascript:window.history.forward(1);
		//-->
		</script>		
	</HEAD>

	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
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
										<asp:Label id="lbHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Program Folder</asp:Label></div>
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
								<td width="211" style="WIDTH: 211px">&nbsp;</td>
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
												<asp:label id="lblIssuesRequest" runat="server">Issues &amp; Request...</asp:label>
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_sort.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead"><asp:label id="lblWhoWhereWhenChange" runat="server">Who, Where, When Change...</asp:label>
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_team.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead"><asp:label id="lblWhosBeenHere" runat="server">Who's been here...</asp:label>
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
