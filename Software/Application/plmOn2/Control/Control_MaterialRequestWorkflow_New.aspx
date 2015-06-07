<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_MaterialRequestWorkflow_New.aspx.vb" Inherits="plmOnApp.Control_MaterialRequestWorkflow_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Style_Main</title>
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
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSaveMaterial" runat="server" Message="NONE"
							></cc1:confirmedimagebutton></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"
							 CausesValidation="False"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" bgcolor="#ffffff">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><div align="right">
										<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large"
											ForeColor="#E0E0E0"></asp:Label></div>
								</td>
							</tr>
						</table>
						<asp:Panel ID="pnlMaterial" runat="server">
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<TD width="10">&nbsp;</TD>
									<TD>
										<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
								</TR>
							</TABLE>
						</asp:Panel>
						<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0" background="../System/Images/MiddleFill.jpg">
							<tr valign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<td width="10%" bgcolor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>
			
        <asp:HiddenField ID="hdnXmlFiles" runat="server" />
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
