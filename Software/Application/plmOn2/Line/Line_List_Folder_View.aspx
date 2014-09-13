<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Line_List_Folder_ViewStyle" Src="Line_List_Folder_ViewStyle.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_View.aspx.vb" Inherits="plmOnApp.Line_List_Folder_View" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html>
<html>
	<head>
		<title>Line List Folder</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/toastr.min.css" type="text/css" rel="stylesheet" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <!-- 
        Attention, developer!
        Datalist, for which we're generating style, is held in control, and this control -- in another control, so
        if you want the stylefix below to work, you should change datalist ID in it every time you change ID of
        any user control in this page.
        -->
        <style type="text/css">
            #ctrLineSearch_ctrLineFolder_Datalist1 span.fontHead
            {
                width: 60px;
                white-space: nowrap;
            }
            th a img {
                border: none;
            }
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }
        </style>
        <style>
             .imgContainer
            {
                position:relative;
            }
            .imgContainer div 
            {
                position:absolute;
                background-color: White;
                left: 0px;
                visibility: hidden;
            }
        </style>
	</head>
	<body>
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
						<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:BWImageButton id="btnNewStyle" runat="server" Message="NONE"></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnAddStyle" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        
						<cc1:bwimagebutton id="btnSort" runat="server" ></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="btnSend" runat="server" Message="NONE" 
							Visible="False"></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnPrint" runat="server" ></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="btnBurn" runat="server" Message=""
							></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnDrop" runat="server" ></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="btnNewIssue" runat="server" Message="NONE" 
							CausesValidation="False"></cc1:confirmedimagebutton>
						<cc1:bwimagebutton id="btnRemove" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnDelete" runat="server" visible="false" Message="NONE" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:confirmedimagebutton>
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
		                <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor:pointer"  src="../System/Icons/icon_Next.gif" />
		                <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
		            </td>
		            <td class="fontHead">
			            <asp:label id="lblHeaderDetail" runat="server"></asp:label>
		            </td>
	            </tr>
            </table>
            <div id="divHeaderContent" style="display:none">
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><asp:placeholder id="plhHeaderControlsHolder" runat="server"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
            </div>
            <asp:placeholder id="phSearch" runat="server"></asp:placeholder>
			
            <asp:HiddenField ID="hdnXmlFiles" runat="server" />
            <asp:HiddenField ID="hdnSelectedStyleTypes" runat="server" />
            <asp:HiddenField ID="hdnSelectedStyleCategories" runat="server" />
            <asp:HiddenField ID="hdnSelectedCalendars" runat="server" />

            <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

            <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
            <script type="text/javascript" src="../System/Jscript/toastr.min.js"></script>

                <script language="javascript" type="text/javascript">

                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "positionClass": "toast-bottom-right",
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "0",
                        "extendedTimeOut": "0",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }

                    function MakeNotificationAsRead(planningActivity) {
                        PageMethods.NotificationStatusUpdate(planningActivity, '<%= UserProperties.TeamID %>');
                    }


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

                    $(document).ready(function(){
                    window.parent.document.getElementById('frameset').cols = "150,*";
                    });

                    function ColumnHidden(sender, eventArgs) {
                        var tableColumns = $find("ctrLineSearch_ctrLineFolder_RadGridStyles").get_masterTableView().get_columns();
                        var hiddenColumns = new Array();
                        for (var i = 0; i < tableColumns.length; i++) {
                            if (tableColumns[i].get_visible() == false) {
                                hiddenColumns.push(tableColumns[i].get_uniqueName());
                            }
                        }
                        var strHiddenColumns = hiddenColumns.join();
                        PageMethods.SaveHiddenColumns('ctrLineSearch_ctrLineFolder_RadGridStyles', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
                    }

                    function ColumnShown(sender, eventArgs) {
                        var tableColumns = $find("ctrLineSearch_ctrLineFolder_RadGridStyles").get_masterTableView().get_columns();
                        var hiddenColumns = new Array();
                        for (var i = 0; i < tableColumns.length; i++) {
                            if (tableColumns[i].get_visible() == false) {
                                hiddenColumns.push(tableColumns[i].get_uniqueName());
                            }
                        }
                        var strHiddenColumns = hiddenColumns.join();
                        PageMethods.SaveHiddenColumns('ctrLineSearch_ctrLineFolder_RadGridStyles', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
                    }

                </script>
            </telerik:RadScriptBlock>
        </form>
        <script type="text/javascript" language="javascript">
            $(window).load(function () {
                var width = 0;
                var height = 0;

                var intervalHandlers = new Array();

                $(".imgContainer").each(function (index) {
                    $(this).attr("id", index);

                    var hasDesignBack = false;

                    hasDesignBack = $(this).find(".imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1;

                    if (hasDesignBack) {
                        width = Math.max(width, Math.max($(this).find(".imgDesign").width(), $(this).find(".imgDesignBack").width()));
                        height = Math.max(height, Math.max($(this).find(".imgDesign").height(), $(this).find(".imgDesignBack").height()));
                    }

                    else {
                        width = Math.max(width, $(this).find(".imgDesign").width());
                        height = Math.max(height, $(this).find(".imgDesign").height());
                    }

                    $(this)
                    .mouseover(function () {
                        if (hasDesignBack) {
                            $(this).find(".imgDesignContainer").fadeOut();
                            clearInterval(intervalHandlers[$(this).attr("id")]);
                            var elementToToggle = $(this).find(".imgDesignContainer");
                            intervalHandlers[$(this).attr("id")] = setInterval(function () {
                                elementToToggle.fadeToggle()
                            }, 1200);
                        }
                    })
                    .mouseleave(function () {
                        if (hasDesignBack) {
                            clearInterval(intervalHandlers[$(this).attr("id")]);
                            $(this).find(".imgDesignContainer").fadeIn();
                        }
                    });
                });

                $(".imgContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgDesignBackContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgDesignContainer").css({
                    "width": width,
                    "height": height
                });

                $(".imgContainer").each(function (index) {
                    $(this).find(".imgDesignContainer").css("visibility", "visible");

                    if ($(this).find(".imgDesignBack").attr("src").indexOf("00000000-0000-0000-0000-000000000000") == -1) {
                        $(this).find(".imgDesignBackContainer").css("visibility", "visible");
                    }
                });
            });
        </script>
	</body>
</html>
