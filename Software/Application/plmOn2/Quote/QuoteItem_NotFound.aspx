<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QuoteItem_NotFound.aspx.vb" Inherits="plmOnApp.QuoteItem_NotFound" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Quote Not Found</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" height="600" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="middle" align="center" bgColor="#ffffff">
						<TABLE id="Table2" cellSpacing="0" cellPadding="0" width="300" border="0">
							<TR>
								<TD width="50">
									<asp:Image id="imgWarn" runat="server" ImageUrl="../System/Icons/icon_warning_32.gif"></asp:Image></TD>
								<TD>
									<asp:Label id="lblWarn" runat="server" CssClass="fontHead">Quote Not Found!</asp:Label></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
