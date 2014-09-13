<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Care.aspx.vb" Inherits="srmOnApp.Style_Care" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Style</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<uc1:Style_Workflow id="Style_Workflow1" runat="server"></uc1:Style_Workflow>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			
			
			<table borderColor="whitesmoke" cellSpacing="0" cellPadding="0" width="100%" border="1">
				<tr>
					<td vAlign="top" width="100%" bgColor="#ffffff">
						<TABLE class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3" ></TD>
								<TD><asp:label id="lblCareInstructions" runat="server">Care Instructions</asp:label></TD>
								<TD>&nbsp;</TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr>
							<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
						</tr>
						</TABLE>
					</td>
				</tr>
			</table>			

			
			<TABLE class="TableHeader" borderColor="gainsboro" cellSpacing="0" cellPadding="0" width="100%"
				border="0">
				<TR>
					<TD vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:label id="lblCareLabels" runat="server">Care Labels</asp:label></TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
			<TABLE borderColor="#ffffff" cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff"
				border="2">
				<TR>
					<TD vAlign="top" width="1" id="tdWash" runat="server">
						<TABLE borderColor="whitesmoke" height="130" cellSpacing="0" cellPadding="0" width="130"
							border="1">
							<TR>
								<TD class="tableheader" align="center">
									<asp:Label id="lbiWash" runat="server">Washing</asp:Label></TD>
							</TR>
							<TR>
								<TD align="center" height="130"><asp:image id="imgWash" runat="server"></asp:image></TD>
							</TR>
							<TR>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top" noWrap width="1" id="tdCycle" runat="server">
						<TABLE borderColor="whitesmoke" height="130" cellSpacing="0" cellPadding="0" width="130"
							border="1">
							<TR>
								<TD class="tableheader" align="center">
									<asp:Label id="lbiCycle" runat="server">Cycle</asp:Label></TD>
							</TR>
							<TR>
								<TD align="center" height="130"><asp:image id="imgCycle" runat="server"></asp:image></TD>
							</TR>
							<TR>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top" noWrap width="1" id="tdBleach" runat="server">
						<TABLE borderColor="whitesmoke" height="130" cellSpacing="0" cellPadding="0" width="130"
							border="1">
							<TR>
								<TD class="tableheader" align="center">
									<asp:Label id="lbiBleach" runat="server">Bleaching</asp:Label></TD>
							</TR>
							<TR>
								<TD align="center" height="130"><asp:image id="imgBleach" runat="server"></asp:image></TD>
							</TR>
							<TR>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top" noWrap width="1" id="tdDry" runat="server">
						<TABLE borderColor="whitesmoke" height="130" cellSpacing="0" cellPadding="0" width="130"
							border="1">
							<TR>
								<TD class="tableheader" align="center">
									<asp:Label id="lbiDry" runat="server">Drying</asp:Label></TD>
							</TR>
							<TR>
								<TD align="center" height="130"><asp:image id="imgDry" runat="server"></asp:image></TD>
							</TR>
							<TR>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top" noWrap width="1" id="tdIron" runat="server">
						<TABLE borderColor="whitesmoke" height="130" cellSpacing="0" cellPadding="0" width="130"
							border="1">
							<TR>
								<TD class="tableheader" align="center">
									<asp:Label id="lbiIron" runat="server">Ironing</asp:Label></TD>
							</TR>
							<TR>
								<TD align="center" height="130"><asp:image id="imgIron" runat="server"></asp:image></TD>
							</TR>
							<TR>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top" noWrap width="1" id="tdDryClean" runat="server">
						<TABLE borderColor="whitesmoke" height="130" cellSpacing="0" cellPadding="0" width="130"
							border="1">
							<TR>
								<TD class="tableheader" align="center" style="HEIGHT: 19px">
									<asp:Label id="lbiDryClean" runat="server">Dry Clean</asp:Label></TD>
							</TR>
							<TR>
								<TD align="center" height="130"><asp:image id="imgDryClean" runat="server"></asp:image></TD>
							</TR>
							<TR>
								<TD></TD>
							</TR>
						</TABLE>
					</TD>
					<TD vAlign="top"></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
