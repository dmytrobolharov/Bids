<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_Main.aspx.vb" Inherits="plmOnApp.TechPack_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="TechPack_Status" Src="TechPack_Status.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Tech Pack</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></TD>
					<td><cc1:bwimagebutton 
					id="btnNew" runat="server" ></cc1:bwimagebutton></td>
					<td></td>
				</tr>
			</table>
				
						
			<table height="10" cellspacing="0" cellpadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblStyleHeaderNew" runat="server" ForeColor="#E0E0E0" Font-Size="XX-Large" Font-Names="Tahoma,Verdana">Tech Pack</asp:label></td>
				</tr>
			</table>
            <uc1:TechPack_Status runat="server" ID="TechPack_Status1"></uc1:TechPack_Status>
			<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td vAlign="top"><asp:datalist id="dlTechPackSize" runat="server">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<TABLE class="TableHeader" id="tbTechPackSize" height="25" cellSpacing="0" cellPadding="0"
									width="825" border="0" runat="server">
									<TR vAlign="middle">
										<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
										<TD>
											<asp:Label id="lblSizeClass" runat="server" CssClass="fontHead"></asp:Label>&nbsp;
											<asp:Label id="lblDueDate" runat="server" CssClass="fontHead"></asp:Label></TD>
									</TR>
								</TABLE>
								<asp:DataGrid id="dlTechPack" runat="server" ShowHeader="True" AutoGenerateColumns="False" Width="825px"
									OnItemDataBound="dlTechPack_ItemDataBound" BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
									<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
									<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
									<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
								</asp:DataGrid>
								<BR>
							</ItemTemplate>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
