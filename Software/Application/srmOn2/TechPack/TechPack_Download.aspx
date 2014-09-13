<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Download.aspx.vb" Inherits="srmOnApp.TechPack_Download" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Download</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Tech Pack Download</asp:label></td>
				</tr>
			</table>
			<TABLE id="Table1" borderColor="gainsboro" cellSpacing="0" cellPadding="0" width="300"
				bgColor="#ffffff" border="1">
				<TR>
					<TD class="tableHeader" align="center" width="25" colSpan="1"></TD>
					<TD class="tableHeader"><asp:label id="lblFileName" runat="server">File Name</asp:label></TD>
					<TD class="tableHeader" align="center" width="50"><asp:label id="lblExt" runat="server">Ext</asp:label></TD>
				</TR>
				<TR>
					<TD class="font" align="center" width="25"><IMG src="../System/Icons/ext_pdf.gif"></TD>
					<TD class="font">
						<asp:Label id="lblFilePdf" runat="server"></asp:Label></TD>
					<TD class="font" align="center" width="50">PDF</TD>
				</TR>
				<TR>
					<TD class="font" align="center" width="25">&nbsp;</TD>
					<TD class="font">
						&nbsp;</TD>
					<TD class="font" align="center" width="50">&nbsp;</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
