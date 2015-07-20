<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanTemplate.aspx.vb" Inherits="plmOnApp.LinePlanTemplate" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Line Attribute</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>		
	</HEAD>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server">
			<TABLE cellSpacing="0" cellPadding="0" width="100%" height="100%" border="1" borderColor="gainsboro">
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
