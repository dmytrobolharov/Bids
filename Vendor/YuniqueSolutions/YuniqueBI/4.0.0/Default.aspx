<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Default.aspx.vb" Inherits="YuniqueBI.PageDefault" trace="False" traceMode="SortByTime"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Yunique BI</title>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="./System/CSS/Style.css" type="text/css" rel="stylesheet" runat="server" id="styleCss" />
		<script language="JavaScript">
		<!--

			function detectPopupBlocker() {
			var myTest = window.open("about:blank","","directories=no,height=100,width=100,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,top=0,location=no");
			if (!myTest) {
				alert("System has been blocked by POP-UP BLOCKER.\nPlease disable the POP-UP BLOCKER and try again\nor Please contact your system administrator. ");
			} else {
				myTest.close();
				//alert("No popup blocker was detected.");
			}
			}
			
			window.onload = detectPopupBlocker;

			
			if (window.screen) {
				var aw = screen.availWidth;
				var ah = screen.availHeight;
				window.moveTo(0, 0);
				window.resizeTo(aw, ah);
			}
			
			if (self != top) top.location.replace(self.location);	

			self.focus();
			

		//-->
		</script>
	</HEAD>
	<body bgColor="gainsboro">
		<form id="Form1" method="post" runat="server">
			<TABLE height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table1">
				<TBODY>
					<TR>
						<TD align="center">
							<TABLE borderColor="#666666" height="0" cellSpacing="0" cellPadding="0" width="800" border="2"
								id="Table2">
								<TBODY>
									<TR>
										<TD bgColor="#ffffff">
											<TABLE height="1" cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table3">
												<TBODY>
													<TR>
														<TD align="center" bgColor="#666666" height="80"><div align="right"><IMG src="System/Images/main_yunique.gif" width="300" height="75" id="imgYuniqueLogo" runat="server"></div>
														</TD>
													</TR>
												</TBODY>
											</TABLE>
											<TABLE width="100%" border="0" id="Table4">
												<TBODY>
													<TR>
														<TD vAlign="top" align="right" width="40%">
															<TABLE height="50" cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table5">
																<TBODY>
																	<TR>
																		<TD>&nbsp;</TD>
																	</TR>
																</TBODY>
															</TABLE>
															<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table6">
																<TBODY>
																	<TR>
																		<TD>
																			<DIV align="right"><IMG src="System/Images/main_yuniquebi.gif" align="middle" 
                                                                                    width="262" height="139" id="imgPlmOn" runat="server">&nbsp;</DIV>
																		</TD>
																	</TR>
																	<TR>
																		<TD height="60">
																			<DIV class="fontHead" align="right"><asp:label id="lblLicense" runat="server">License</asp:label></DIV>
																		</TD>
																	</TR>
																</TBODY>
															</TABLE>
															<BR>
														</TD>
														<TD align="center" width="40"><BR>
														</TD>
														<TD runat="server" id="tdImageOn" noWrap align="left" width="60%" background="System/Images/main_bk_on.gif">
															<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table7">
																<TBODY>
																	<TR>
																		<TD height="75">&nbsp;</TD>
																	</TR>
																</TBODY>
															</TABLE>
															<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" id="Table8">
																<TBODY>
																	<TR>
																		<TD>
																			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																				<TBODY>
																					<TR>
																						<TD>&nbsp;</TD>
																					</TR>
																					<TR>
																						<TD>
																							<table>
																								<tr>
																									<td class="fontHead" style="WIDTH: 86px" width="86"><strong><asp:label id="lblUserName" runat="server">User Name:</asp:label></strong></td>
																									<td width="124"><input id="txtUserName" type="text" name="txtUserName" runat="server" maxlength="25"></td>
																									<td width="9"><ASP:REQUIREDFIELDVALIDATOR id="vUserName" runat="server" ControlToValidate="txtUserName" Display="Static" ErrorMessage="*"></ASP:REQUIREDFIELDVALIDATOR></td>
																								</tr>
																								<tr>
																									<td class="fontHead" style="WIDTH: 86px"><strong><asp:label id="lblPassword" runat="server">Password:</asp:label></strong></td>
																									<td><input id="txtUserPass" type="password" name="txtUserPass" runat="server" maxlength="15">&nbsp;&nbsp;
																										<a class="font" onclick="window.open('Password.aspx','_Password','width=400,height=150,resizable=no,scrollbars=no,toolbar=no,status=yes'); return false;"
																											href=""></a>
																									</td>
																									<td><ASP:REQUIREDFIELDVALIDATOR id="vUserPass" runat="server" ControlToValidate="txtUserPass" Display="Static" ErrorMessage="*"></ASP:REQUIREDFIELDVALIDATOR></td>
																								</tr>
																								<tr>
																									<td style="WIDTH: 86px"></td>
																									<td><input id="cmdLogin" type="submit" value="Logon" name="cmdLogin" runat="server"></td>
																									<td></td>
																								</tr>
																							</table>
																						</TD>
																					</TR>
																					<TR>
																						<TD class="fontHead"><FONT color="#ff0000" size="2">&nbsp;
																								<asp:label id="lblMsg" runat="server" ForeColor="red" Font-Name="Verdana" Font-Size="XX-Small"
																									CssClass="fontHead"></asp:label></FONT></TD>
																					</TR>
																					<TR>
																						<TD>&nbsp;</TD>
																					</TR>
																				</TBODY>
																			</TABLE>
																			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																			<A class="font" onclick="window.open('Password.aspx','_Password','width=400,height=150,resizable=no,scrollbars=no,toolbar=no,status=yes'); return false;"
																				href=""><FONT class="fontHead" color="#000000"><asp:Label ID="lblForgot" runat="server" Text="Forgot Password?"></asp:Label></FONT></A>
																		</TD>
																	</TR>
																</TBODY>
															</TABLE>
															
														</TD>
													</TR>
												</TBODY>
											</TABLE>
											<TABLE height="15" cellspacing="0" cellpadding="0" width="100%" border="0" id="Table11">
												<TBODY>
													<TR>
														<TD align="right" bgColor="#666666"><asp:label id="lblUrl" runat="server" ForeColor="White">url</asp:label></TD>
													</TR>
												</TBODY>
											</TABLE>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</form>
	</body>
</HTML>
