<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Page_Style.aspx.vb" Inherits="plmOnApp.Sourcing_Page_Style" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Sourcing_PageStyle_List_Image" Src="Sourcing_Page_Style_List_Image.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="Sourcing_Header.ascx" TagName="Sourcing_Header" TagPrefix="hc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

        <style type="text/css">
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }
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
        </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="imgbtnSearch">
    <table class="TableHeader" id="Table2" cellSpacing="0" cellpadding="0" width="100%" border="0"
		runat="server">
		<tr valign="middle">
			<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
			<td>
                <cc1:BWImageButton id="btnAddStyle" runat="server" Message="NONE" AutoPostBack="TRUE" ></cc1:BWImageButton>
				<cc1:BWImageButton id="btnRemoveStyle" runat="server"  Message="NONE"></cc1:BWImageButton>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" Message="NONE"></cc1:BWImageButton>
            </td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		<tr>
			<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large" ForeColor="#E0E0E0"></asp:Label></td>
		</tr>
	</table>
    <table class="TableHeader CollapsibleHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td>
               <div>
                  <hc1:sourcing_header id="Sourcing_Header" runat="server"></hc1:sourcing_header>
               </div>
            </td>            
        </tr>
    </table>   

    <!-- For comments ASCX, if there will be one -->

    <asp:Panel runat="server" ID="pnlMain">
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

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

			<asp:PlaceHolder id="phStyle" runat="server"></asp:PlaceHolder>
			<asp:PlaceHolder id="phStyleGrid" runat="server"></asp:PlaceHolder>

            <input id="hiddenSearchSQL" type="hidden" value="" name="hiddenSearchSQL" runat="server" />
            </asp:Panel>

    </form>
    <script type="text/javascript">
        function toggleSectionVisibility(sender) {            
            var hdnCollapsibleStatus = $(sender).siblings("input[id*='hdnIsExpanded']");

            if (collapsibleDiv != null) {
                // Saving status of collapsed section to hidden field
                if ($(collapsibleDiv).is(":visible")) {
                    $(collapsibleDiv).hide();
                    sender.src = '../System/Icons/icon_Next.gif'
                    if ($(hdnCollapsibleStatus)[0] != null) {
                        hdnCollapsibleStatus.val("false");
                    }
                } else {
                    $(collapsibleDiv).show();
                    sender.src = '../System/Icons/icon_Down.gif'
                    if ($(hdnCollapsibleStatus)[0] != null) {
                        hdnCollapsibleStatus.val("true");
                    }
                }
            }

            return false;
        }
        

        function ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("ctrGrid_RadGridStyles").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('ctrGrid_RadGridStyles', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function ColumnShown(sender, eventArgs) {
            var tableColumns = $find("ctrGrid_RadGridStyles").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('ctrGrid_RadGridStyles', '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

    </script>

    <script type="text/javascript" language="javascript">
        $(window).load(function () {
            if (window.location.href.indexOf("TB=T") > -1) {
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
        });
        </script>
</body>
</html>
