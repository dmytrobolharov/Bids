﻿<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_FlashEditPage.aspx.vb" Inherits="plmOnApp.Line_List_Folder_FlashEditPage" %>
<%@ Register Src="Line_List_Header.ascx" TagName="Header" TagPrefix="hc1" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<title></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">

	        .rgRowYPLME td, .rgAltRowYPLME td {
	    	    padding: 2px 2px !important;
	    	    border-color: #ddd !important;
	    	    white-space: normal !important;
	        }

            th.rgHeaderYPLME, th.rgHeader {
                padding: 0px 2px !important;
                white-space: normal !important;
            }

        </style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch" defaultfocus="Form1">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </Scripts>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadScriptManager>
        <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadStyleSheetManager>
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

		    <TABLE class="TableHeader" id="TABLE1" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
			    <TR vAlign="middle">
				    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnBatchUpdate" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    </td>
				    <td>&nbsp;</td>
			    </TR>
		    </TABLE>
		    <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			    <tr><td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td></tr>
		    </table>
            <hc1:Header ID="LineListHeader" runat="server" />
			<table class="TableHeaderYellow" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="LabelEdit" runat="server" Font-Names="Tahoma,Verdana"  ><%=GetSystemText("Flash Edit")%></asp:Label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellpadding="0" width="100%" bgcolor="#EEEB9F" border="0">
				<tr><td><asp:placeholder id="plhBatchControlsHolder" runat="server" EnableViewState="False" ></asp:placeholder></td></tr>
			</table>
            <table class="TableHeaderBlue" height="25" width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr valign="middle">
				    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:Label id="lblSearch" runat="server" Font-Names="Tahoma,Verdana"><%=GetSystemText("Style Search")%> </asp:Label></td>
				</tr>
			</table>
            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
                <tr colspan="2"><td>&nbsp;</td></tr>
                <tr>
                    <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
                    <td vAlign="top" width="100%"><table height="45"><tr><td><asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></td></tr></table></td>
                </tr>
            </table>
			
            <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <TR vAlign="top">
		            <TD>
			            <TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <TR vAlign="middle">
					            <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					            <TD width="16"></TD>
					            <TD class="fontHead" width="120"><asp:CheckBox ID="chkThumb" runat="server" AutoPostBack="true" /></TD>
					            <TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
					            <TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
					            <TD noWrap align="center" width="200"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					            <TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
					            <TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
					            <TD width="10">&nbsp;</TD>
					            <TD noWrap width="200"><asp:label id="lblRecordCount" runat="server" CssClass="font"></asp:label></TD>
                                <TD width="400" align="right">
                                    <asp:RadioButtonList ID="rbFixed" RepeatDirection="Horizontal" runat="server" AutoPostBack="true" Visible="false">
                                        <asp:ListItem Text="Fixed Markup" Value="M"></asp:ListItem>
                                        <asp:ListItem Text="Fixed Price" Value="P" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </TD>
                                <TD></TD>
					            <TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						            </asp:dropdownlist></TD>
					            <TD width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" CausesValidation="false"></asp:button></TD>
				            </TR>
			            </TABLE>
			            <asp:datagrid id="DataGrid1" runat="server" AllowSorting="true" DataKeyField='<%#strLineListFlashEditGridPKI%>' >
				            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
				            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				            <PagerStyle Visible="False"></PagerStyle>				
				            <Columns>
				                <asp:TemplateColumn Visible="true">
                                    <HeaderTemplate><input type="checkbox" runat="server" id="chkSelectAll" onclick="SelectAll(this);" /></HeaderTemplate>
				                    <ItemTemplate>
                                        <input type="checkbox" runat="server" id="chkSelectStyle" />
                                        <asp:HiddenField ID="hdnAddIDs" runat="server" Value='<%# Eval("AddIDs").ToString %>' />
                                    </ItemTemplate>
				                </asp:TemplateColumn>
				                <asp:TemplateColumn Visible="false">
                                    <ItemTemplate><img alt="" src='<%# GetImageStreamPath("50", Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>' runat="server" /></ItemTemplate>
				                </asp:TemplateColumn>
				            </Columns>
				            
			            </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="false"></asp:label>
			            <asp:label id="CurrentPageIndex" runat="server" Visible="false" Text="0"></asp:label>
			        </TD>
	            </TR>
            </TABLE>
            <asp:PlaceHolder runat="server" ID="plhRadGrid"></asp:PlaceHolder>			
    </form>
    <script language="javascript" type="text/javascript"  >
        var frm = document.Form1;
        function SelectAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf('chkSelectStyle') != -1)
                    e.checked = actVar;
            }
        }

        $(document).ready(function () {
            $("#RadGridStyles input:text").each(function () {
                $(this).width($(this).width() - 10);
            });
        });

	</script>    
</body>
</html>
