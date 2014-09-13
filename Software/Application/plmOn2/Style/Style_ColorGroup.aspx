﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ColorGroup.aspx.vb" Inherits="plmOnApp.Style.ColorGroup.Style_ColorGroup" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%--<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>--%>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title runat="server" id="PageTitle"></title>
    <link  href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="form1" runat="server">
			<%--<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" 
                height="25" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:ImageButton id="btnSave" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_save.gif" />
						<cc1:BWImageButton ID="btnColorAdd" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_addColor.gif" />
						<cc1:BWImageButton id="btnRemove" runat="server" ImageUrl="../System/Button/ButtonStream.ashx?BN=btn_remove.gif" />						
					</td>
					<td></td>
				</tr>
			</table>--%>
			<uc1:Style_Workflow id="Style_Workflow1" runat="server"></uc1:Style_Workflow>
			
			<asp:panel id="pnlChange" runat="server">
			    <uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'></uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<asp:Panel ID="pnlSeasonYear"  runat="server"  >
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
            </asp:Panel> 
            <br /> 	       
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td valign="top"><asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleColorGroupID" EnableViewState="False" AllowSorting="true"
							BorderColor="#E0E0E0">
							<AlternatingItemStyle Height="20px"  CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
				</tr>
			</table>			
			<BR>
			<table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
					<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead"></asp:label>&nbsp;/
						<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>
		</form>
	</body>
</html>








