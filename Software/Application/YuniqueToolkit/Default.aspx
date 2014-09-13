<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="YuniFace._Default" %>
<link REL='SHORTCUT ICON' href='favicon.ico'>
<HTML>
	<HEAD>
		<title>YuniquePLM Toolkit</title>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="./System/CSS/Style.css" type="text/css" rel="stylesheet" runat="server" id="styleCss" />

		<script language="JavaScript">
		<!--

		    function detectPopupBlocker() {
		        var myTest = window.open("about:blank", "", "directories=no,height=100,width=100,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,top=0,location=no");
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
                        width: 150px; 
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
 <!-- meta http-equiv="refresh" content="0; url=/yuniquetoolkit/clientsetup/publish.htm" -->
 
	</HEAD>
	
	<body bgColor="gainsboro">
		<form id="Form1" method="post" runat="server">

			<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tbody>
                    <tr align="center">
                        <td> <p style="color: #ffffff; background-color: #86BD1A">Toolkit v1.0 has been deprecated.&nbsp; <br />Please install <a href="./clientsetup/publish.htm"><strong>Toolkit v2.0</strong></a></p></td>
                    </tr>
					<tr>
						<td align="center">

							<table cellspacing="0" cellpadding="0" width="860" border="0" id="Table2">
								<tbody class="LoginPage">
									<tr>
										<td>

							                <table cellspacing="0" cellpadding="0" width="860" border="0" id="Table1">
								                <tbody>
                                                    <tr>
                                                        <td style="width:450px;">
											                <table cellSpacing="0" cellPadding="0" border="0" 
                                                                style="width: 110%">
                                                                <tbody>
                                                                    <tr>
													                    <td width="20">&nbsp;</td>
													                    <td width="60" valign="top" style="width: 60px; height: 80px">
                                                                            <asp:Label ID="lblVersion" runat="server"></asp:Label>
                                                                        </td>
													                    <td width="370">&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
																		<td align="center" style="height: 200px" colspan="3">
                                                                            <img alt="" src="System/Images/NewLogo.png"  style="width: 200px;"/>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                        <td noWrap width="325">
											                <table height="1" cellSpacing="0" cellPadding="0" border="0" 
                                                                style="width: 107%">
                                                                <tbody>
                                                                    <tr>
														                <td align="center" height="80">
                                                                            <div align="right">
                                                                                <br />
                                                                                <img src="System/Images/yunique_logo.png" width="300" id="img1" runat="server">
                                                                                <br />&lt;toolkit /&gt;
                                                                            </div>
														                </td>
                                                                    </tr>
																	<tr>
																		<td>&nbsp;<br /><br /></td>
																	</tr>
																	<tr>
																		<td align="center" valign="middle">
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
																		</td>
																	</tr>
																	<tr>
																		<td class="fontHead"><FONT color="#ff0000" size="2">&nbsp;
																				<asp:label id="lblMsg" runat="server" ForeColor="red" Font-Name="Verdana" Font-Size="XX-Small"
																					CssClass="fontHead"></asp:label></FONT>
                                                                        </td>
																	</tr>
																	<tr>
																		<td>&nbsp;</td>
																	</tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>







                                                    <tr>
                                                        <td valign="bottom" align="right" style="width:400px;">
											                <TABLE cellSpacing="0" cellPadding="0" border="0">
												                <TBODY>
													                <TR>
														                <TD align="center" valign="top" style="width: 321px">
															                <asp:label CssClass="fontHead"  id="lblLicense" runat="server">Yunique Solutions | Gerber Technology</asp:label>
														                </TD>
													                </TR>
												                </TBODY>
											                </TABLE>
                                                        </td>
										                <td runat="server" id="td1" noWrap align="center" valign="bottom" width="325">
											                <A class="font" onClick="window.open('Password.aspx','_Password','width=400,height=150,resizable=no,scrollbars=no,toolbar=no,status=yes'); return false;"
												                href=""><FONT class="fontHead" color="#000000"><asp:Label ID="lblForgot" runat="server" Text="Forgot Your Password?"></asp:Label></FONT></A>
                                                        </td>
                                                    </tr>

									                <tr>
										                <td align="center" colspan="2">
                                                            <br />&nbsp;<br />
                                                            <br />&nbsp;<br />
                                                            <asp:label id="lblCopyright" runat="server" ForeColor="#333333" class="fontHead">&copy; 2012 Gerber Scientific Inc. All rights reserved.</asp:label>
                                                        </td>
									                </tr>

                                                </tbody>
							                </table>

										</td>
									</tr>
								</tbody>
							</table>

						</td>
					</tr>
				</tbody>
			</table>

		</form>
	</body>
</HTML>
