<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="uc1" TagName="Line_List_Folder_ViewStyle" Src="Line_List_Folder_ViewStyle.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_FinancialPlan.aspx.vb" Inherits="plmOnApp.Line_List_Folder_FinancialPlan" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Line List Folder</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />

        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
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
						<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnPlanningValues" runat="server" ></cc1:bwimagebutton>
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
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line List Folder...</asp:label></td>
				</tr>
			</table>
            <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	            <tr class="TableHeader">
		            <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td width="20">
		                <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor:pointer; display:none;"  src="../System/Icons/icon_Next.gif" />
		                <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
		            </td>
		            <td class="fontHead">
			            <asp:label id="lblHeaderDetail" runat="server"></asp:label>
		            </td>
	            </tr>
            </table>
            <div id="divHeaderContent">
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><asp:placeholder id="plhHeaderControlsHolder" runat="server"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
            </div>
            <br />
            <table id="tblFinPlan" width="100%" border="0" bgcolor="#ffffff" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="20%" valign="top">
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
                    <td width="80%" valign="top">
                       <asp:PlaceHolder runat="server" ID="plhFinancialPlanGrid"></asp:PlaceHolder>
                       &nbsp;
                    </td>
                </tr>
            </table>
			
            <asp:HiddenField ID="hdnXmlFiles" runat="server" />
            <asp:HiddenField ID="hdnSelectedStyleTypes" runat="server" />
            <asp:HiddenField ID="hdnSelectedStyleCategories" runat="server" />
            <asp:HiddenField ID="hdnSelectedCalendars" runat="server" />

            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
                <script language="javascript" type="text/javascript">

                    function GetSelectedStyleTypes() {
                        var comboItems = $find('<%= dclStyleType.ClientID %>').get_items();
                        var hdnSelectedStyleTypes = $("#hdnSelectedStyleTypes");

                        var oldSelectedStyleTypes = $(hdnSelectedStyleTypes).val(); 
                        var strSelectedStyleTypes = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedStyleTypes != "") {
                                    strSelectedStyleTypes += ",";
                                }
                                strSelectedStyleTypes += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedStyleTypes).val(strSelectedStyleTypes);
                        return (strSelectedStyleTypes != oldSelectedStyleTypes)
                    }

                    function OnStyleTypesLoad(sender, eventArgs) {
                        GetSelectedStyleTypes();    
                    }

                    function OnStyleTypesSelectionChanged(sender, eventArgs) {
                        var doRefresh = GetSelectedStyleTypes();
                        if (doRefresh) {
                            <%= ClientScript.GetPostBackEventReference(New PostBackOptions(dclStyleType) With {.PerformValidation = False}) %>;
                        }
                    }

                    
                    function GetSelectedStyleCategories(sender, eventArgs) {
                        var comboItems = $find('<%= dclStyleCategory.ClientID %>').get_items();
                        var hdnSelectedStyleCategories = $("#hdnSelectedStyleCategories");

                        var strSelectedStyleCategories = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedStyleCategories != "") {
                                    strSelectedStyleCategories += ",";
                                }
                                strSelectedStyleCategories += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedStyleCategories).val(strSelectedStyleCategories);
                    }

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

                      function GetSelectedCalendars(sender, eventArgs) {
                        var comboItems = $find('<%= dclCalendar.ClientID %>').get_items();
                        var hdnSelectedCalendars = $("#hdnSelectedCalendars");

                        var strSelectedCalendars = ""

                        for (var i = 0; i < comboItems.get_count(); i++) {
                            if (comboItems.getItem(i).get_checked()) {

                                if (strSelectedCalendars != "") {
                                    strSelectedCalendars += ",";
                                }
                                strSelectedCalendars += comboItems.getItem(i).get_value();
                            }
                        }
                        $(hdnSelectedCalendars).val(strSelectedCalendars);
                    }

                </script>
            </telerik:RadScriptBlock>
        </form>
	</body>
</HTML>
