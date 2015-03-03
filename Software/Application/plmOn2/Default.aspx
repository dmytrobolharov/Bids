<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Default.aspx.vb" Inherits="plmOnApp.PageDefault"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML style="height: 100%;">
	<HEAD>
        <meta http-equiv="x-ua-compatible" content="IE=Edge"/> 
        <%--<link REL='SHORTCUT ICON' href='favicon.ico'>--%>
		<title>plmOn</title>
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
			
			//if (self != top) top.location.replace(self.location);	

			self.focus();


		//-->
        </script>
                <style>
 

.textInput1 {
	BORDER-BOTTOM: #ff0000 1px solid; BORDER-LEFT: #ff0000 1px solid; BACKGROUND: #555555; COLOR: #ffffff; FONT-SIZE: 1.1em; BORDER-TOP: #ff0000 1px solid; BORDER-RIGHT: #ff0000 1px solid
}
.fieldHolder {
	width: 150px; BACKGROUND: url(System/Images/textfield.png) no-repeat; FLOAT: left; HEIGHT: 27px
}
.textInput2 {
	                border-style: none;
                        border-color: inherit;
                        border-width: medium;
                        MARGIN-TOP: 5px; 
                        width: 138px; 
                        background: none transparent scroll repeat 0% 0%; HEIGHT: 22px; COLOR: #000000; MARGIN-LEFT: 5px;
                    }
 
.round
{
 margin:0;
 height:30px;
 width:146px;
 background:url(System/Images/textfield.png) no-repeat bottom;
 float: left;
}

.round input[type="text"], .round input[type="password"]
{
 
 background: none;
 border:none;
 margin-top: 5px;
 margin-left: 5px;
}

</style>
	</HEAD>
	<body bgColor="gainsboro" style="height: 100%;">
		<form id="Form1" method="post" runat="server" style="height: 100%;">
			<TABLE height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR>
						<TD align="center">
							<TABLE cellspacing="0" cellpadding="0" width="860" border="0"
								id="Table2">
								<TBODY>
									<TR>
										<TD class="LoginPage">
											<TABLE height="1" cellSpacing="0" cellPadding="0" width="100%" border="0">
												<TBODY>
													<TR>
													    <TD width="20">&nbsp;</TD>
													    <TD width="60" valign="top">
                                                            <asp:Label ID="lblVersion" runat="server"></asp:Label>
                                                        </TD>
														<TD align="center" height="80"><div align="right">
                                                            <br /><br />
                                                            <img src="System/Images/yunique_logo.png" width="271" id="imgYuniqueLogo" 
                                                                runat="server"></div>
														</TD>
														<TD width="55">&nbsp;</TD>
													</TR>
												</TBODY>
											</TABLE>
											<TABLE width="100%" border="0">
												<TBODY>
													<TR>
														<TD valign="top" align="right" style="height:250px; width:450px;">

															<TABLE cellSpacing="0" cellPadding="0" border="0">
																<TBODY>
	<%--																<TR>
																		<TD>
																			<DIV align="right">&nbsp;</DIV>
																		</TD>
																	</TR>--%>
																	<TR>
																		<TD align="center" style="width: 321px; height: 200px" >
                                                                            <img alt="" src="System/Images/NewLogo.png"  style="width: 200px;"/>
                                                                        </TD>
																	</TR>
																	<TR>
																		<TD class="fontHead" style="HEIGHT: 11px">
																			<DIV align="right"></DIV>
																		</TD>
																	</TR>
																	<TR>
																		<TD align="center" valign="top" style="height: 50px">
																			<asp:label CssClass="fontHead"  id="lblLicense" runat="server">Yunique Solutions </asp:label>
																		</TD>
																	</TR>
																</TBODY>
															</TABLE>
															
														</TD>
														<TD align="center" width="135px"><BR>
														<%--    <img alt="" src="System/Images/Login_Bar.gif" 
                                                                style="width: 2px; height: 250px" />--%></TD>
														<TD runat="server" id="tdImageOn" noWrap align="left" width="325">
															<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																<TBODY>
																	<TR>
																		<TD height="75">
																			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																				<TBODY>
																					<TR>
																						<TD>&nbsp;</TD>
																					</TR>
																					<TR>
																						<TD>
															                                <table>
																								<tr>
																									<td class="fontHead" style="width: 86px"><strong><asp:label id="lblUserName" runat="server">User Name:</asp:label></strong></td>
																									<td><div class="fieldHolder"><input id="txtUserName" type="text" name="txtUserName" runat="server" maxlength="25" class="textInput2"></div></td>
																									<td width="9"><ASP:REQUIREDFIELDVALIDATOR id="vUserName" runat="server" ControlToValidate="txtUserName" Display="Static" ErrorMessage="*"></ASP:REQUIREDFIELDVALIDATOR></td>
																								</tr>
																								<tr>
																									<td class="fontHead" style="WIDTH: 86px"><strong><asp:label id="lblPassword" runat="server">Password:</asp:label></strong></td>
																									<td><div class="fieldHolder"><input id="txtUserPass" type="password" name="txtUserPass" runat="server" maxlength="15" class="textInput2">
																										<a class="font" onClick="window.open('Password.aspx','_Password','width=400,height=150,resizable=no,scrollbars=no,toolbar=no,status=yes'); return false;"
																											href=""></a></div>
																									</td>
																									<td><ASP:REQUIREDFIELDVALIDATOR id="vUserPass" runat="server" ControlToValidate="txtUserPass" Display="Static" ErrorMessage="*"></ASP:REQUIREDFIELDVALIDATOR></td>
																								</tr>
																								<tr>
																									<td style="WIDTH: 86px"></td>
																									<td align="left">
                                                                                                        <asp:Button ID="cmdLogin" type="submit" Text="Logon" CssClass="LoginButton"  runat="server"></asp:Button>&nbsp;&nbsp;
                                                                                                    </td>
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
																			</TD>
																	</TR>
																</TBODY>
															</TABLE>
															<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
																<TBODY>
																	<TR>
																		<TD>
																			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																			<A class="font" onClick="window.open('Password.aspx','_Password','width=400,height=150,resizable=no,scrollbars=no,toolbar=no,status=yes'); return false;"
																				href=""><FONT class="fontHead" color="#000000"><asp:Label ID="lblForgot" runat="server" Text="Forgot Password?"></asp:Label></FONT></A>
																		</TD>
																	</TR>
																</TBODY>
															</TABLE>
															
														</TD>
													</TR>
												</TBODY>
											</TABLE>
                                            <br />
											<TABLE height="50" cellspacing="0" cellpadding="0" width="100%" border="0">
													<TR>
														<TD align="center"><asp:label id="lblCopyright" runat="server" ForeColor="#333333" class="fontHead">&copy; 2012 Gerber Scientific Inc. All rights reserved.</asp:label></TD>
													</TR>
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

    <script type="text/javascript">
        // IE8, IE9 "JSON is undefind" fix
        var JSON = JSON || {};
        // implement JSON.stringify serialization
        JSON.stringify = JSON.stringify || function (obj) {
            var t = typeof (obj);
            if (t != "object" || obj === null) {
                if (t == "string") {
                    obj = '"' + obj + '"';
                }
                return String(obj);
            } else {
                var json = [],
            arr = (obj && obj.constructor == Array),
            v;
                for (var n in obj) {
                    v = obj[n];
                    t = typeof (v);
                    if (t == "string") {
                        v = '"' + v + '"';
                    } else if (t == "object" && v !== null) {
                        v = JSON.stringify(v);
                    }
                    json.push((arr ? "" : '"' + n + '":') + String(v));
                }
                return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
            }
        };
        function supportsStorage() {
            try {
                return 'localStorage' in window && window['localStorage'] !== null;
            } catch (e) {
                return false;
            }
        };
function writeYuniqueData() {
    try {
        window.localStorage.setItem('Yunique.User', JSON.stringify({
            'UserName': document.getElementById('txtUserName').value || "",
            'Password': document.getElementById('txtUserPass').value || "",
            'WebServiceClientID':'40000000-0000-0000-0000-000000000018',
            'WebServiceClientPassword':'plmon1234@'
        }));
        window.localStorage.setItem('Yunique.API', JSON.stringify({
            'REST': '<%= strRESTAPI %>' || "",
            'Toolkit': '<%= strToolkitAPI %>' || ""
        }));
        window.localStorage.setItem('Yunique.Data', JSON.stringify({
            'AppRoot': '<%= ResolveUrl("~/") %>' || "",
        }));
    }
    catch(err) {
        window.sessionStorage.setItem('Yunique.User', JSON.stringify({
            'UserName': document.getElementById('txtUserName').value || "",
            'Password': document.getElementById('txtUserPass').value || "",
            'WebServiceClientID':'40000000-0000-0000-0000-000000000018',
            'WebServiceClientPassword':'plmon1234@'
        }));
        window.sessionStorage.setItem('Yunique.API', JSON.stringify({
            'REST': '<%= strRESTAPI %>' || "",
            'Toolkit': '<%= strToolkitAPI %>' || ""
        }));
        window.sessionStorage.setItem('Yunique.Data', JSON.stringify({
            'AppRoot': '<%= ResolveUrl("~/") %>' || ""
        }));
    }
};
if (supportsStorage()) {
    window.localStorage.removeItem('Yunique.User');
    window.localStorage.removeItem('Yunique.API');
    window.localStorage.removeItem('Yunique.Data');
    document.getElementById('cmdLogin').onclick = writeYuniqueData;
}else{
    window.sessionStorage.removeItem('Yunique.User');
    window.sessionStorage.removeItem('Yunique.API');
    window.sessionStorage.removeItem('Yunique.Data');
    document.getElementById('cmdLogin').onclick = writeYuniqueData;
}
    </script>

</HTML>
