<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_FlashEdit_Image.aspx.vb"
    Inherits="plmOnApp.Planning_FlashEdit_Image" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register Src="../System/Control/WaitControl.ascx" TagName="Color_Wait" TagPrefix="wc1" %>
<%@ Register Src="Planning_Header.ascx" TagName="Header" TagPrefix="hc1" %>
<%@ Register Src="Planning_Folder_FlashEdit_Style.ascx" TagName="Plan" TagPrefix="lc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title runat="server" id="pgTitle">Flash Edit Image</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
<style type="text/css">
    .StyleDiv { display: inline !imporant; }
</style>   
<![endif]-->
<style type="text/css">
    .marginCLS { margin-right: 3px; }
</style> 
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
        <ClientEvents OnRequestStart="" OnResponseEnd="onAjaxResponseEnd" />
        <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnSave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadAjaxPanelStyle" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadAjaxPanelStyle">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadAjaxPanelStyle" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
    </telerik:RadAjaxManager>
    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnInfo" runat="server" Message="NONE" CausesValidation="false"
                    OnClientClick="javascript:showHeader();return false;" />
                <cc1:BWImageButton ID="imgBtnNew" runat="server"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" CausesValidation="false">
                </cc1:ConfirmedImageButton>
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
                            <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
                                height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                                <tr>
                                    <td>
                                        &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                                            Font-Names="Tahoma,Verdana">Line List Folder...</asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <asp:PlaceHolder ID="phSearch" runat="server" Visible="false"></asp:PlaceHolder>
                            <lc1:Plan ID="ctrPlanSearch" runat="server"></lc1:Plan>
                        </div>
                    </telerik:RadAjaxPanel>
                </div>
            </td>
            <td width="40%" valign="top">
                <div style="overflow: auto; width: 100%; height: 900px;" id="scrollDiv2">
                    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel2" ClientEvents-OnRequestStart=""
                        ClientEvents-OnResponseEnd="" Width="98%">
                            <div style="width: 97%; height: 100%" class="inner">
                                <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
                                    height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                                    <tr>
                                        <td>
                                            &nbsp;<asp:Label ID="lblHeaderImage" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                                                Font-Names="Tahoma,Verdana">Image Folder</asp:Label>
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
                                <table class="TableHeader" id="Table2" height="20" cellspacing="0" cellpadding="0"
                                    width="100%" border="0">
                                    <tr class="fontHead">
                                        <td align="center" width="10" height="25">
                                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                        </td>
                                        <td height="25">
                                            <div align="left">
                                                &nbsp;
                                                <asp:Label ID="lblCurrentIndex" runat="server" Visible="False" Text="0"></asp:Label></div>
                                        </td>
                                        <td width="20" height="25">
                                            <div align="center">
                                                <asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif">
                                                </asp:ImageButton></div>
                                        </td>
                                        <td width="20" height="25">
                                            <div align="center">
                                                <asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif">
                                                </asp:ImageButton></div>
                                        </td>
                                        <td width="125" height="25">
                                            <div align="center">
                                                <asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div>
                                        </td>
                                        <td width="20" height="25">
                                            <div align="center">
                                                <asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif">
                                                </asp:ImageButton></div>
                                        </td>
                                        <td width="20" height="25">
                                            <div align="center">
                                                <asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif">
                                                </asp:ImageButton></div>
                                        </td>
                                        <td height="25">
                                            <div align="left">
                                                <b>
                                                    <asp:Label ID="lblRecordCount" runat="server" Visible="true"></asp:Label>&nbsp;
                                                    <asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label>
                                                </b>
                                            </div>
                                        </td>
                                        <td width="25">
                                            <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                <asp:ListItem Value="10">10</asp:ListItem>
                                                <asp:ListItem Value="12" Selected="true">12</asp:ListItem>
                                                <asp:ListItem Value="15">15</asp:ListItem>
                                                <asp:ListItem Value="20">20</asp:ListItem>
                                                <asp:ListItem Value="25">25</asp:ListItem>
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
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <!---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
                                <table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0">
                                    <tr>
                                        <td valign="top">
                                            <asp:DataList ID="Datalist2" runat="server" EnableViewState="true" RepeatDirection="Horizontal"
                                                RepeatLayout="Flow" DataKeyField="ImageId">
                                                <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
                                                    VerticalAlign="Top" BackColor="White" CssClass="marginCLS" ></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemTemplate>
                                                    <table id="tbItem" runat="server" bordercolor='#CCCCCC' border="1" cellpadding="0"
                                                        width="300px" cellspacing="0"  style="table-layout:fixed;">
                                                        <tr height='<%#ImageWidth%>' width="100%">
                                                            <td width="<%#ImageWidth%>" class="<%#draggableClass%>" align="center">
                                                                <asp:Image ID="imgDesign" runat="server" />
                                                                <asp:Label ID="lblEdit" runat="server"></asp:Label>
                                                                <input type="hidden" id="txtImageVersion" runat="server" />
                                                                <input type="hidden" id="txtImageId" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"ImageID")%>' />
                                                                <input type="hidden" id="txtImageFileName" runat="server" />
                                                            </td>
                                                            <td valign="top">
                                                                <asp:PlaceHolder ID="pnlHeader" runat="server"></asp:PlaceHolder>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </td>
                                    </tr>
                                </table>
                                <input id="imageSize" type="hidden" runat="server">
                            </div>
                        </telerik:RadAjaxPanel>
                </div>
            </td>
        </tr>
    </table>
    <!--
</td>
</tr>


</table>-->
    <div id="headerModal" style="display: none;">
        <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td width="100%">
                    <hc1:Header ID="PlanHeader" runat="server"></hc1:Header>
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
    </form>
    <script language="javascript" type="text/javascript" src="../System/Jscript/underscore-min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/System.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/colResizable-1.3.min.js"></script>
    <script src="../System/Jscript/jquery.ui.core.js"></script>
    <script src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>
    <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">



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

        $(document).resize(function () { setSize(); });

        function setSize() {

            //$('*[id*="tbItem"]').parent().css('display', 'block');
            //$('*[id*="Datalist1"]').find('.TableHeader').hide();

//            $('.StyleDiv').each(function () {

//                $(this).find('#designImage').closest('td').append($(this).find('#removebtn').closest('div'));
//                $(this).find('#designImage').closest('td').append($(this).find('#gotobtn').closest('div'));
//            });

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
                width: 875,
                title: '<%= GetSystemText("Planning") %>'

            });
            $("#headerExp").hide();
            $("#divHeaderContent").show();
            $confirmDialog.dialog('open');
            return false;
        }

        function hasPendingChanges() {
            var changes = _.pluck($("input[id*='hdnNewImageID']"), "value");

            return _.chain(changes).compact().some().value();
        };

        (function(){
            var buttonsToConfirm = ["ctrPlanSearch$imgBtnSearch", "ctrPlanSearch$ctrPlanning$btnRepage", "ctrPlanSearch$ctrPlanning$btnImgNext", 
                                    "ctrPlanSearch$ctrPlanning$btnImgPrevious", "ctrPlanSearch$ctrPlanning$btnImgLast", "ctrPlanSearch$ctrPlanning$btnImgFirst"],
                confirmed = false;

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
                        '<%= GetSystemText("Yes") %>': function() { sendWithArgs("SAVE"); },
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
                            '<%= GetSystemText("Yes") %>': function() { <%= ClientScript.GetPostBackEventReference(btnClose, "SAVE") %>; },
                            '<%= GetSystemText("No") %>': function() { <%= ClientScript.GetPostBackEventReference(btnClose, "") %>; }
                        }
                    });

                    e.preventDefault();
                }
            });
        })();

        function onAjaxResponseEnd(sender, eventArgs) {

            // Clearing the EVENTTARGET and EVENTARGUMENT from ajax postback, so we can verify if the next postback was caused by button or by the same control
            form1.__EVENTTARGET.value = ''
            form1.__EVENTARGUMENT.value = ''
            $("input[id*='hdnNewImageID']").val("");
        }

        function removeImage(obj) {
            var stylePanel = $(obj).closest(".droppable");

            var imageId = '00000000-0000-0000-0000-000000000000'
            var imageVersion = 0
            var imageSrc = stylePanel.find("#designImage").attr("src")
            var imageIdPos = imageSrc.indexOf("&IID=") + 5;
            
            imageSrc = imageSrc.replace(imageSrc.substring(imageIdPos, imageIdPos + 36), imageId);
            //imageSrc = imageSrc.replace("&S=200", "&S=100")

            // Changing style picture on the screen
             stylePanel.find("#designImage").attr("src", imageSrc);
            // Storing image info for back-end processing on save
            stylePanel.find("input[id*='hdnNewImageID']").val(imageId);
            stylePanel.find("input[id*='hdnNewImageVersion']").val(imageVersion);

            stylePanel.find('*[id*="lblAlias"]:first').css("color", "red");
            stylePanel.find('*[id*="lblStyleNo"]').css("color", "red");
        }

        function reloadImages() {
            <%= ClientScript.GetPostBackEventReference(RadAjaxPanel2, "") %>;
        }
    </script>
    <script language="javascript" type="text/javascript">
// <![CDATA[
        Sys.Application.add_load(WireEvents); // fix wiring for .NET ajax updatepanel
        $(WireEvents); // handle page load wiring using jquery. This will fire on page load


        function WireEvents() {

            $(function () {
                $(".draggable").draggable({
                    helper: 'clone',
                    snap: '.ui-droppable',
                    snapMode: 'outer'
                });

                $("#imgBtnCol").hide();
                setSize();

                $(".droppable").droppable({
                    accept: '.draggable',
                    tolerance: 'intersect',
                    drop: function (event, ui) {

                        var imageId = $(ui.draggable).find("input[id*='txtImageId']").val();
                        var imageVersion = $(ui.draggable).find("input[id*='txtImageVersion']").val();
                        var imageSrc = $(ui.draggable).find("img[id*='imgDesign']").attr("src");

                        // Changing style picture on the screen
                        $(this).find("#designImage").attr("src", imageSrc.replace("&S=100", "&S=200"));
                        // Storing image info for back-end processing on save
                        $(this).find("input[id*='hdnNewImageID']").val(imageId);
                        $(this).find("input[id*='hdnNewImageVersion']").val(imageVersion);

                        $(this).find('*[id*="lblAlias"]:first').css("color", "red");
                        $(this).find('*[id*="lblStyleNo"]').css("color", "red");
                    }
                });

            });
        };

        
// ]]>
    </script>
    <style type="text/css">
        .StyleDiv
        {
            width: 200px;
        }
    </style>
</body>
</html>
