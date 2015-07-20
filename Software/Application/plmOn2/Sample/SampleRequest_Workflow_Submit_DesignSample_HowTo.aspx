<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_DesignSample_HowTo.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_DesignSample_HowTo" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>POM</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" bgColor="#ffffff">
				<TR>
					<TD width="15" height="25">&nbsp;</TD>
					<TD height="25">
						<asp:Label id="lblHeader" runat="server" CssClass="fontHead"></asp:Label></TD>
				</TR>
			</TABLE>
			<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" bgColor="#ffffff">
				<TR>
					<TD width="15">&nbsp;</TD>
					<TD width="140">
						<asp:Label id="lbPointMeasur" runat="server" CssClass="fontHead"></asp:Label></TD>
					<TD>
						<asp:Label id="lbPOMCode" runat="server" DESIGNTIMEDRAGDROP="89" CssClass="font"></asp:Label>
					</TD>	
				</TR>
				<TR>
					<TD width="15">&nbsp;</TD>
					<TD width="140">
						<asp:Label id="lbPOMHdrDescription" runat="server" CssClass="fontHead"></asp:Label></TD>
					<TD>
						<asp:Label id="lbPOMDescription" runat="server" CssClass="font"></asp:Label></TD>
				</TR>
				<TR>
					<TD width="15">&nbsp;</TD>
					<TD vAlign="top" width="140">
						<asp:Label id="lbHowToMeasur" runat="server" CssClass="fontHead"></asp:Label></TD>
					<TD>
						<asp:Label id="lbPOMHowtoMeasurText" runat="server" CssClass="font"></asp:Label></TD>
				</TR>
				<TR>
					<TD width="15">&nbsp;</TD>
					<TD width="140">
						<asp:Label id="lbHowToImage" runat="server" CssClass="fontHead"></asp:Label></TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD width="15">&nbsp;</TD>
					<TD colSpan="3">
					</TD>
				</TR>
			</TABLE>
			<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD>
						<asp:Image id="imgHowToImage" runat="server"></asp:Image></TD>
				</TR>
			</TABLE>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
