<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Wizard.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Wizard" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src='../System/Jscript/YSCalendarFunctions.js'></script>
	</HEAD>
	<body onload="self.focus()">
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="1" borderColor="gainsboro">
				<TR>
					<TD vAlign="top" width="150" id="TD_Nav" runat="server" bgColor="#ffffff">
						<asp:PlaceHolder id="pnlNav" runat="server"></asp:PlaceHolder>
					</TD>
					<TD vAlign="top" bgColor="#ffffff">
						<asp:PlaceHolder id="pnlPage" runat="server"></asp:PlaceHolder></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
