﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ColorwaySeasonal.aspx.vb" Inherits="plmOnApp.Style.ColorwaySeasonal.Style_ColorwaySeasonal" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_Header" Src="Style_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Colorway</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">

			<uc1:Style_Workflow id="Style_Workflow1" runat="server"></uc1:Style_Workflow>
	<asp:panel id="pnlChange" runat="server">
		<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
	</asp:panel>
	<uc3:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
	</uc3:style_header>
	<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
		<tr>
			<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
		</tr>
	</table>
	
<%--			<asp:Panel ID="pnlSeasonYear"  runat="server"  >		
			<table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                    <td width="125" align="right" nowrap="nowrap">
                        <asp:Label runat="server" ID="lblStyleSeasonYear" class="fontHead" >Select Season / Year:</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                    </td>
                </tr>
            </table>
            </asp:Panel>--%>
            <br /> 
            <asp:datagrid id="dgColorway" runat="server" BorderStyle="NotSet" AllowSorting="true" DataKeyField="StyleColorID"
                 AutoGenerateColumns="false" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                cellspacing="0">
		        <PagerStyle />
		        <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		        <ItemStyle Height="20px" CssClass="font"></ItemStyle>
		        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                <Columns>
                    <asp:TemplateColumn ItemStyle-BorderWidth="1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnColorActive" runat="server" Value='<%# Eval("ColorActive") %>' />
                        </ItemTemplate> 
                    </asp:TemplateColumn>
                </Columns>
	        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			<br/>   
			
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
</body>
</html>


