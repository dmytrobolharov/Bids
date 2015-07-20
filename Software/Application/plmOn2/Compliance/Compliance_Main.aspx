<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Compliance_Main.aspx.vb" Inherits="plmOnApp.Compliance_Main" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Compliance</title>
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
		<asp:Panel runat="server" ID="pnlPerm" Visible=false>
				<table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
					<tr>
						<td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" 
                                        Text="You might not have permission to access user groups using your credentials." 
                                        CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                          </td>
                      </tr>
                  </table>			
			</asp:Panel>
			
			<asp:Panel runat="server" ID="pnlMain">	
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
								<td><div align="right">&nbsp;</div>
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
												<asp:Label ID="lblIssuesRequest" runat="server">Issues &amp; Request...</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_sort.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead">
    											<asp:Label ID="lblWhoWhereWhenChange" runat="server">Who, Where, When Change...</asp:Label>
											</td>
										</tr>
									</table>
								</td>
								<td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="20"><div align="center"><img src="../System/Icons/icon_team.gif" width="16" height="16"></div>
											</td>
											<td class="fontHead">
											    <asp:Label ID="lblWhosBeenHere" runat="server">Who's been here...</asp:Label>
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
			</asp:Panel>
		</form>
	</body>
</HTML>
