<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Where.aspx.vb" Inherits="plmOnApp.Material_Where" %>
<%@ Register TagPrefix="uc2" TagName="Material_Style_Component_Where" Src="Material_Style_Component_Where.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Material Where</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Message="NONE"
							Visible="False"></cc1:confirmedimagebutton></TD>
					<td width="80"></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material Where Used</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top">
						<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td>
									<uc1:Material_Header id="Material_Header1" runat="server"></uc1:Material_Header></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<asp:datagrid id="dgStyletype" runat="server" Width="100%" BorderColor="Silver" AutoGenerateColumns="false"
				ShowHeader="False">
				<Columns>
					<asp:TemplateColumn>
						<ItemTemplate>
							<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TR class="TableHeader">
									<TD width="10" bgColor="white" height="24"></TD>
									<TD class="fontHead" bgColor="white"><%#GetSystemText("Version No.")%>
										<%# DataBinder.Eval(Container.DataItem, "MChange") %>
									</TD>
								</TR>
							</TABLE>
							<uc2:Material_Style_Component_Where id="Material_Style_Component_Where1" runat="server" MV='<%# DataBinder.Eval(Container.DataItem, "MChange") %>' MTID='<%# DataBinder.Eval(Container.DataItem, "MaterialID") %>'/>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
	</body>
</HTML>
