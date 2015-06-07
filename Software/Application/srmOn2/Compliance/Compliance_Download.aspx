<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Compliance_Download.aspx.vb" Inherits="srmOnApp.Compliance_Download" %>
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
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Resource Download</asp:label></td>
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
					<TD class="font" align="center" width="25"><asp:Image id="imgFileIcon" runat="server"></asp:Image></TD>
					<TD class="font">
                        <asp:LinkButton ID="lbnFilePdf" runat="server"></asp:LinkButton>
                    </TD>
					<TD class="font" align="center" width="50"><asp:Label Runat="server" ID="lblFileExt"></asp:Label></TD>
				</TR>
				<TR>
					<TD class="font" align="center" width="25"><IMG src="../System/Icons/ext_zip.gif"></TD>
					<TD class="font">
                        <asp:LinkButton ID="lbnFileZip" runat="server"></asp:LinkButton>
                    </TD>
					<TD class="font" align="center" width="50">ZIP</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
