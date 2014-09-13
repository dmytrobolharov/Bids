<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_List_Search.aspx.vb" Inherits="plmOnApp.Style_List_Search" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_List_Image" Src="Style_List_Image.ascx" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style Search</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
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
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
		<asp:Panel runat="server" ID="pnlPerm" Visible=false>
				<table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
					<tr>
						<td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" 
                                        Text="You might not have permission to access user groups using your credentials." 
                                        CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                          </td>
                      </tr>
                  </table>			
			</asp:Panel>
			
			<asp:Panel runat="server" ID="pnlMain">
			<table class='<%= GetTableHeaderClass() %>' id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
							Height="0px"></asp:imagebutton>
						<cc1:bwimagebutton id="btnNew" runat="server" Message="NONE" ></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnSaveSearch" runat="server" Message="NONE" AutoPostBack="TRUE" ></cc1:confirmedimagebutton>
                        <cc1:bwimagebutton id="btnCopy" runat="server" Message="NONE"></cc1:bwimagebutton>
						<cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE"
							Visible="False"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table id="Table4" style="BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				    <tr>
					    <td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Folder...</asp:label></td>
				    </tr>
			</table>
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

                parent.frames[0].MenuRefresh();

            });

        </script>

        <script type="text/javascript" language="javascript">
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
	</body>
</html>
