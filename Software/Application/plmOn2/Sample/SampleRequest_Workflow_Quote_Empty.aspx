<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Quote_Empty.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Quote_Empty" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="Expires" CONTENT="0">
		<meta http-equiv="Cache-Control" CONTENT="no-cache">
		<meta http-equiv="Pragma" CONTENT="no-cache">
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="JavaScript">
		<!--
		javascript:window.history.forward(1);
		//-->
		</script>
	</HEAD>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table width="100%" height="27" border="0" cellpadding="0" cellspacing="0" class="TableHeader">
				<tr>
					<td width="100%">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<table width="100%" height="90%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td valign="top" bgcolor="#ffffff">
						<TABLE id="Table1" borderColor="gold" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffff99"
							border="1">
							<TR>
								<TD>
									<TABLE id="Table2" height="35" cellSpacing="0" cellPadding="0" width="800" border="0">
										<TR>
											<TD width="10">&nbsp;</TD>
											<TD class="fontHead" width="35">&nbsp;
												<asp:Image id="imgBlock" runat="server" ImageUrl="../System/Icons/icon_block.gif"></asp:Image></TD>
											<TD class="fontHead">&nbsp;
												<asp:Label id="lblHeader" runat="server" ForeColor="Black" CssClass="fontHead"></asp:Label></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
					</td>
					<td width="200" bgcolor="#f5f5f5">&nbsp;</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
