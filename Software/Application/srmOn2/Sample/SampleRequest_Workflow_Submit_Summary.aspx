<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Summary.aspx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_Summary" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Sample Approval</title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
        <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
        <meta content="JavaScript" name="vs_defaultClientScript" />
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/mamagi.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" src='../System/Jscript/mamagi/jquery.mamagi.yunique.js'></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
		<script language="javascript">
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
		</script>
		<script type="text/javascript">              
			function disableEnterKey()
			{
			if (window.event.keyCode == 13) window.event.keyCode = 0;
			}
		</script>
	</HEAD>
	<body onload="self.focus()">
		<form id="Form1" method="post" runat="server" onKeyPress="disableEnterKey()">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:bwimagebutton id="btnGoToStyle" runat="server"></cc1:bwimagebutton></TD>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Summary</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900">
						<uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<td><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
				</tr>
			</table>
			<asp:DataGrid id="dgSampleSummary" runat="server" DataKeyField="SampleWorkflowID" AutoGenerateColumns="false"
				ShowHeader="false" ShowFooter="false" Width="100%">
				<ItemStyle CssClass="font" BackColor="White"></ItemStyle>
				<Columns>
					<asp:TemplateColumn>
						<ItemTemplate>
							<asp:PlaceHolder id="phSpec" runat="server"></asp:PlaceHolder>
							<asp:PlaceHolder id="phMaterial" runat="server"></asp:PlaceHolder>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:DataGrid>
		</form>
	</body>
</HTML>
