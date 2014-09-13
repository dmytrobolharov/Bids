<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Line_List_PlanningAllocation.aspx.vb" Inherits="plmOnApp.Line_List_PlanningAllocation" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<%@ Register Src="Line_List_Header.ascx" TagName="Header" TagPrefix="hc1" %>
<%@ Register Src="Line_List_Folder_FlashEdit_Style.ascx" TagName="List" TagPrefix="lc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title runat="server" id="pgTitle">Style Allocation</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .StyleDiv {
            width: 200px;
        }
        
        .drag-helper {        	
        	background-color: #fff;
        }
        
        .style-new {
        	display: inline-block;
        }
        
        .style-info td {
        	border: 1px solid Gainsboro;
        	white-space: nowrap;
        }        
        
        .style-new .style-info .font {
        	color: #f00;
        }
    </style>
    <!--[if lt IE 9]>
    <style type="text/css">
        .StyleDiv { display: inline !imporant; }
    </style>   
    <![endif]-->
</head>
<body>
    <form id="form1" runat="server">
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
        <ClientEvents OnResponseEnd="onAjaxResponseEnd" />
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadAjaxPanelStyle" />
                    <telerik:AjaxUpdatedControl ControlID="RadAjaxPanel2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadAjaxPanelStyle">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadAjaxPanelStyle" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE" OnClientClick="return addSelectedStyles()" />
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE" OnClientClick="return removeSelectedStyles()" />
                <cc1:ConfirmedImageButton ID="btnInfo" runat="server" Message="NONE" CausesValidation="false" OnClientClick="javascript:showHeader();return false;" />                
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false"></cc1:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table id="resizableTable" valign="top">
        <tr>
            <td width="60%" valign="top">
                <div style="overflow: scroll; width: 100%; height: 100%;" id="scrollDiv1">
                    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelStyle" ClientEvents-OnRequestStart="onAjaxRequestStart"
                        ClientEvents-OnResponseEnd="" Width="98%">
                        <div style="width: 100%; height: 100%" class="inner">
                            <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
                                cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                                <tr>
                                    <td>
                                        &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line List Folder...</asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <asp:PlaceHolder ID="phSearch" runat="server" Visible="false"></asp:PlaceHolder>
                            <lc1:List ID="ctrLineSearch" runat="server"></lc1:List>
                        </div>
                    </telerik:RadAjaxPanel>
                </div>
            </td>
            <td width="40%" valign="top">
                <div style="overflow: auto; width: 100%; height: 900px;" id="scrollDiv2">
                    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel2" ClientEvents-OnRequestStart="" ClientEvents-OnResponseEnd=""
                        Width="98%">
                        <div style="width: 97%; height: 100%" class="inner">
                            <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
                                cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                                <tr>
                                    <td>
                                        &nbsp;<asp:Label ID="lblHeaderStyle" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Folder</asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                                <tr>
                                    <td>
                                        <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                                    </td>
                                    <td valign="top" width="100%">
                                        <table id="Table3" height="45">
                                            <tr>
                                                <td>
                                                    <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr valign="top">
                                    <td>
                                        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                                            border="0">
                                            <tr valign="middle">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                </td>
                                                <td width="16">
                                                    <asp:CheckBox ID="cbThumbnail" runat="server" AutoPostBack="True"></asp:CheckBox>
                                                </td>
                                                <td class="fontHead" width="85">
                                                    <asp:Label ID="lblThumbnail" runat="server" Text="Thumbnail?"></asp:Label>
                                                </td>
                                                <td width="20">
                                                    <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
                                                </td>
                                                <td width="20">
                                                    <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
                                                </td>
                                                <td nowrap align="center" width="110">
                                                    <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                                                </td>
                                                <td width="20">
                                                    <asp:ImageButton ID="btnImgNext" runat="server"></asp:ImageButton>
                                                </td>
                                                <td width="20">
                                                    <asp:ImageButton ID="btnImgLast" runat="server"></asp:ImageButton>
                                                </td>
                                                <td width="10">
                                                    &nbsp;
                                                </td>
                                                <td nowrap>
                                                    <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
                                                </td>
                                                <td width="25">
                                                    <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                                                        <asp:ListItem Value="5">5</asp:ListItem>
                                                        <asp:ListItem Value="10">10</asp:ListItem>
                                                        <asp:ListItem Value="12">12</asp:ListItem>
                                                        <asp:ListItem Value="15">15</asp:ListItem>
                                                        <asp:ListItem Value="20">20</asp:ListItem>
                                                        <asp:ListItem Value="25" Selected="true">25</asp:ListItem>
                                                        <asp:ListItem Value="30">30</asp:ListItem>
                                                        <asp:ListItem Value="40">40</asp:ListItem>
                                                        <asp:ListItem Value="50">50</asp:ListItem>
                                                        <asp:ListItem Value="75">75</asp:ListItem>
                                                        <asp:ListItem Value="100">100</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="10">
                                                    <asp:Button ID="btnRepage" runat="server" CssClass="fontHead"></asp:Button>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="PlanningItemID">
                                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate draggable"></AlternatingItemStyle>
                                            <ItemStyle CssClass="ItemTemplate draggable"></ItemStyle>
                                            <HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
                                            <PagerStyle Visible="False"></PagerStyle>
                                            <Columns>
                                                <asp:TemplateColumn ItemStyle-BorderColor="Gainsboro" ItemStyle-BorderWidth="1" ItemStyle-CssClass="font">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkSelectAll" runat="server" onclick="checkAll(this)" />                                                        
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" />                                                                                                               
                                                        <span class="drag-helper" style="display: none;">
                                                            <asp:HiddenField ID="hdnPlanningItemID" runat="server" Value='<%# Eval("PlanningItemId") %>' />
                                                            <table cellpadding="0" cellspacing="0" style="border: 1px solid Gainsboro;">
                                                                <tr>
                                                                    <td>
                                                                        <div style="width:200px; height: 200px;">
                                                                            <input type="checkbox" class="remove-style" /><br />
                                                                            <img src='<%# GetImageStreamPath(ImageWidth, Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>' alt="" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="style-info">
                                                                        <asp:PlaceHolder ID="phControls" runat="server"></asp:PlaceHolder>
                                                                    </td>
                                                                </tr>
                                                            </table>                                                            
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn ItemStyle-BorderColor="Gainsboro" ItemStyle-BorderWidth="1" ItemStyle-CssClass="font">
                                                    <HeaderTemplate>
                                                        <%# GetSystemText("Image")%>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <img src='<%# GetImageStreamPath("50", Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>'
                                                            alt="" />
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <input id="imageSize" type="hidden" runat="server" />
                        </div>
                    </telerik:RadAjaxPanel>
                </div>
            </td>
        </tr>
    </table>

    <div id="headerModal" style="display: none;">
        <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td width="100%">
                    <hc1:Header ID="LineHeader" runat="server"></hc1:Header>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
        <div id="confirm-dialog" style="display: none;">
            <%= GetSystemText("There are pending changes. Save before continuing?")%></div>
    </telerik:RadCodeBlock>

    <input type="hidden" id="hdnPlanningItems" runat="server" />    
    </form>
    <script language="javascript" type="text/javascript" src="../System/Jscript/underscore-min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/System.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/colResizable-1.3.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.ui.core.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>    
    <script type="text/javascript">

        function checkAll(chkSelectAll) {
            $("#DataGrid1 [id*='chkSelect']").attr("checked", chkSelectAll.checked);
        }

        /* Make GridArea div to take all the free height on the window, but no more */
        $(document).ready(function () {            
            $("#scrollDiv1").height($(window).height() - 10 - 27);
            $("#scrollDiv2").height($(window).height() - 10 - 27).scrollLeft(0);

            $("#resizableTable").height($(window).height() - 3 - 27);

            setSize();
            $("#resizableTable").colResizable({
                liveDrag: true,
                minWidth: 200
            });            
        });

        $(document).resize(setSize);

        function setSize() {            
            $('*[id*="Datalist1"]').find('.TableHeader').hide();

            $('.StyleDiv').each(function () {
                $(this).find('#designImage').closest('td').append($(this).find('#gotobtn').closest('div'));
            });

            $('.StyleDiv').find('table').css('border-color', 'gray');
            $('.StyleDiv').find('tbody').css('border-color', 'gainsboro');
            $('*[id*="hdr_lblImageID"]').closest('tr').hide();

            $('.droppable').find('td').attr('noWrap', 'noWrap');
        }

        function showHeader() {
            var $confirmDialog = $("#headerModal");
            
            $confirmDialog.dialog({
                autoOpen: false,
                modal: true,
                resizable: false,
                height: 350,
                width: 700,
                title: '<%= GetSystemText("Line List") %>'

            });
            $("#headerExp").hide();
            $("#divHeaderContent").show();
            $confirmDialog.dialog('open');
            return false;
        }

        function hasPendingChanges() {
            var changes = _.compact($("input[id*='hdnPlanningItems']").val().split(','));

            return _.chain(changes).compact().some().value();
        };

        (function(){
            var buttonsToConfirm = ["ctrLineSearch$imgBtnSearch", "ctrLineSearch$ctrLineFolder$btnRepage", "ctrLineSearch$ctrLineFolder$btnImgNext", 
                                    "ctrLineSearch$ctrLineFolder$btnImgPrevious", "ctrLineSearch$ctrLineFolder$btnImgLast", "ctrLineSearch$ctrLineFolder$btnImgFirst"],
                confirmed = false,
                queue = [];

            window.onAjaxRequestStart = function(sender, eventArgs) {                  
                // if confirmed request or nonconfirmable button or no pending changes then proceed as is                          
                if (confirmed || _.indexOf(buttonsToConfirm, eventArgs.get_eventTarget()) == -1 || !hasPendingChanges()) {
                    confirmed = false;
                    return true;
                }

                function sendWithArgs(args) {
                    confirmed = true;
                    sender.ajaxRequestWithTarget(eventArgs.get_eventTarget(), args);
                    $("#confirm-dialog").dialog('close');
                }

                $("#confirm-dialog").dialog({
                    title: '<%= GetSystemText("Save pending changes before proceeding?") %>',
                    width: '400px',
                    resizable: false,
                    modal: true,
                    buttons: {
                        '<%= GetSystemText("Yes") %>': function() { 
                            sendWithArgs("SAVE-STYLES"); 
                            queue.push(function () { $find("RadAjaxPanel2").ajaxRequest(""); }); 
                        },
                        '<%= GetSystemText("No") %>': function() { sendWithArgs(""); }
                    }
                });

                eventArgs.set_cancel(true);
            }

            $("#btnClose").click(function(e) {
                if (hasPendingChanges()) {
                    $("#confirm-dialog").dialog({
                        title: '<%= GetSystemText("Save pending changes before proceeding?") %>',
                        width: '400px',
                        resizable: false,
                        modal: true,
                        buttons: {
                            '<%= GetSystemText("Yes") %>': function() { <%= ClientScript.GetPostBackEventReference(btnClose, "SAVE-STYLES") %>; },
                            '<%= GetSystemText("No") %>': function() { <%= ClientScript.GetPostBackEventReference(btnClose, "") %>; }
                        }
                    });

                    e.preventDefault();
                }
            });

            window.onAjaxResponseEnd = function(sender, eventArgs) {
                // Clearing the EVENTTARGET and EVENTARGUMENT from ajax postback, so we can verify if the next postback was caused by button or by the same control
                form1.__EVENTTARGET.value = ''
                form1.__EVENTARGUMENT.value = ''
                $("input[id*='hdnPlanningItems']").val("");

                var fn;
                while (fn = queue.pop()) {
                    fn();
                }
            }
        })();        

    </script>
    <script language="javascript" type="text/javascript">
// <![CDATA[
        Sys.Application.add_load(WireEvents); // fix wiring for .NET ajax updatepanel
        $(WireEvents); // handle page load wiring using jquery. This will fire on page load

        var $hdnPlanningItems = $("#hdnPlanningItems");        

        function addPlanningItem(planningItemId, elem) {
            var planningItems = $hdnPlanningItems.val().split(','),
                planningItemsBefore = $hdnPlanningItems.val().length;

            planningItems.push(planningItemId);
            $hdnPlanningItems.val(_.unique(_.compact(planningItems)).join(','));

            var planningItemsAfter = $hdnPlanningItems.val().length

            if (planningItemsBefore != planningItemsAfter) {
                elem.find(".style-info td")
                    .css("width", "auto")
                    .attr("nowrap", "nowrap");
                elem.find("input[id*='hdnPlanningItemID']").each(function () {
                    if (this.id != null && this.id != "") {
                        this.id = "tmp_" + this.id + planningItemId;
                        this.name = "tmp$" + this.id  + planningItemId;
                    }
                });
                $("#style-list-container > span").append(elem.addClass("style-new").css("display", "inline-block").addClass("StyleDiv"));
                hideShowStylesInPalette();
            }
        }

        function removePlanningItem(planningItemId) {
            var planningItems = $hdnPlanningItems.val().split(',');
            $hdnPlanningItems.val(_.without(planningItems, planningItemId).join(','));
            hideShowStylesInPalette();
        }

        function hideShowStylesInPalette() {
            $("#DataGrid1 [id*='hdnPlanningItemID']").each(function () {
                if (($hdnPlanningItems.val().indexOf($(this).val()) != -1) && !($(this).closest(".drag-helper").hasClass("ui-draggable-dragging"))) {
                    $(this).closest("tr").hide();
                }
                if ($hdnPlanningItems.val().indexOf($(this).val()) == -1) {
                    $(this).closest("tr").show();
                }
            });
        }

        function addSelectedStyles() {
            $("#DataGrid1 [id*=chkSelect]:checked")
                .parent()
                .find("[id*=hdnPlanningItemID]")
                .each(function () {
                    addPlanningItem(this.value, $(this).closest("td").find(".drag-helper").clone());
                });

            return false;
        }

        function removeSelectedStyles() {
            $("#style-list-container .remove-style:checked").each(function () {
                removePlanningItem($(this).closest(".StyleDiv").find("[id*=hdnPlanningItemID]").val())
                $(this).closest(".StyleDiv").remove();
            });

            return false;
        }

        function WireEvents() {

            if (!$("#style-list-container > span").length) {
                $("#style-list-container").append($("<span></span>").css({ display: "inline-block", width: "100%" }));
            }

            $(function () {
                $(".draggable").draggable({
                    helper: function () {
                        return $(this).find('.drag-helper')
                                .clone().css("display", "inline-block");
                    },
                    snap: '.ui-droppable',
                    snapMode: 'outer'
                });

                $("#imgBtnCol").hide();
                setSize();

                $("#scrollDiv1").droppable({
                    accept: '.draggable',
                    tolerance: 'intersect',
                    drop: function (event, ui) {                        
                        var planningItemID = $(ui.draggable).find("input[id*='hdnPlanningItemID']").val();
                        addPlanningItem(planningItemID, $(ui.draggable).find('.drag-helper').clone());
                    }
                });

            });

            //set for styles which are in Style palette the same height as linelist styles
            var heightLineStyles = $("#style-list-container span span:first").height();
            if (heightLineStyles != null) {
                $(".drag-helper").children('table').height(heightLineStyles)
            }

            hideShowStylesInPalette();
        };
// ]]>
    </script>    
</body>
</html>
