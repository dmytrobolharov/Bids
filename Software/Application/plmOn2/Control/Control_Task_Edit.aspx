<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_Task_Edit.aspx.vb" Inherits="plmOnApp.Control_Task_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Control</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"
							CausesValidation="False"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
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
									<div align="right"><asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana"></asp:label></div>
								</td>
							</tr>
						</table>
						<asp:panel id="pnlMaterial" runat="server">
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<TD width="10">&nbsp;</TD>
									<TD>
										<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></TD>
								</TR>
							</TABLE>
						</asp:panel>
						<table height="100" cellSpacing="0" cellPadding="0" width="100%" background="../System/Images/MiddleFill.jpg"
							border="0">
							<tr vAlign="top">
								<td width="33%"></td>
								<td width="33%"></td>
								<td width="33%"></td>
							</tr>
						</table>
					</td>
					<td width="10%" bgColor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
