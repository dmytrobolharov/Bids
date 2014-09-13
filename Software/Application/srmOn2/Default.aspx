<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Default.aspx.vb" Inherits="srmOnApp._Default"   %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>SRM OnDemand</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="./System/CSS/Style.css" type="text/css" rel="stylesheet">
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
	<body bgColor="gainsboro" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR>
						<TD align="center">
							<DIV class="fontHead" align="center">
								<TABLE id="Table2" borderColor="#666666" height="0" cellSpacing="0" cellPadding="0" width="801"
									border="2" style="WIDTH: 801px; HEIGHT: 418px">
									<TR>
										<TD bgColor="#ffffff">
											<TABLE id="Table3" height="1" cellSpacing="0" cellPadding="0" width="100%" border="0">
												<TR>
													<TD align="center" bgColor="#666666" height="80">
														<DIV align="right"><IMG src="System/Images/main_yunique.gif" width="300" height="75"></DIV>
													</TD>
												</TR>
											</TABLE>
											<TABLE id="Table4" width="794" border="0" style="WIDTH: 794px; HEIGHT: 321px">
												<TR>
													<TD vAlign="top" align="right" width="40%">
														<TABLE height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
															<TR>
																<TD>
																	<P>&nbsp;</P>
																</TD>
															</TR>
														</TABLE>
														<br>
														<BR>
														<BR>
														<BR>
														<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
															<TR>
																<TD>
																	<DIV align="right"><IMG src="System/Images/main_srmOn.gif" align="middle" width="262" height="139">&nbsp;</DIV>
																</TD>
															</TR>
															<TR>
																<TD>&nbsp;</TD>
															</TR>
															<TR>
																<TD class="fontHead" style="HEIGHT: 11px">
																	<DIV align="right"></DIV>
																</TD>
															</TR>
															<TR>
																<TD style="HEIGHT: 13px">
																	<DIV class="fontHead" align="right">
																		<asp:Label id="lblLicense" runat="server">License</asp:Label></DIV>
																</TD>
															</TR>
														</TABLE>
													</TD>
													<TD align="center" width="40">
													</TD>
													<TD noWrap align="left" width="60%" background="System/Images/main_bk_on.gif">
														<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
															<TR>
																<TD>&nbsp;</TD>
															</TR>
														</TABLE>
														<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
															<TR>
																<TD>
																	<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																		<TR>
																			<TD>&nbsp;</TD>
																		</TR>
																		<TR>
																			<TD>
																				<TABLE>
																					<TR>
																						<TD class="fontHead" style="WIDTH: 86px" width="86"><STRONG style="COLOR: black"><asp:label id="lblUserName" runat="server">User 
																								Name:</asp:label></STRONG></TD>
																						<TD width="124"><INPUT id="txtUserName" type="text" name="txtUserName" runat="server"></TD>
																						<TD width="9">
																							<ASP:REQUIREDFIELDVALIDATOR id="vUserName" runat="server" ErrorMessage="*" Display="Static" ControlToValidate="txtUserName"></ASP:REQUIREDFIELDVALIDATOR></TD>
																					</TR>
																					<TR>
																						<TD class="fontHead" style="WIDTH: 86px"><STRONG style="COLOR: #000000"><asp:label id="lblUserPass" runat="server">Password:</asp:label></STRONG></TD>
																						<TD><INPUT id="txtUserPass" type="password" name="txtUserPass" runat="server"></TD>
																						<TD>
																							<ASP:REQUIREDFIELDVALIDATOR id="vUserPass" runat="server" ErrorMessage="*" Display="Static" ControlToValidate="txtUserPass"></ASP:REQUIREDFIELDVALIDATOR></TD>
																					</TR>
																					<TR> 
																						<TD class="fontHead" style="WIDTH: 86px"><STRONG style="COLOR: black"><asp:label id="lblEMail" runat="server">Email:</asp:label></STRONG></TD>
																						<TD><INPUT id="txtEmail" type="text" runat="server"></TD>
																						<TD></TD>
																					</TR>
																					<TR>
																						<TD style="WIDTH: 86px"></TD>
																						<TD><INPUT id="cmdLogin" type="submit" value="Logon" name="cmdLogin" runat="server"></TD>
																						<TD></TD>
																					</TR>
																				</TABLE>
																			</TD>
																		</TR>
																		<TR>
																			<TD class="fontHead"><FONT color="#ff0000" size="2">&nbsp;
																					<asp:label id="lblMsg" runat="server" Font-Name="Verdana" ForeColor="Red" 
                                                                                    CssClass="fontHead"></asp:label></FONT></TD>
																		</TR>
																		<TR>
																			<TD>&nbsp;</TD>
																		</TR>
																	</TABLE>
																			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																			<A class="font" onclick="window.open('Password.aspx','_Password','width=400,height=150,resizable=no,scrollbars=no,toolbar=no,status=yes'); return false;"
																				href=""><FONT class="fontHead" color="#000000"><asp:label id="lblForgotPwd" runat="server">Forgot Password?</asp:label></FONT></A>																	
																</TD>
															</TR>
														</TABLE>
													</TD>
												</TR>
											</TABLE>
											<TABLE height="15" cellSpacing="0" cellPadding="0" width="100%" border="0">
												<TR>
													<TD align="right" bgColor="#666666">
														<asp:Label id="lblUrl" runat="server" ForeColor="White"></asp:Label></TD>
												</TR>
											</TABLE>
										</TD>
									</TR>
								</TABLE>
							</DIV>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</form>
	</body>
</HTML>
