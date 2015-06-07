<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Planning_Folder_Color_Import.aspx.vb" Inherits="plmOnApp.Planning_Folder_Color_Import" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Color Import</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
            .EmptyItemTemplate {display: none;}
            #tblSearch td {vertical-align: top;}
        </style>
	</head>
	<body style="background-color: White;">
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
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
                <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            </StyleSheets>
            <CdnSettings TelerikCdn="Disabled" />
        </telerik:RadStyleSheetManager>

        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            <ClientEvents OnRequestStart="onAjaxRequestStart"/>
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnSave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadAjaxPanelMain" />
                        <telerik:AjaxUpdatedControl ControlID="RadAjaxPanelColor" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" height="30px">
		    <tr valign="middle">
				<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
				<td>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />			
                    <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE" />
                    <asp:ImageButton id="btnAdd" runat="server" OnClientClick="addSelectedColors(); return false;" />
					<%--<asp:ImageButton id="btnRemove" runat="server" OnClientClick="removeColorwaysFromExisting(); return false;" /--%>
				    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" />
                </td>     
		    </tr>
        </table>

        <table id="resizableTable" width="100%">
            <tr valign="top">
                <td width="65%" id="scrollTD1">
                <!-- Left frame-->
                    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelMain" ClientEvents-OnRequestStart="onAjaxRequestStart" ClientEvents-OnResponseEnd="onAjaxResponseEnd" Width="100%" Height="100%">
                        <div style="width:100%; height:100%; vertical-align: top;" id="ExistingList" class="inner">
			                <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				                height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				                <tr>
					                <td>&nbsp;<asp:label id="lblExistingColors" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line Plan Folder...</asp:label></td>
				                </tr>
			                </table>

                            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				                <tr>
					                <td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					                <td style="vertical-align:middle;" width="100%"><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
				                </tr>
			                </table>	

			                <table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
				                <tr class="fontHead">
					                <td align="center" width="10" height="25"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                    <%--<td width="100" runat="server"><input id="chkSelectExisting" type="checkbox" onclick="CheckAllExisting(this)" /><%=GetSystemText("Select All")%></td>--%>
					                <td height="25"><div align="left">&nbsp;<asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label></div></td>
					                <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div></td>
					                <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>					                </td>
					                <td width="125" height="25"><div align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></div></td>
					                <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div></td>
					                <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div></td>
					                <td height="25"><div align="left"><b><asp:label id="lblRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;</b></div></td>
								    <td width="25" valign="bottom">
								        <asp:dropdownlist id="ps_existing" runat="server" CssClass="fontHead">
										    <asp:ListItem Value="5">5</asp:ListItem>
										    <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="12">12</asp:ListItem>
										    <asp:ListItem Value="15" Selected="True">15</asp:ListItem>
										    <asp:ListItem Value="20">20</asp:ListItem>
										    <asp:ListItem Value="25">25</asp:ListItem>
										    <asp:ListItem Value="30">30</asp:ListItem>
										    <asp:ListItem Value="40">40</asp:ListItem>
										    <asp:ListItem Value="50">50</asp:ListItem>
									    </asp:dropdownlist>
								    </td>
                                    <td width="10"><asp:button id="btnRepageExisting" runat="server" CssClass="fontHead"></asp:button></td>
				                </tr>
			                </table>			            				
					
			                <table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0">
				                <tr>
					                <td valign="top" class="droppable">
                                        <asp:HiddenField ID="hdnAddedColors" runat="server" />
                                        <asp:datalist id="DataListExisting" runat="server" Width="100%" style="overflow:auto;" RepeatDirection="Horizontal" RepeatLayout="Flow" EnableViewState="True" DataKeyField="ColorPaletteID">
	                                        <ItemStyle BorderWidth="1px" BorderStyle="Solid" BackColor="white" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
	                                        <ItemTemplate>
                                                <table width="170px">
                                                    <tr><td><asp:Label ID="lblMessage" runat="server"></asp:Label></td></tr>
                                                    <tr>
                                                        <td>
		                                                    <asp:Label align="left" ID="colorChip" runat="server" style="display:block;"></asp:Label>
		                                                    <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
		                                                    <br/>
                                                        </td>
                                                    </tr>
                                                </table>
	                                        </ItemTemplate>
                                        </asp:datalist>
                                    </td>
				                </tr>
			                </table>
			                <input id="imageSize" type="hidden" runat="server" />
                        </div>
                    </telerik:RadAjaxPanel>
                </td>

                <td width="35%">
                <!-- Right frame -->
                    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelColor" ClientEvents-OnRequestStart="" ClientEvents-OnResponseEnd="" Width="100%" Height="100%">
                        <div style="width:100%; height:100%;" id="ColorList" class="inner">
			                <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				                height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				                <tr>
					                <td>&nbsp;<asp:label id="lblColorsHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line Plan Folder...</asp:label></td>
				                </tr>
			                </table>

                            <!-- Color folder navigation -->

                            <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				                <tr>
                                    <td><asp:placeholder id="plhColorSearchControls" runat="server" EnableViewState="False"></asp:placeholder></td>
					                <td width="100%" valign="middle"><asp:imagebutton id="imgBtnSearchColor" runat="server"></asp:imagebutton></td>
				                </tr>
			                </table>  

			                <table class="TableHeader" height="20" cellSpacing="0" cellPadding="0" width="100%" border="0">
				                <tr class="fontHead">
					                <td align="center" width="10" height="25"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                    <td id="Td1" width="100" runat="server"><input id="chkAllColors" type="checkbox" onclick="CheckAllColors(this)" /><%=GetSystemText("Select All")%></td>
					                <td height="25"><div align="left">&nbsp;<asp:label id="lblCurrentColorIndex" Runat="server" Visible="False" Text="0"></asp:label></div></td>
					                <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgColorFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div></td>
					                <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgColorPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>					                </td>
					                <td width="125" height="25"><div align="center"><asp:label id="lblColorCounts" Runat="server" CssClass="plaintable"></asp:label></div></td>
					                <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgColorNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div></td>
					                <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgColorLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div></td>
					                <td height="25"><div align="left"><b><asp:label id="lblColorRecordCount" Runat="server" Visible="true"></asp:label>&nbsp;</b></div></td>
								    <td width="25" valign="bottom">
								        <asp:dropdownlist id="ps_color" runat="server" CssClass="fontHead">
										    <asp:ListItem Value="5">5</asp:ListItem>
										    <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="12">12</asp:ListItem>
										    <asp:ListItem Value="15" Selected="True">15</asp:ListItem>
										    <asp:ListItem Value="20">20</asp:ListItem>
										    <asp:ListItem Value="25">25</asp:ListItem>
										    <asp:ListItem Value="30">30</asp:ListItem>
										    <asp:ListItem Value="40">40</asp:ListItem>
										    <asp:ListItem Value="50">50</asp:ListItem>
									    </asp:dropdownlist>
								    </td>
                                    <td width="10"><asp:button id="btnRepageColor" runat="server" CssClass="fontHead"></asp:button></td>
				                </tr>
			                </table>	

                            <asp:datalist id="DataListColors" runat="server" EnableViewState="True" RepeatDirection="Horizontal" RepeatLayout="Flow" DataKeyField="ColorPaletteID" CellPadding="3">
					        <ItemStyle BorderWidth="1" BorderStyle="Solid" BorderColor="Gainsboro" Width="180" VerticalAlign="Top"></ItemStyle>	                            
					            <ItemTemplate>
                                    <span class="helper" style="display:none; border-top-color: gainsboro; border-right-color: gainsboro; border-bottom-color: gainsboro; border-left-color: gainsboro; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: solid; border-right-style: solid; border-bottom-style: solid; border-left-style: solid; background-color: white;" valign="top">
                                        <table width="170px">
                                            <tr><td><asp:Label ID="lblMessage" runat="server"></asp:Label></td></tr>
                                            <tr>
                                                <td>
		                                            <asp:Label align="left" ID="colorChip" runat="server" AssociatedControlID="chkSelectExisting" style="display:block;">
		                                                <asp:CheckBox ID="chkSelectExisting" runat="server" />
                                                        <asp:HiddenField ID="hdnExistingColorPaletteID" runat="server" />
                                                    </asp:Label>
		                                            <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
		                                            <br/>
                                                </td>
                                            </tr>
                                        </table>
                                    </span>
					                <TABLE height="60" width="180" cellSpacing="0" cellPadding="0" border="0" id="singleColorChip" class="draggable">
					                    <TR valign="top">
                                            <td align="center" valign="middle" width="60">
                                                <table width="50" height="50"  cellSpacing="0" cellPadding="0" border="0">
                                                    <tr>
                                                        <td valign="top" align="left" runat="server" id="tdColorImage">
                                                            <asp:label runat="server" style="width:50px; height:50px; display:block;" id="imgColorChip" AssociatedControlID="chkSelectColor" >
					                                            <asp:CheckBox ID="chkSelectColor" Runat="server"></asp:CheckBox>
                                                                <asp:HiddenField ID="hdnColorPaletteID" runat="server" />
                                                            </asp:label>
					                                    </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="middle" width="120"> 
					                            <asp:PlaceHolder ID="pnlHeader" runat="server" ></asp:PlaceHolder>
				                            </td>
					                    </TR>
					                </TABLE>
					            </ItemTemplate>
				        </asp:datalist>

                    </div>
                </telerik:RadAjaxPanel>
                </td>
            </tr>
        </table>

        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
            <div id="confirm-dialog" style="display: none;">
                <%= GetSystemText("There are pending changes. Save before continuing?")%></div>
        </telerik:RadCodeBlock>        
    </form>
        <script language="javascript" type="text/javascript" src="../System/Jscript/underscore-min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/colResizable-1.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.ui.core.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>
        <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet"></link>
        <script type="text/javascript" language="javascript">
        
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

            function BeginRequestHandler(sender, args) {
                show_wait_text();
            }

            function EndRequestHandler(sender, args) {
                hide_wait_text();
            }

            $(document).ready(function () {
                $("#DataListExisting [id*=hdr]").css("white-space", "nowrap")
                $(".helper [id*=hdr]").css("white-space", "nowrap")
                $("#resizableTable").height($(window).height() - 50);
                $("#resizableTable").colResizable({
                    liveDrag: true,
                    minWidth: 200,
                    onResize: function () {$("#DataListExisting").width($("#scrollTD1").width() - 7);}
                });
                $("#DataListExisting").width($("#scrollTD1").width() - 7);
                $("#DataListExisting").height($("#scrollTD1").height()-110)
            });

            function CheckAllColors(chkSelectAll) { $("#ColorList [id*='chkSelectColor']").attr("checked", chkSelectAll.checked); }
            function CheckAllExisting(chkSelectAll) { $("#ExistingList [id*='chkSelectExisting']").attr("checked", chkSelectAll.checked); }

            function hasPendingChanges() {return $("#hdnAddedColors").val() != ""};

            (function(){
                var buttonsToConfirm = ["imgBtnSearch", "btnRepageExisting", "btnImgNext", "btnImgPrevious", "btnImgLast", "btnImgFirst"], confirmed = false, queue = [];

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
                                sendWithArgs("SAVE");
                                queue.push(function () { $find("RadAjaxPanelColor").ajaxRequest(""); }); 
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
                                '<%= GetSystemText("Yes") %>': function() { <%= ClientScript.GetPostBackEventReference(btnClose, "SAVE") %>; },
                                '<%= GetSystemText("No") %>': function() { <%= ClientScript.GetPostBackEventReference(btnClose, "") %>; }
                            }
                        });

                        e.preventDefault();
                    }
                });

                window.onAjaxResponseEnd = function(sender, eventArgs) {

                    // Clearing the EVENTTARGET and EVENTARGUMENT from ajax postback, so we can verify if the next postback was caused by button or by the same control
                    Form1.__EVENTTARGET.value = ''
                    Form1.__EVENTARGUMENT.value = ''

                    var fn;
                    while (fn = queue.pop()) { fn(); }

                }
            })();

            Sys.Application.add_load(WireEvents); // fix wiring for .NET ajax updatepanel
            $(WireEvents); // handle page load wiring using jquery. This will fire on page load


            function WireEvents() {
                $("#DataListExisting [id*=lbl]").parent().width("50");
                $("#DataListColors .helper [id*=lbl]").parent().width("50");

                $("#DataListExisting [id*=hdr]").css("white-space", "nowrap")
                $(".helper [id*=hdr]").css("white-space", "nowrap")

                $(function () {
                    $(".draggable").draggable({
                        helper: function(){
                            return $(this).parent().find('.helper').clone().show()[0];
                        },
                        snap: '.ui-droppable',
                        snapMode: 'outer',
                        appendTo: 'body',
                        delay: 0,
                        distance: 5
                    });

                    $(".droppable").droppable({
                        accept: '.draggable',
                        tolerance: 'intersect',
                        drop: function (event, ui) {
                            var chkItem = $(ui.draggable).find("input[id*='chkSelectColor']");
                            var colorInfo = getColorInfo(chkItem);
                            addColorToExisting(colorInfo, chkItem);
                        }
                    });

                });
            };

            function getColorInfo(sender) {
                var colorInfo = { colorPaletteID: $(sender).siblings("input[id*='hdnColorPaletteID']").val() };
                return colorInfo;
            }

            function addColorForSaving(colorInfo) {

                var hdnAddedColors = $("#DataListExisting").siblings("input[id*='hdnAddedColors']");
                
                if(hdnAddedColors.length == 0){
                    return true;
                }
                var arrExistingColors = hdnAddedColors.val().split(";");

                if (_.indexOf(arrExistingColors, colorInfo.colorPaletteID) != -1) {
                    return false;
                }
                else {
                    arrExistingColors.push(colorInfo.colorPaletteID);
                    hdnAddedColors.val(_.without(arrExistingColors, "").join(";"));
                    return true;
                }

            }

//            function removeColorFromExisting(chkItem) {
//                var currentColorPaletteID = $(chkItem).siblings("input[id*='hdnExistingColorPaletteID']").val();
//                var hdnAddedColorways = $(".droppable input[id*='hdnAddedColors']");
//                                                
//                hdnAddedColorways.val(_.without(hdnAddedColorways.val().split(";"), currentColorPaletteID).join(";"));
//            }

            function addSelectedColors() {

                $("#DataListColors").find("input[id*='chkSelectColor']:checked").each(function () {
                    var colorInfo = getColorInfo(this);
                    addColorToExisting(colorInfo, this);
                    this.checked = false;
                });

                $("#chkAllColors").removeAttr("checked");
            }

            function addColorToExisting(colorInfo, chkItem) {
                if (addColorForSaving(colorInfo)) {
                    var itemTemplate = $(chkItem).closest("#singleColorChip").siblings(".helper").clone().css('display', 'inline-block');
                    itemTemplate.find("td.font span").css("color", "Red");
                    // Renaming all the IDs and names to avoid collisions
                    itemTemplate.find("td,span,input,img").each(function () {
                        if (this.id != null && this.id != "") {
                            this.id += "_tmp_" + colorInfo.colorPaletteID;
                            this.name += "$tmp$" + colorInfo.colorPaletteID;
                        }
                    });
                    $("#DataListExisting").append(itemTemplate);
                }
            }

//            function removeColorwaysFromExisting() {
//                $("#DataListExisting input[id*='chkSelectExisting']:checked").each( function () {
//                    removeColorFromExisting(this);
//                    $(this).closest(".helper").remove();
//                });
//                $("#chkSelectExisting").removeAttr("checked")
//            }

        </script>

            
    </body>
</html>
