<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Trade_New.aspx.vb" Inherits="plmOnApp.Control_Trade_New" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Style_Main</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td width="100%">&nbsp;
						<cc2:confirmedimagebutton id="btnSaveUser" runat="server" Message="NONE" ></cc2:confirmedimagebutton></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td vAlign="top" align="right" colSpan="2" height="75"><asp:label id="lblFullName" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"></asp:label>&nbsp;</td>
								<td vAlign="top" bgColor="whitesmoke" height="75">&nbsp;</td>
							</tr>
							<tr>
								<td vAlign="top" width="300">
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblCompanyName" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:textbox id="txtCompanyName" runat="server"></asp:textbox></td>
										</tr>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblAddress" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:textbox id="txtAddress1" runat="server"></asp:textbox></td>
										</tr>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;</td>
											<td>&nbsp;
												<asp:textbox id="txtAddress2" runat="server"></asp:textbox></td>
										</tr>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblCity" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:textbox id="txtCity" runat="server"></asp:textbox></td>
										</tr>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblState" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:textbox id="txtState" runat="server"></asp:textbox></td>
										</tr>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblZip" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:textbox id="txtZip" runat="server"></asp:textbox></td>
										</tr>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblCountry" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:TextBox id="txtCountry" runat="server"></asp:TextBox></td>
										</tr>
										<TR>
											<TD width="10"></TD>
											<TD class="fontHead" width="100"></TD>
											<TD></TD>
										</TR>
										<TR>
											<TD width="10"></TD>
											<TD class="fontHead" width="100">
                                                    <asp:Label ID="lblPhone" runat="server"></asp:Label></TD>
											<TD>&nbsp;
												<asp:textbox id="txtPhone" runat="server"></asp:textbox></TD>
										</TR>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblFax" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:TextBox id="txtFax" runat="server"></asp:TextBox></td>
										</tr>
										<TR>
											<TD width="10"></TD>
											<TD class="fontHead" width="100"></TD>
											<TD></TD>
										</TR>
									</table>
								</td>
								<TD vAlign="top" width="300">
									<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
										<TR>
											<TD width="10">&nbsp;</TD>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblUserName" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:textbox id="txtUserName" runat="server"></asp:textbox></td>
										</TR>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblPassword" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:textbox id="txtPassword" runat="server"></asp:textbox></td>
										</tr>
										<TR>
											<TD width="10"></TD>
											<TD class="fontHead" width="100"></TD>
											<TD></TD>
										</TR>
										<TR>
											<TD width="10"></TD>
											<TD class="fontHead" width="100"><asp:Label ID="lblTradeType" runat="server"></asp:Label></TD>
											<TD>&nbsp;
												<asp:DropDownList id="dlTradeType" runat="server">
													
												</asp:DropDownList></TD>
										</TR>
										<tr>
											<td>&nbsp;</td>
											<td class="fontHead">&nbsp;<asp:Label ID="lblActive" runat="server"></asp:Label></td>
											<td>&nbsp;
												<asp:checkbox id="cbActive" runat="server"></asp:checkbox></td>
										</tr>
										<tr>
											<td width="10">&nbsp;</td>
											<td class="fontHead" width="100">&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
									</TABLE>
									<table cellSpacing="0" cellPadding="0" width="100%" border="0">
										<tr class="fontHead">
											<td width="20" height="20">&nbsp;</td>
											<td height="20"><asp:Label ID="lblContactName" runat="server"></asp:Label>
											</td>
											<td height="20"><asp:Label ID="lblContactTitle" runat="server"></asp:Label>
											</td>
											<td height="20"><asp:Label ID="lblContactEmail" runat="server"></asp:Label>
											</td>
											<td height="20">&nbsp;</td>
										</tr>
										<tr>
											<td width="20">&nbsp;</td>
											<td><asp:textbox id="txtContactName1" runat="server"></asp:textbox></td>
											<td><asp:textbox id="txtContactTitle1" runat="server"></asp:textbox></td>
											<td><asp:textbox id="txtContactEmail1" runat="server"></asp:textbox></td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td width="20">&nbsp;</td>
											<td><asp:textbox id="txtContactName2" runat="server"></asp:textbox></td>
											<td><asp:textbox id="txtContactTitle2" runat="server"></asp:textbox></td>
											<td><asp:textbox id="txtContactEmail2" runat="server"></asp:textbox></td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td width="20">&nbsp;</td>
											<td><asp:textbox id="txtContactName3" runat="server"></asp:textbox></td>
											<td><asp:textbox id="txtContactTitle3" runat="server"></asp:textbox></td>
											<td><asp:textbox id="txtContactEmail3" runat="server"></asp:textbox></td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td width="20">&nbsp;</td>
											<td><asp:textbox id="txtContactName4" runat="server"></asp:textbox></td>
											<td><asp:textbox id="txtContactTitle4" runat="server"></asp:textbox></td>
											<td><asp:textbox id="txtContactEmail4" runat="server"></asp:textbox></td>
											<td>&nbsp;</td>
										</tr>
									</table>
									<br>
								</TD>
								<td vAlign="top" width="30%" bgColor="whitesmoke">&nbsp;</td>
							</tr>
							<tr>
								<td vAlign="top">&nbsp;</td>
								<td vAlign="top">&nbsp;</td>
								<td vAlign="top" bgColor="whitesmoke">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
