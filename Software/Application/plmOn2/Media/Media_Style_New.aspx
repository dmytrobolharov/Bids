<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Media_Style_New.aspx.vb" Inherits="plmOnApp.Media_Style_New" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Style_Main</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript">
				function calendar(sTxtBoxName)
				{
				windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
				windowDatePicker.focus();
				}
				function customwindow(strWindowUrl)
				{
				windowCustom = window.open("../System/Control/" + strWindowUrl + "","Custom","toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=50,top=50");
				windowCustom.focus();
				}
		</script>	
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSaveMaterial" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">New Media</asp:label></td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" bgColor="#ffffff">
				<tr>
					<td valign="top">
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
					</td>
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
