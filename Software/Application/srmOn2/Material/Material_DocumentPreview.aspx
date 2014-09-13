<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_DocumentPreview.aspx.vb" Inherits="srmOnApp.Material_DocumentPreview" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Download</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Attachment</asp:label></td>
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
					<TD class="font" align="center" width="25">
						<asp:ImageButton ID="imgFileIcon" runat="server"></asp:ImageButton></TD>
					<TD class="font"><asp:label id="lblFilePdf" runat="server"></asp:label></TD>									
					<TD class="font" align="center" width="50"><asp:label id="lblFileZip" Visible="false" runat="server"></asp:label><asp:label id="lblFileExt" runat="server"></asp:label></TD>
				
				</TR>
				<TR>
					<TD class="font" align="center" width="25">&nbsp;</TD>
					<TD class="font">&nbsp;</TD>
					<TD class="font" align="center" width="50">&nbsp;</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
