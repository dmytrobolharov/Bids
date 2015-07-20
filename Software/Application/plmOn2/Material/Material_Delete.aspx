<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Delete.aspx.vb" Inherits="plmOnApp.Material_Delete" %>
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
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:BWImageButton id="btnDelete" runat="server" CausesValidation="False" Message="NONE"></cc1:BWImageButton></TD>
					<td width="80"></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="crimson" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#C00000" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Delete Material</asp:label></td>
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
			<asp:datalist id="DataList1" runat="server" BorderColor="Silver" Width="100%" GridLines="Both"
				RepeatDirection="Horizontal" RepeatColumns="4" BackColor="White" BorderStyle="Solid" BorderWidth="1px"
				CssClass="font" DataKeyField="StyleID">
				<ItemStyle Height="100px" Width="200px"></ItemStyle>
				<ItemTemplate>
					<DIV align="center">
						<cc1:BWImageButton id="imgStyleFile" runat="server"  NavigateUrl='<%# string.Concat("../Style/Style_Frame.aspx?SID=" &amp; DataBinder.Eval(Container.DataItem,"StyleID").tostring) %>' ImageAlign='<%# ImageAlign.Middle%>' WindowName='<%# DataBinder.Eval(Container.DataItem,"StyleNo").tostring %>'/>
					</DIV>
					<BR>
					&nbsp;<%=GetSystemText("Style No")%>:<%#Container.DataItem("StyleNo")%>
					<BR>
					&nbsp;<%=GetSystemText("Description")%>:
					<%#Container.DataItem("Description")%>
					<BR>
					&nbsp;<%=GetSystemText("Size Range")%>:
					<%#Container.DataItem("SizeRange")%>
					<BR>
				</ItemTemplate>
			</asp:datalist></form>
	</body>
</HTML>
