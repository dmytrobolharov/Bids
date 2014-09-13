﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ColorwaySeason.aspx.vb" Inherits="plmOnApp.Style.ColorwaySeasonal.Style_ColorwaySeason" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Colorway</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">

	<uc1:Style_Workflow id="Style_Workflow1" runat="server"></uc1:Style_Workflow>
	<asp:panel id="pnlChange" runat="server">
		<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
	</asp:panel>
	<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
	</uc2:style_header>
	<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
		<tr>
			<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
		</tr>
	</table>
			
    <asp:datagrid id="dgSampleRequest" runat="server" BorderStyle="NotSet" AllowSorting="true"
         AutoGenerateColumns="false" 
         BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
        cellspacing="0">
		<PagerStyle />
		<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		<Columns>
		    <asp:TemplateColumn ItemStyle-HorizontalAlign="Center" >
		        <ItemTemplate>
		            <cc1:BWImageButton  ID="ImgColorwaySeason" runat="server"  /> 
		        </ItemTemplate> 
		    </asp:TemplateColumn>
		</Columns>
		<ItemStyle Height="20px" CssClass="font"></ItemStyle>
		<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
    <br /><br/>
	<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
		runat="server">
		<tr valign="middle">
			<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
			<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
			<td class="TableBar">
				<asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
				<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
			<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
		</tr>
	</table>

    </form>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $('p[id="Inactive"]').each(function() {
                $(this).closest('td').css('background-color', 'LightGray');
            })
        })
    </script>
</body>
</html>
