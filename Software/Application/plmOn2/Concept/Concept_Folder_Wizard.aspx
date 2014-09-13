<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Concept_Folder_Wizard.aspx.vb" Inherits="plmOnApp.Concept_Folder_Wizard" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
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
					<td width="100%">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff">
						<table height="400" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="50" bgColor="#cccccc">&nbsp;</td>
								<td vAlign="top"><asp:panel id="Panel1" runat="server">
										<table cellSpacing="0" cellPadding="0" width="100%" border="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td><asp:label id="lbHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Move Concept to...</asp:label></td>
											</tr>
										</table>
										<table cellSpacing="0" cellPadding="0" width="100%" border="0">
											<tr>
												<td width="25">&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<TR>
												<TD width="25"></TD>
												<TD class="fontHead">This wizard will help to move and configure this concept.</TD>
											</TR>
											<tr>
												<td width="25">&nbsp;</td>
												<td class="fontHead">Please select a folder you want to move&nbsp;from and click 
													next...
												</td>
											</tr>
											<tr>
												<td width="25" height="50">&nbsp;</td>
												<td height="50">
													<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
															<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"><br>
																<asp:dropdownlist id="ddlConceptStatus" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:dropdownlist></BLOCKQUOTE>
														</BLOCKQUOTE></BLOCKQUOTE>
												</td>
											</tr>
											<tr>
												<td width="25">&nbsp;</td>
												<td>
													<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
															<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"><br>
																<cc1:confirmedimagebutton id="btnCancel1" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
																<asp:imagebutton id="btnNext1" runat="server" ></asp:imagebutton></BLOCKQUOTE>
														</BLOCKQUOTE></BLOCKQUOTE>
												</td>
											</tr>
										</table>
										<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
											border="0">
											<TR vAlign="top">
												<TD></TD>
											</TR>
										</TABLE></td>
							</tr>
						</table>
						</asp:panel><asp:panel id="Panel2" runat="server">
							<TABLE id="Table1" height="400" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD width="50" bgColor="#cccccc">&nbsp;</TD>
									<TD vAlign="top">
										<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD>
													<asp:label id="Label1" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Select Workflow to...</asp:label></TD>
											</TR>
										</TABLE>
										<TABLE id="Table3" cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR>
												<TD width="25">&nbsp;</TD>
												<TD>&nbsp;</TD>
											</TR>
											<TR>
												<TD width="25"></TD>
												<TD class="fontHead">This wizard will help to move and configure this concept.</TD>
											</TR>
											<TR>
												<TD width="25">&nbsp;</TD>
												<TD class="fontHead">Please select a style workflow...
												</TD>
											</TR>
											<TR>
												<TD width="25" height="50">&nbsp;</TD>
												<TD height="50">
													<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
															<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"><BR>
																<asp:DropDownList id="ddlWorkflow" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:DropDownList></BLOCKQUOTE>
														</BLOCKQUOTE></BLOCKQUOTE>
												</TD>
											</TR>
											<TR>
												<TD width="25">&nbsp;</TD>
												<TD>
													<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
															<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"><BR>
																<cc1:confirmedimagebutton id="btnCancel2" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
																<asp:ImageButton id="btnNext2" runat="server" ></asp:ImageButton></BLOCKQUOTE>
														</BLOCKQUOTE></BLOCKQUOTE>
												</TD>
											</TR>
										</TABLE>
										<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
											border="0">
											<TR vAlign="top">
												<TD></TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
							</TABLE>
						</asp:panel><asp:panel id="Panel3" runat="server">
							<TABLE height="400" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD width="50" bgColor="#cccccc">&nbsp;</TD>
									<TD vAlign="top">
										<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD>
													<asp:label id="Label3" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Select Image...</asp:label></TD>
											</TR>
										</TABLE>
										<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR>
												<TD width="25">&nbsp;</TD>
												<TD>&nbsp;</TD>
											</TR>
											<TR>
												<TD width="25"></TD>
												<TD class="fontHead">This wizard will help to move and configure this concept.</TD>
											</TR>
											<TR>
												<TD style="HEIGHT: 16px" width="25">&nbsp;</TD>
												<TD class="fontHead" style="HEIGHT: 16px">Please select image method...
												</TD>
											</TR>
											<TR>
												<TD width="25" height="50">&nbsp;</TD>
												<TD height="50">
													<TABLE id="Table4" cellSpacing="1" cellPadding="1" width="250" border="0">
														<TR>
															<TD></TD>
															<TD></TD>
															<TD></TD>
														</TR>
														<TR>
															<TD>
																<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image></TD>
															<TD></TD>
															<TD width="150">
																<asp:RadioButton id="rbLinkImage" runat="server" GroupName="rbImage" Text="Link Concept Image" CssClass="fonthead"
																	Checked="True"></asp:RadioButton>
																<asp:RadioButton id="rbCopyImage" runat="server" GroupName="rbImage" Text="Copy Concept Image" CssClass="fonthead"></asp:RadioButton>
																<asp:RadioButton id="rbNewImage" runat="server" GroupName="rbImage" Text="New Concept Image" CssClass="fonthead"></asp:RadioButton></TD>
														</TR>
														<TR>
															<TD></TD>
															<TD></TD>
															<TD></TD>
														</TR>
													</TABLE>
												</TD>
											</TR>
											<TR>
												<TD width="25">&nbsp;</TD>
												<TD>
													<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
															<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"><BR>
																<cc1:confirmedimagebutton id="btnCancel3" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
																<asp:ImageButton id="btnNext3" runat="server" ></asp:ImageButton></BLOCKQUOTE>
														</BLOCKQUOTE></BLOCKQUOTE>
												</TD>
											</TR>
										</TABLE>
										<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
											border="0">
											<TR vAlign="top">
												<TD></TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
							</TABLE>
						</asp:panel><asp:panel id="Panel4" runat="server">
							<TABLE height="400" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR>
									<TD width="50" bgColor="#cccccc">&nbsp;</TD>
									<TD vAlign="top">
										<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR>
												<TD width="10">&nbsp;</TD>
												<TD>
													<asp:label id="Label2" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Fill Style Form...</asp:label></TD>
											</TR>
										</TABLE>
										<TABLE id="Table3" cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR>
												<TD width="25">&nbsp;</TD>
												<TD>&nbsp;</TD>
											</TR>
											<TR>
												<TD width="25"></TD>
												<TD class="fontHead">This wizard will help to move and configure this concept.</TD>
											</TR>
											<TR>
												<TD width="25">&nbsp;</TD>
												<TD class="fontHead">Please select a style workflow...
												</TD>
											</TR>
											<TR>
												<TD width="25" height="50">&nbsp;</TD>
												<TD height="50">
													<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
											</TR>
											<TR>
												<TD width="25">&nbsp;</TD>
												<TD>
													<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
															<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"><BR>
																<cc1:confirmedimagebutton id="btnCancel4" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
																<cc1:confirmedimagebutton id="btnSaveStyle" runat="server"  Message="NONE"></cc1:confirmedimagebutton></BLOCKQUOTE>
														</BLOCKQUOTE></BLOCKQUOTE>
												</TD>
											</TR>
										</TABLE>
										<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
											border="0">
											<TR vAlign="top">
												<TD></TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
							</TABLE>
						</asp:panel></td>
					<td vAlign="top" align="center" width="200" bgColor="#f5f5f5"><asp:panel id="PanelDev" runat="server" HorizontalAlign="Left">&nbsp; 
<asp:Label id="lblWizard" runat="server"></asp:Label>
						</asp:panel>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
