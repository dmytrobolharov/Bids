﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_NBOL.aspx.vb" Inherits="plmOnApp.Style.BOLNew.Style_NBOL" %>

<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>BOL</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        #RadGridBOLData td { cursor:default; }  
        #RadGridBOLData .rgRowYPLMLtBlueE td.rgExpandCol {cursor: pointer;}
        #RadGridBOLData.RadGrid_YPLM .rgHoveredRow td { background-image: none !important; background-color: #508FE2 !important; }  
        #RadGridBOLData.RadGrid_YPLM .rgDataDiv td { white-space: normal!important; }
        #RadGridBOLData .rgRowYPLMBlueE td.font { padding: 2px 10px 2px 4px; }      
    </style>
     <style type="text/css">
    #RadGridBOLData .rightAlign
    {
    	text-align:right;
    }
    
    #RadGridBOLData .rightAlign input
    {
    	text-align:right;
    }
     .leftAlign
    {
    	text-align:left;
    }
    
     .leftAlign select
    {
    	text-align:left;
    }
     .leftAlign input
    {
    	text-align:left;
    }
    
    .boldBorder
    {
    	 border-left: 2px dotted green;
    }
    
    #RadGridBOLData_GridHeader .rgHeaderYPLME
    {
      white-space:normal !important;  
    } 
        th.rgHeaderYPLM, th.rgHeader {
            padding: 0 0px !important;
        }    
    </style>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server"  defaultbutton="imgBtnSearch" defaultfocus="form1">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js">
            </asp:ScriptReference>
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
        
    <uc1:Style_Workflow ID="Style_Workflow1" runat="server"></uc1:Style_Workflow>
    <asp:Panel ID="pnlChange" runat="server">
        <uc1:Style_Change_Alert ID="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
    </asp:Panel>
    <uc2:Style_Header ID="Style_Header1" runat="server"></uc2:Style_Header>
    <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td height="20">
                <uc1:Style_Comment ID="Style_Comment1" runat="server"></uc1:Style_Comment>
            </td>
        </tr>
    </table>
    <uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />

    <asp:Panel ID="pnlSeasonYear"  runat="server" >
        <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
            border="0">
            <tr valign="middle" align="left">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
                </td>
                <%--<td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                <td width="155">
                    <asp:Label runat="server" ID="lblSeasonYear" class="fontHead" style="white-space:nowrap;" >Select Season / Year:</asp:Label>
                </td>
                <td width="150">
                    <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                </td>--%>
                <td width="200">
                    <asp:Label runat="server" ID="lblExchangeRate" class="fontHead" style="white-space: nowrap; padding-left: 10px;">Select Currency Conversion:</asp:Label>
                </td>
                <td width="150">
                    <asp:DropDownList  ID="ddlExchangeRate" runat="server" AutoPostBack="true" ></asp:DropDownList>
                </td>
                <td width="350">
                    <table id="tblBOLTemplate" visible="false"  height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
		                runat="server">
		                <tr valign="middle">
			                <td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
                            <td class="TableBar" valign="middle" width="20" style="padding-left: 9px;"><IMG src="../System/icons/icon_template.gif"></td>
			                <td class="TableBar"><cc1:bwhyperlink id="lnkBolTemplate" visible="true" runat="server" WindowName="PomTemplate"></cc1:bwhyperlink></td>
			                <td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
		                </tr>
	                </table>
                </td>
                <td></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlHeaderTotals" runat="server">
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr class="TableHeader" height="25">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/>
                </td>
                <td valign="middle" width="20">
                    <img id="imgCollapseTotals" runat="server" alt="Collapse Totals" src="../System/Icons/icon_Down.gif" onclick="collapseTotals();" style="display: none; cursor:pointer;"/>
                    <img id="imgExpandTotals" runat="server" alt="Expand Totals" src="../System/Icons/icon_Next.gif" onclick="expandTotals();" style="cursor:pointer;"/>
			    </td>
                <td>
                    <asp:Label ID="lblTypeTotals" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField runat="server" id="hdnTTimeSort" />
    <asp:HiddenField runat="server" id="hdnIsTotalSort" Value="0" />
    <table cellspacing="2" cellpadding="0" width="" border="0" align="center"
        id="tblTTime" runat="server" style="display:none;">
        <tr>
            <td align="center">
                <asp:DataGrid ID="DataGridTTime" Width="100%" runat="server" ShowHeader="true" AllowSorting="True"
                    CellPadding="4" DataKeyField="OperationTypeID" BorderStyle="Solid" BorderWidth="3"
                    BorderColor="Black" AutoGenerateColumns="True" HeaderStyle-Height="0">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                    <HeaderStyle BackColor="#AABBCC" />
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    <br />
    <table id="tbSearch" cellspacing="0" cellpadding="0" width="100%" bgcolor="white"
        border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhSearchControl" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
            <td width="100%" valign="bottom">
                <table height="45">
                    <tr>
                        <td>
                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:PlaceHolder runat="server" ID="plhGridData"></asp:PlaceHolder>
    <br />
    <table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_left.gif" />
            </td>
            <td class="TableBar" valign="middle" align="center" width="20">
                <img src="../System/icons/icon_changeobject.gif">
            </td>
            <td class="TableBar">
                <asp:Label ID="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
                <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_right.gif" />
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript" language="javascript">
        function getElementsByNameIE(tag, name) {

            var elem = document.getElementsByTagName(tag);
            var arr = new Array();
            for (i = 0, iarr = 0; i < elem.length; i++) {
                att = elem[i].getAttribute("name");
                if (att == name) {
                    arr[iarr] = elem[i];
                    iarr++;
                }
            }
            return arr;
        }

        function hideUnhide(MacroParentId, id) {
            var h = getElementsByNameIE("tr", "hide_" + MacroParentId)
            for (var i = 0; i < h.length; i++) {
                if (h[i].style.display == 'none') {
                    h[i].style.display = ''
                    document.getElementById(id).src = '../System/Icons/tv_minusdotst.gif'
                }
                else {
                    if (h[i].style.display == '') h[i].style.display = 'none'
                    document.getElementById(id).src = '../System/Icons/tv_plusdotsbt.gif'
                }
            }
        }

        /** Resizing BOM Grid to take all the free height on the screen **/
        (function resizeGrid() {

            var changeGrid = $("#RadGridBOLData");
            var windowHeight = $(window).height();
            var formHeight = $("#form1").height();
            var minHeight = 100;

            // Calculating, how much free space we have on the window for grid area
            var diff = windowHeight - (formHeight - changeGrid.height());

            if (diff > minHeight) {
                changeGrid.height(diff);
            } else {
                changeGrid.height(minHeight);
            }
        })();

        function collapseTotals() {
            var btnCollapse = $("#imgCollapseTotals");
            var btnExpand = $("#imgExpandTotals");
            var collapsibleSection = $("#tblTTime");

            collapsibleSection.hide();
            btnExpand.show();
            btnCollapse.hide();
        }

        function expandTotals() {
            var btnCollapse = $("#imgCollapseTotals");
            var btnExpand = $("#imgExpandTotals");
            var collapsibleSection = $("#tblTTime");

            collapsibleSection.show();
            btnExpand.hide();
            btnCollapse.show();
        }

        function expandToggleAll(expandCollapseItem) {
            var expanded = (expandCollapseItem.src.toLowerCase().indexOf("icon_next.gif") != -1);

            var dataitems = $find("<%= IF(m_RadGridBOLData IsNot Nothing, m_RadGridBOLData.MasterTableView.ClientID, String.Empty) %>").get_dataItems();
            for (var i = 0, len = dataitems.length; i < len; i++) {
                if (dataitems[i].get_nestedViews().length > 0) {
                    dataitems[i].set_expanded(expanded);
                }
            }
            
            expandCollapseItem.src = expanded ? "../System/Icons/icon_Down.gif" : "../System/Icons/icon_Next.gif";
        }


        /**
        * to align operatins in macro with other operation moved then from inner table to outter one
        */
        var expands = {};

        $(".rgDetailTable").each(function () {
            var $self = $(this),
                $trigger = $self.closest("tr").prev(),
                $moved = $self.find("tbody tr[id]").hide();

            $trigger.next()
                .height(0)                
                .css({ border: 0, visibility: "hidden" })
                    .children().css({ border: 0, padding: 0 }).end()                    
                .after($moved);

            expands[$trigger.attr("id")] = $moved;
        });

        function OnHierarchyExpanding(sender, e) {            
            expands[e.get_id()].show();

            return true;
        }

        function OnHierarchyCollapsing(sender, e) {            
            expands[e.get_id()].hide();

            return true;
        }

        $("td:empty").append("&nbsp;");

        var hdnSort = document.getElementById("hdnIsTotalSort");
        if (hdnSort.value == "1")
        {
            var btnCollapse = $("#imgCollapseTotals");
            var btnExpand = $("#imgExpandTotals");
            var collapsibleSection = $("#tblTTime");

            collapsibleSection.show();
            btnExpand.hide();
            btnCollapse.show();
        }
    </script>

</body>
</html>
