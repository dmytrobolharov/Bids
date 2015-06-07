<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Image_License.aspx.vb" Inherits="srmOnApp.Style_Image_License"   %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Image License</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Menu.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
       <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td noWrap width="650">					
                    <cc1:bwimagebutton id="btnPrint" runat="server" ></cc1:bwimagebutton>
					</td>					
				</tr>
			</table>
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment>
			<asp:datalist id="Datalist1" runat="server" CssClass="font" Datakeyfield="StyleMaterialID" BorderWidth="1px"
				BorderStyle="Solid" BorderColor="Silver" BackColor="White" RepeatColumns="4" RepeatDirection="Horizontal"
				GridLines="Both" Width="100%">
				<HeaderTemplate>
				</HeaderTemplate>
				<ItemStyle Height="250px" Width="225px" VerticalAlign="Top"></ItemStyle>
				<ItemTemplate>
					<TABLE width="100%">
						<TR>
							<TD vAlign="top">
								<!--
								<TABLE width="100%">
									<TR>
										<TD align="center"><%# ImageVersionDataReader(Container.DataItem("MaterialImageID").tostring, Container.DataItem("MaterialImageVersion").tostring) %></TD>
									</TR>
								</TABLE>
							-->
								<TABLE width="100%">
									<TR>
										<TD align="center">
											<cc1:BWImageButton id="imgDesign" runat="server"></cc1:BWImageButton>
										</TD>
									</TR>
								</TABLE>
								<TABLE width="100%">
									<TR>
										<TD width="85"><FONT size="1"><B><asp:label id="lblAddress" runat="server"><%#GetSystemText("Material No")%>:</asp:label></B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("MaterialNo")%></FONT></TD>
									</TR>
									<TR>
										<TD width="85"><FONT size="1"><B><asp:label id="Label1" runat="server"><%#GetSystemText("Material Name")%>:</asp:label></B></FONT></TD>
										<TD><FONT size="1"><%#Container.DataItem("MaterialName")%></FONT></TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
	</body>
</HTML>
