<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_FinancialPlan.aspx.vb" Inherits="plmOnApp.Planning_Folder_FinancialPlan" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
        <meta http-equiv="X-UA-Compatible" content="IE=9" />
		<title>Line Plan Folder</title>
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
        <style type="text/css">
            .fontRed A {COLOR: Red !important;}
            th.rgHeader {padding: 0 !important;}
            th A {vertical-align: middle !important; text-align: center !important; height: 0 !important; white-space:normal !important;} 
            .TableFooter td {background-image: url(../System/Images/table_header.gif) !important; background-repeat: repeat-x; font-weight: bold;}
            #FinancialPlanGrid td { border-color: #ccc; }
        </style>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />

        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadScriptManager>
        <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadStyleSheetManager>
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td>
						<cc1:confirmedimagebutton id="btnEdit" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					</td>
				</TR>
			</TABLE>
			<table height="10" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line Plan Folder...</asp:label></td>
				</tr>
			</table>
            <hc1:Planning_Header ID="PlanningHeader" runat="server" />
            <br />
            <table id="tblFinPlan" width="100%" border="0" bgcolor="#ffffff" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="20%" id="tdTree" valign="top">
                        <table class="TableHeaderOver" id="tblSourcingHeader" runat="server" height="24" cellSpacing="0" cellpadding="0"
				            width="100%" border="0">
				            <tr>
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead">
						            <div align="center">
                                        <asp:Label ID="lblMenuHeader" runat="server" ></asp:Label>
                                    </div>
					            </td>
				            </tr>
			            </table>
                        <div id="divMenu" style="overflow: auto;">
                            <cc2:YSTreeView id="YSTreeViewPlanMenu" runat="server"></cc2:YSTreeView>
                        </div>
                    </td>
                    <td valign="top">
                        <table cellSpacing="0" cellPadding="0" border="0" width="100%">
                        <tr vAlign="middle">
                            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                            <td align="left"><asp:Panel ID="pnlLinePlanBreadCrumb" runat="server"></asp:Panel></td>
                            <td>&nbsp;</td>
                        </tr>
                        </table>
                        <div id="divGrid" style="overflow: hidden;">
                           <asp:PlaceHolder runat="server" ID="plhFinancialPlanGrid"></asp:PlaceHolder>
                        </div>
                    </td>
                </tr>
            </table>
        <script language="javascript" type="text/javascript">
            $("#divGrid").width($("#lblHeader").parent().width() - $("#tdTree").width())
            $("#FinancialPlanGrid").width($("#divGrid").width())
        </script>
        </form>
        <script type="text/javascript" language="javascript">
            function ShowHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnCol').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'block';
                return false;
            }

            function HideHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnExp').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'none';
                return false;
            }

            function ColumnHidden(sender, eventArgs) {
                var tableColumns = $find("FinancialPlanGrid").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('FinancialPlanGrid', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }

            function ColumnShown(sender, eventArgs) {
                var tableColumns = $find("FinancialPlanGrid").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('FinancialPlanGrid', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }
        </script>
	</body>
</html>
