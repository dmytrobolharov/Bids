<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register Src="Planning_Header.ascx" TagName="Planning_Header" TagPrefix="hc1" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_DevelopmentTracker.aspx.vb" Inherits="plmOnApp.Planning_Folder_DevelopmentTracker" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Line Plan Folder</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/jquery-ui-1.10.3.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/toastr.min.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

        <style type="text/css">
            th a img {
                border:none;
            }
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }  
            #styles-list  {
            	margin: 0;
            	padding: 2px;
            }
            #styles-list li {
            	list-style-type: none;
            	display: inline-block;
            	margin: 2px;
            	width: 75px;
            	height: 75px;
            	text-align: center;
            	vertical-align: bottom;
            	zoom: 1;
            	*display: inline;            	
            }
            #styles-list li span {
            	display: block;
            	text-align: center;
            	margin-top: 2px;
            }  
            #styles-list img {
            	border: 1px solid #ddd;
            }   
            .img-cont {
            	height: 50px;
            	width: 50px;            	
            }
            #remove-dialog, #empty-message { display: none; }
        </style>
        <style type="text/css">
             .imgContainer
            {
                position:relative;
            }
            .imgContainer div 
            {
                position:absolute;
                left:0;
                background-color: White;
                visibility: hidden;
            }
            
            .imgContainer div:before,
            .frame_before {
                content: "";
                display: inline-block;
                height: 100%;
                vertical-align: middle;
            }

            .imgContainer img {
                vertical-align: middle;
            }           
        </style>
        <!--[IF IE]>
        <style type="text/css">
            .imgContainer div {
                list-style:none;
                behavior: expression(
                    function(t){
                        t.insertAdjacentHTML('afterBegin','<span class="frame_before"></span>');
                        t.runtimeStyle.behavior = 'none';
                    }(this)
                );
            }
        </style>
        <![endif]-->
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">

        <telerik:radscriptmanager ID="RadScriptManager1" runat="server" 
            EnablePageMethods="true">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
        </telerik:radscriptmanager>
        <telerik:radstylesheetmanager ID="RadStyleSheetManager1" Runat="server">
            <StyleSheets>
                <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:radstylesheetmanager>
        <telerik:radajaxmanager runat="server" ID="RadAjaxManager1" />
            
            <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td>
                        <cc1:ConfirmedImageButton ID="btnImport" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                        <cc1:BWImageButton id="btnNewStyle" runat="server" Message="NONE"></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnAddStyle" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnDrop" runat="server" ></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnSetActive" runat="server" ></cc1:confirmedimagebutton>
                        <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE" OnClientClick="return showRemoveDialog()"></cc1:ConfirmedImageButton>
                        <cc1:BWImageButton id="btnSort" runat="server" Message="NONE" ></cc1:BWImageButton>
                        <cc1:confirmedimagebutton id="btnImageAllocation" runat="server" Message="NONE" OnClientClick="reloadParentPage(); return false;"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnBOMManger" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnAutoGenerate" runat="server"></cc1:confirmedimagebutton>
                        <cc1:BWImageButton id="btnConfigure" runat="server" Message="NONE" ></cc1:BWImageButton>
                        <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnExcelExport" runat="server"  Message="NONE" OnClientClick="enable_close_link();"></cc1:confirmedimagebutton>
					</td>
				</TR>
			</TABLE>

			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line Plan Folder...</asp:label></td>
				</tr>
			</table>
            <hc1:Planning_Header ID="PlanningHeader" runat="server" />
            <cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
            <table id="tblFinPlan" width="100%" border="0" bgcolor="#ffffff" cellspacing="0" cellpadding="0" runat="server">
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
            <asp:HiddenField ID="hdnWSClientID" runat="server" />
            <asp:HiddenField ID="hdnWSClientPassword" runat="server" />
            <asp:HiddenField ID="hdnPLMUserName" runat="server" />
            <asp:HiddenField ID="hdnPLMPassword" runat="server" />
<%--            <TABLE  id="StylesExistAlert" cellSpacing="0" cellPadding="0" width="100%" border="1" borderColor="#0061fe"
				runat="server">
				<TR vAlign="middle" align="left">
					<TD vAlign="middle" align="left" ><TABLE id="Table3" cellspacing="1" width="100%" bgColor="#699ff7" border="0"><tr><td><%= GetSystemText("Styles matching this Line Plan exist outside of this plan...")%></TD>	</TR></TABLE>		
            </TD>
								</TR>
			</TABLE>	--%>			
            <asp:placeholder id="phSearch" runat="server"></asp:placeholder>
            <div id="remove-dialog">
                <p><%= GetSystemText("You are about to remove the following styles from this Line Plan?")%></p>
                <ul id="styles-list"></ul>
                <p><%= GetSystemText("Are you sure you want to continue?")%></p>
            </div>
            <div id="empty-message"><%= GetSystemText("Please, select styles you want to remove")%></p></div>
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

            function reloadParentPage() {
                var currentPageLocation = window.location.href;
                window.parent.location.href = currentPageLocation.replace('Planning_Folder_DevelopmentTracker.aspx', 'Planning_FlashEdit_Image.aspx');
                return false;
            }

            function ColumnHidden(sender, eventArgs) {
                var tableColumns = $find("ctrPlanSearch_ctrPlanningStyle_RadGridStyles").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('ctrPlanSearch_ctrPlanningStyle_RadGridStyles', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }

            function ColumnShown(sender, eventArgs) {
                var tableColumns = $find("ctrPlanSearch_ctrPlanningStyle_RadGridStyles").get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns('ctrPlanSearch_ctrPlanningStyle_RadGridStyles', '<%= aspxPageName & "?PLID=" & strPlanningId %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }
        </script>

        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/toastr.min.js"></script>

        <script type="text/javascript">

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

            function showAlert() {
                $("#empty-message").dialog({
                    title: '<%= GetSystemText("Remove Styles") %>',
                    modal: true,
                    buttons: {                     
                        '<%= GetSystemText("OK") %>': function () { $(this).dialog('close'); }
                    }
                });
            }

            function showRemoveDialog() {
                var listItems = [];
                
                var grid = $find('ctrPlanSearch_ctrPlanningStyle_RadGridStyles');
                if (grid != null) {
                    var selectedItems = grid.get_masterTableView().get_selectedItems();
                    for (var i = 0, len = selectedItems.length; i < len; i++) {
                        listItems.push('<li><div class="img-cont">' + selectedItems[i].getDataKeyValue('Image') + '</div><span>' + selectedItems[i].getDataKeyValue('StyleNo') + '</span></li>');
                    }
                } else {
                    $("[id$='chkSelect']:checked").each(function () {
                        var td = $(this).closest("table").parent();
                        listItems.push('<li><div class="img-cont"><img src="' + td.find(".imgDesign").attr("src").replace(/\?S=\d+/ig, "?S=50") + '" /></div><span>' + td.find("[id$='lblStyleNo2']").text() + '</span></li>');
                    });
                }

                if (listItems.length == 0) {
                    showAlert();
                    return false;
                }

                $("#styles-list").html(listItems.join(''));

                $("#remove-dialog").dialog({
                    title: '<%= GetSystemText("Remove Styles") %>',
                    modal: true,       
                    width: 380,
                    buttons: {
                        '<%= GetSystemText("Yes") %>': function () { <%= ClientScript.GetPostBackEventReference(btnRemove, "") %>; },
                        '<%= GetSystemText("No") %>': function () { $(this).dialog('close'); }
                    }
                });

                return false;
            }

            /*** data from local storage for Service Bus and REST API call ***/
            function supportsStorage() {
                try {
                    return 'localStorage' in window && window['localStorage'] !== null;
                } catch (e) {
                    return false;
                }
            };

            var userData;
            if (supportsStorage()) {
                userData = localStorage.getItem("Yunique.User");
            }else{
                userData = sessionStorage.getItem("Yunique.User");
            }

            if (userData) {
                userData = $.parseJSON(userData);
                $("#hdnPLMUserName").val(userData["UserName"]);
                $("#hdnPLMPassword").val(userData["Password"]);
                $("#hdnWSClientID").val(userData["WebServiceClientID"]);
                $("#hdnWSClientPassword").val(userData["WebServiceClientPassword"]);
            }
            /******************************************************/

        </script>
        </form>
        <script type="text/javascript" language="javascript">
            $(window).load(function () {
                if (window.location.href.indexOf("TB=2") > -1) {
                    $("[id$=Datalist1] br").remove();
                    $("[id$=Datalist1] > span").wrap("<div></div>");
                    var divWidth = $("[id$=Datalist1] > div").first().width();
                    $("[id$=Datalist1] > div").css("float", "left");
                    $("[id$=Datalist1] > div").width(divWidth);

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
                }

                var divHeight = 0;
                $("[id$=Datalist1] > div").each(function () {
                    divHeight = Math.max(divHeight, $(this).height());
                });
                $("[id$=Datalist1] > div").height(divHeight);
                var hrefs = document.getElementsByTagName("a");
                var ifSilh = <%= strTab %>
                for(var i = 0; i < hrefs.length; i++){
                    var ref = hrefs.item(i);
                    if (ref.id.indexOf("_nav_") != -1){
                        ref.href = ref.href + "&TB=" + ifSilh
                        
                    }
                }
                var hrefs2 = document.getElementsByTagName("a");
                var nodesList = "";
                for (var j = 0; j < hrefs2.length; j++) {
                    var ref2 = hrefs2.item(j);
                    if (nodesList == "") {
                        if (ref2.id.indexOf("_nav_") != -1) {
                            var tmpList = "";
                            tmpList = ref2.href.substr(ref2.href.indexOf("Planning_Folder_DevelopmentTracker.aspx?"))
                            tmpList = tmpList.replace("Planning_Folder_DevelopmentTracker.aspx?", "");
                            var tmpInd = tmpList.indexOf("&PLID");
                            tmpList = tmpList.substring(0, tmpInd);
                            nodesList = tmpList;
                            break;
                        }
                    }

                }
                for (var k = 0; k < hrefs2.length; k++) {
                    var ref3 = hrefs2.item(k);
                    itemClass = ref3.getAttribute("class");
                    if (itemClass != null) {
                        if (itemClass.indexOf("TreeView") != -1 && ref3.id != "tv_1") {
                            ref3.href = ref3.href + "&" + nodesList;
                        }
                        if (ref.id == "tv_1") {
                            ref.href = ref.href.replace("&MC=1", "&MC=0")
                        }
                    }

                }
            });
        </script>
	</body>
</HTML>
