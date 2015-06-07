<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Workflow_Wizard.aspx.vb" Inherits="plmOnApp.Style_Workflow_Wizard" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Style_Main</title>
		
		
		
		
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td width="100%">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td>&nbsp;</td>
&nbsp;</td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" bgColor="#ffffff">
						<asp:panel id="Panel2" runat="server">
							<table id="Table1" height="400" cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td width="50" bgColor="#cccccc">&nbsp;</td>
									<td valign="top">
										<table id="Table2" cellSpacing="0" cellpadding="0" width="100%" border="0">
											<tr>
												<td width="10">&nbsp;</td>
												<td>
													<asp:label id="Label1" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Select Workflow to...</asp:label></td>
											</tr>
										</table>
										<table id="Table3" cellSpacing="0" cellpadding="0" width="100%" border="0">
											<tr>
												<td width="25">&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td width="25">&nbsp;</td>
												<td class="fontHead"><asp:label id="lblPleaseSelectAStyleWorkflow" runat="server" CssClass="fontHead">Please select a style workflow...</asp:label>
												</td>
											</tr>
											<tr>
												<td width="25" height="50">&nbsp;</td>
												<td height="50">
													<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
															<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"><BR>
																<asp:DropDownList id="ddlWorkflow" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:DropDownList></BLOCKQUOTE>
														</BLOCKQUOTE></BLOCKQUOTE>
												</td>
											</tr>
											<tr>
												<td width="25">&nbsp;</td>
												<td>
													<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"> <BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
															<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px"><BR>
																<cc1:confirmedimagebutton id="btnCancel2" runat="server"  Message="Are you sure you want to cancel it?"></cc1:confirmedimagebutton>
																<asp:ImageButton id="btnNext2" runat="server" ></asp:ImageButton></BLOCKQUOTE>
														</BLOCKQUOTE></BLOCKQUOTE>
												</td>
											</tr>
										</table>
										<table height="100" cellSpacing="0" cellpadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
											border="0">
											<tr valign="top">
												<td></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</asp:panel></td>
					<td valign="top" align="center" width="200" bgColor="#f5f5f5">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
