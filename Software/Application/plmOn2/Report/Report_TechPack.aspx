<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Report_TechPack.aspx.vb" Inherits="plmOnApp.Report_TechPack" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Teck Pack</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				height="27">
				<TR>
					<TD vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<asp:Label id="lblHeader" runat="server"></asp:Label></TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" vAlign="top"><table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" runat="server" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<iframe src="<%=SqlReportUrl%>" height="85%" width="100%" scrolling="no" frameborder=no>
			</iframe>
		</form>
	</body>
</HTML>
