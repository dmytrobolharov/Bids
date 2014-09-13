<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DesktopHome.aspx.vb" Inherits="srmOnApp.DesktopHome" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_TechPackDownload" Src="../Style/Style_TechPackDownload.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">DesktopHome</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Calendar.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>
			<TABLE id="MainTable" borderColor="gainsboro" cellSpacing="0" cellPadding="0" width="100%"
				bgColor="#ffffff" border="1">
				<TR>
				    <TD vAlign="top" width="275" valign="top">
						<asp:placeholder id="ctlMaterial" runat="server"></asp:placeholder></TD>
					<TD vAlign="top" width="275" valign="top">
						<asp:placeholder id="ctlTechpack" runat="server"></asp:placeholder></TD>
					<TD vAlign="top" width="275" valign="top">
						<asp:placeholder id="ctlQuote" runat="server"></asp:placeholder></TD>
                    <TD width="275" valign="top" runat="server" ID="CommitmentCell">
						<asp:placeholder id="ctlCommitment" runat="server"></asp:placeholder></TD>
					<TD vAlign="top" width="275" valign="top">
						<asp:placeholder id="ctlSample" runat="server"></asp:placeholder></TD>
					<TD vAlign="top" width="300"  valign="top">
						<asp:placeholder id="ctlLate" runat="server"></asp:placeholder></TD>
					<td></td>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
