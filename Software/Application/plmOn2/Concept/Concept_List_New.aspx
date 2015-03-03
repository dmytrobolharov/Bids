<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Concept_List_New.aspx.vb" Inherits="plmOnApp.Concept_List_New" %>
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
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSaveMaterial" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
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
						<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
							height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td>&nbsp;<asp:label id="lblColorHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">New Concept Folder...</asp:label></td>
							</tr>
						</table>
						<br>
						<asp:panel id="pnlMaterial" runat="server">
							<TABLE height="100" cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR vAlign="top">
									<TD width="10">&nbsp;</TD>
									<TD>
										<BLOCKQUOTE dir="ltr" style="MARGIN-RIGHT: 0px">
											<P>
												<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></P>
										</BLOCKQUOTE>
									</TD>
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
