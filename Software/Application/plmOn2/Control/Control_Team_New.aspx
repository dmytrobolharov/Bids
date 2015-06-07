<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Team_New.aspx.vb" Inherits="plmOnApp.Control_Team_New" %>
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
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
		    function calendar(sTxtBoxName) {
		        windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
		        windowDatePicker.focus();
		    }
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="90%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>
									<div align="right"><asp:label id="lblFullName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
											ForeColor="#E0E0E0"></asp:label>&nbsp;&nbsp;</div>
								</td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>&nbsp;<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview></td>
							</tr>
						</table>
						<asp:Panel id="Panel1" runat="server">
							<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD width="100%">
										<cc2:confirmedimagebutton id="btnSaveUser" runat="server" Message="NONE"></cc2:confirmedimagebutton></TD>
									<TD>&nbsp;</TD>
								</TR>
							</TABLE>
							<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD width="50%">
										<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblFirstName" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtFirstName" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblMiddleName" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtMiddleName" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblLastName" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtLastName" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10"></TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblJobTitle" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtJobTitle" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10"></TD>
												<TD class="fontHead" width="100"></TD>
												<TD></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblAddress" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtAddress1" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;</TD>
												<TD>&nbsp;
													<asp:textbox id="txtAddress2" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblCity" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtCity" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblState" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtState" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblZip" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtZip" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;</TD>
												<TD>&nbsp;</TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblPhone" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtPhone" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10"></TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblMobile" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtMobile" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10"></TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblEmail" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtEmail" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10"></TD>
												<TD class="fontHead" width="100"></TD>
												<TD></TD>
											</TR>
										</TABLE>
									</TD>
									<TD vAlign="top" width="50%">
										<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblUserName" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtUserName" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblPassword" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:textbox id="txtPassword" runat="server"></asp:textbox></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;</TD>
												<TD>&nbsp;</TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblActive" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:checkbox id="cbActive" runat="server"></asp:checkbox></TD>
											</TR>
											<TR>
												<TD width="10"></TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblAdministrator" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:checkbox id="cbAdministrator" runat="server"></asp:checkbox></TD>
											</TR>
											<TR>
												<TD width="10"></TD>
												<TD class="fontHead" width="100">&nbsp;<asp:Label ID="lblExternalAccess" runat="server"></asp:Label></TD>
												<TD>&nbsp;
													<asp:checkbox id="cbPublicAccess" runat="server"></asp:checkbox></TD>
											</TR>
											<TR>
												<TD width="10"></TD>
												<TD class="fontHead" width="100"></TD>
												<TD></TD>
											</TR>
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD class="fontHead" width="100">&nbsp;</TD>
												<TD>&nbsp;</TD>
											</TR>
										</TABLE>
										<asp:requiredfieldvalidator id="rvUserName" runat="server" ControlToValidate="txtUserName"
											CssClass="fonthead" Display="Dynamic"></asp:requiredfieldvalidator><BR>
										<asp:regularexpressionvalidator id="rvEmail" runat="server" ControlToValidate="txtEmail"
											CssClass="fonthead" Display="Dynamic" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:regularexpressionvalidator>
										<asp:regularexpressionvalidator id="RegularExpressionValidator1" runat="server" 
											ControlToValidate="txtPassword" CssClass="fonthead" Display="Dynamic" ValidationExpression="^([a-zA-Z0-9@*#]{8,15})$"></asp:regularexpressionvalidator></TD>
								</TR>
							</TABLE>
						</asp:Panel>
						<asp:Panel id="Panel2" runat="server">
							<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD width="100%">
										<cc2:confirmedimagebutton id="cmdSaveSecurity" runat="server"  Message="NONE"></cc2:confirmedimagebutton></TD>
									<TD>&nbsp;</TD>
								</TR>
							</TABLE>
							<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader">
									<TD width="10" height="20">&nbsp;</TD>
									<TD colSpan="2" height="20"><asp:Label ID="lblStyleDevelopment" runat="server"></asp:Label></TD>
								</TR>
								<TR>
									<TD width="10">&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblStyleHeader" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbStyleHeader" runat="server" CssClass="font" RepeatDirection="Horizontal">




										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD width="10"></TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblMaterial" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbStyleMaterial" runat="server" CssClass="font" RepeatDirection="Horizontal">




										</asp:RadioButtonList></TD>
								</TR>
								<TR bgColor="#f5f5f5">
									<TD width="10">&nbsp;</TD>
									<TD class="fontHead" width="125"><%=Me.GetSystemText(strColorway)%></TD>
									<TD>
										<asp:RadioButtonList id="rbStyleColorway" runat="server" CssClass="font" RepeatDirection="Horizontal">
			



										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD width="10">&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblArtwork" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbStyleArtwork" runat="server" CssClass="font" RepeatDirection="Horizontal">
											



										</asp:RadioButtonList></TD>
								</TR>
								<TR bgColor="#f5f5f5">
									<TD>&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblLicensee" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbStyleLicensee" runat="server" CssClass="font" RepeatDirection="Horizontal">
							



										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblDesignDetail" runat="server"></asp:Label>
									</TD>
									<TD>
										<asp:RadioButtonList id="rbStyleDesignDetail" runat="server" CssClass="font" RepeatDirection="Horizontal">
										



										</asp:RadioButtonList></TD>
								</TR>
								<TR bgColor="#f5f5f5">
									<TD>&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblDevelopmentSpec" runat="server"></asp:Label>
									</TD>
									<TD>
										<asp:RadioButtonList id="rbStyleDevelopmentSpec" runat="server" CssClass="font" RepeatDirection="Horizontal">
										



										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblGradedMeasurment" runat="server"></asp:Label>
									</TD>
									<TD>
										<asp:RadioButtonList id="rbStyleGradedMeasurment" runat="server" CssClass="font" RepeatDirection="Horizontal">
					



										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD colSpan="3" height="20">&nbsp;</TD>
								</TR>
							</TABLE>
							<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader">
									<TD width="10" height="20">&nbsp;</TD>
									<TD colSpan="2"><asp:Label ID="lblMaterialFolder" runat="server"></asp:Label>
									</TD>
								</TR>
								<TR>
									<TD width="10">&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblMaterialHeader" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbMaterialHeader" runat="server" CssClass="font" RepeatDirection="Horizontal">
								
										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD width="10">&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblMaterialDesign" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbMaterialDesign" runat="server" CssClass="font" RepeatDirection="Horizontal">
										
										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
									<TD class="fontHead"><asp:Label ID="lblMaterialColor" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbMaterialColor" runat="server" CssClass="font" RepeatDirection="Horizontal">
									
										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD>&nbsp;</TD>
									<TD class="fontHead"><asp:Label ID="lblMaterialLabDip" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbMaterialLabDip" runat="server" CssClass="font" RepeatDirection="Horizontal">
								
										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD style="HEIGHT: 17px" width="10">&nbsp;</TD>
									<TD class="fontHead" style="HEIGHT: 17px" width="125"><asp:Label ID="lblMaterialTesting" runat="server"></asp:Label></TD>
									<TD style="HEIGHT: 17px">
										<asp:RadioButtonList id="rbMaterialTesting" runat="server" CssClass="font" RepeatDirection="Horizontal">

										</asp:RadioButtonList></TD>
								</TR>
								<TR>
									<TD width="10">&nbsp;</TD>
									<TD class="fontHead" width="125"><asp:Label ID="lblMaterialSample" runat="server"></asp:Label></TD>
									<TD>
										<asp:RadioButtonList id="rbMaterialSample" runat="server" CssClass="font" RepeatDirection="Horizontal">

										</asp:RadioButtonList></TD>
								</TR>
							</TABLE>
						</asp:Panel>
					</td>
					<td valign="top" bgcolor="#ffffff">&nbsp;</td>
					<td width="200" bgcolor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>


