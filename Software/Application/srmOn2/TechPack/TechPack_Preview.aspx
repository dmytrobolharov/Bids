<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Preview.aspx.vb" Inherits="srmOnApp.TechPack_Preview" %>
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
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0">Tech Pack</asp:label></td>
				</tr>
			</table>
			<TABLE height="600" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="middle" align="center" bgColor="#ffffff">
						<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="300" border="0">
							<TR>
								<TD width="50">
									<asp:Image id="imgWarn" runat="server" ImageUrl="../System/Icons/icon_critical32.gif" CssClass="fontHead"></asp:Image></TD>
								<TD>
									<asp:Label id="lblWarn" runat="server" CssClass="fontHead"></asp:Label></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
