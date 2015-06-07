<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="SampleRequest_StyleWorkflow_Wizard_StyleWorkflow" Src="SampleRequest_StyleWorkflow_Wizard_StyleWorkflow.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_StyleWorkflow_Wizard.aspx.vb" Inherits="plmOnApp.SampleRequest_StyleWorkflow_Wizard" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="top" width="150">
						<asp:PlaceHolder id="pnlNav" runat="server"></asp:PlaceHolder>
					</TD>
					<TD vAlign="top">
						<asp:PlaceHolder id="pnlPage" runat="server"></asp:PlaceHolder></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
