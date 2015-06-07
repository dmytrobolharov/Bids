﻿<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_FlashEdit_Material.aspx.vb" Inherits="plmOnApp.Line_List_FlashEdit_Material" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="hc1" TagName="Header" src="Line_List_Header.ascx"%>
<%@ Register TagPrefix="uc1" TagName="Line_List_FlashEdit_Material_StyleDetails" Src="Line_List_FlashEdit_Material_StyleDetails.ascx"%>
<%@ Register TagPrefix="uc2" TagName="Line_List_FlashEdit_Material_MaterialList" Src="Line_List_FlashEdit_Material_MaterialList.ascx"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Flash Edit Material</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style type="text/css">
			form {margin-bottom: 0;}
            .style-colors {
            	margin-left: 10px;
            }
            
            .style-colors td {
                position: relative !important;
                padding: 2px !important;
                overflow: visible !important;
            }
          
            .EmptyItemTemplate {
                display:none;
            }            
            
            .multi-bom
            {
                background-color: yellow;
            }
        </style>
	</head>
	<body style="background-color: White;">
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
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
        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            <ClientEvents OnRequestStart="onAjaxRequestStart" OnResponseEnd="onAjaxResponseEnd" />
        </telerik:RadAjaxManager>

        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="99%" border="0" height="30px">
		    <tr valign="middle">
				<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
				<td>
                    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" />
                    <cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE" />
                    <asp:ImageButton id="btnAdd" runat="server" OnClientClick="addSelectedMaterials(); return false;" />
					<asp:ImageButton id="btnRemove" runat="server" OnClientClick="removeMaterialsFromStyles(); return false;" />
                    <cc1:ConfirmedImageButton ID="btnInfo" runat="server" Message="NONE" CausesValidation="false" onclientclick="javascript:showHeader();return false;"/>
				    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" />
                </td>     
		    </tr>
        </table>

		<!-- Left frame-->
        <table id="resizableTable" width="100%">
            <tr>
                <td width="60%" valign="top">
                    <div style="overflow:scroll;width:100%;height:100%;" id="scrollDiv1">
                        <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelStyle" ClientEvents-OnRequestStart="onAjaxRequestStart"
                            ClientEvents-OnResponseEnd="onAjaxResponseEnd" Width="98%">
			                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" bgcolor="#ffffff">
				                <tr>
					                <td>&nbsp;<asp:Label id="lblStylesHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				                </tr>
			                </table>

                            <%--<uc1:Line_List_Header ID="Line_List_Header" runat="server" />--%>

                            <table border="0" cellspacing="0" cellpadding="0" bgcolor="white">
                                <tr>
                                    <td>
                                        <asp:placeholder id="plhStyleSearchControls" runat="server" EnableViewState="False"></asp:placeholder>
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

                            <table class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	                            border="0">
	                            <tr class="fontHead">
		                            <td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
		                            <td width="150"><asp:label id="lblSelectAllStyles" CssClass="fontHead" Runat="server">Select All</asp:label>&nbsp;<input id="chkSelectAllStyles" onclick="CheckAllStyles(this);" type="checkbox" name="checkAllStyles" /></td>
                                    <td height="25">
			                            <div align="left">&nbsp;
				                            <asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label>
                                        </div>
		                            </td>
		                            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
		                            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>					
		                            <td noWrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></td>
		                            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
		                            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
		                            <td width="10">&nbsp;</td>
		                            <td noWrap height="25">
                                        <div align="left">
                                            <strong>
                                                <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                                                <asp:label id="lblRecordFound" Runat="server" />
                                            </strong>
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
	                            </tr>
                            </table>

                            <asp:DataList runat="server" ID="DataListStyles" DataKeyField="LineFolderItemID" RepeatLayout="Flow">
                                <ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" 
                                            VerticalAlign="Top" BackColor="White" CssClass="LineFolderStyle"></ItemStyle>
                                <ItemTemplate>
                                    <table id="tbStyle" runat="server" width="100%" border="0" cellspacing="0" cellpadding="1">
                                        <tr>
                                            <td colspan="2" style="background-color:ButtonFace;" class="fontHead">
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td class="fontHead">
                                                            <asp:CheckBox runat="server" ID="chkSelectStyle" />
                                                            <asp:Label ID="lblSelectStyle" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"StyleNo").ToString() & " - " & DataBinder.Eval(Container.DataItem,"Description").ToString() %>'></asp:Label>
                                                            <asp:HiddenField ID="hdnSourceMaterials" runat="server" />
                                                            <asp:HiddenField ID="hdnAddedMaterials" runat="server" />
                                                            <asp:HiddenField ID="hdnRemovedMaterials" runat="server" />
                                                        </td>
                                                        <td style="padding-left:15px !important;">
                                                            <asp:Label ID="lblGoTo" runat="server"></asp:Label>
                                                        </td>
                                                        <td style="padding-left:5px !important;">
                                                            <asp:Label ID="lblSelectMaterials" runat="server"></asp:Label>
                                                            <asp:HiddenField ID="hdnMaterialsSelected" runat="server" Value="false" />
                                                        </td>
                                                        <td style="padding-left:5px !important;">
                                                            <asp:ImageButton ID="imgBtnShowColors" runat="server" ImageUrl="../System/Icons/icon_colorway.gif" ToolTip='<%# GetSystemText("Show Color") %>'></asp:ImageButton>
                                                        </td>
                                                        <td>
                                                            <asp:DataList runat="server" ID="dlColors" DataKeyField="ColorPaletteID" RepeatLayout="Table" RepeatDirection="Horizontal"
                                                                CssClass="style-colors" style="display:none;">
                                                                <ItemTemplate>
                                                                    <%--<asp:Image runat="server" ID="imgColor" ImageUrl='<%# GetColorStreamPath("20", Eval("ColorFolderId").ToString, Eval("ColorPaletteID").ToString) %>' />--%>
                                                                    <div runat="server" id="ColorDetails">
                                                                        <table cellspacing="0" cellpadding="0">
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Image runat="server" ID="Image1" ImageUrl='<%# GetColorStreamPath("80", Eval("ColorFolderId").ToString, Eval("ColorPaletteID").ToString) %>' />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="font">
                                                                                    <asp:Label runat="server" ID="lblColorCode" Text='<%# Eval("ColorCode") %>'></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="font">
                                                                                    <asp:Label runat="server" ID="lblColorName" Text='<%# Eval("ColorName") %>'></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:DataList>
                                                        </td>
                                                    </tr>
                                                </table>                                            
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="120" style="text-align: center;">
                                                <label for='<%# Container.FindControl("chkSelectStyle").ClientID %>' onclick="document.getElementById(this.htmlFor).click();">
                                                    <asp:ImageButton ID="imgStyleDesignSketch" runat="server" OnClientClick="return false;" Width="120"/>
                                                </label>
                                            </td>
                                            <td>
                                                <uc1:Line_List_FlashEdit_Material_StyleDetails EnableViewState="true" runat="server" ID="ctrStyleDetails" StyleID='<%# Eval("StyleID") %>' SeasonYearID='<%# Eval("ColorwaySeasonYearID").ToString %>' />
                                                <asp:PlaceHolder ID="plhDetailsControl" runat="server"></asp:PlaceHolder>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>

                        </telerik:RadAjaxPanel>
                    </div>
                </td>
                <td width="40%" valign="top">
                        <!-- Right frame -->
                        <div style="overflow:auto;width:100%;height:900px;" id="scrollDiv2">
                            <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelMaterial" ClientEvents-OnRequestStart="OnMaterialAjaxStart"
                                ClientEvents-OnResponseEnd="hide_wait_text" Width="98%">
			                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" bgcolor="#ffffff">
				                       <tr>
					                       <td><asp:Label id="lblMaterialsHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				                       </tr>
			                    </table>

                                <uc2:Line_List_FlashEdit_Material_MaterialList runat="server" ID="ctrMaterialGridList" />
                            </telerik:RadAjaxPanel>
                        </div>
                </td>
            </tr>
        </table>

        <div id="headerModal" style="display:none;">
            <table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="100%"><hc1:Header id="LineHeader" runat="server"></hc1:Header></td>
					<td>&nbsp;</td>
				</tr>
			</table>
        </div>
        <div id="color-dialog" style="display:none;width:580px;"></div>
        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
            <div id="confirm-dialog" style="display:none;"><%= GetSystemText("There are pending changes. Save before continuing?")%></div>
        </telerik:RadCodeBlock>
        </form>

		        <%--<script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>--%>
                <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
                <%--<script language="javascript" type="text/javascript" src="../System/Jscript/System.js"></script>--%>
                <script language="javascript" type="text/javascript" src="../System/Jscript/underscore-min.js"></script>
                <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
                <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.ui.core.js"></script>
                <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>
                <script language="javascript" type="text/javascript" src="../System/Jscript/colResizable-1.3.min.js"></script>
                <link href="../System/CSS/jquery-ui-1.10.3.css" type="text/css" rel="stylesheet" />
            	<script type="text/javascript" language="javascript">
            	    var frm = document.Form1;
            	    function CheckAllColors(checkAllBox) {
            	        var actVar = checkAllBox.checked;
            	        for (i = 0; i < frm.length; i++) {
            	            e = frm.elements[i];
            	            if (e.type == 'checkbox' && e.name.indexOf("chkSelectColor") != -1)
            	                e.checked = actVar;
            	        }
            	    }

            	    function CheckAllStyles(checkAllBox) {
            	        var actVar = checkAllBox.checked;
            	        for (i = 0; i < frm.length; i++) {
            	            e = frm.elements[i];
            	            if (e.type == 'checkbox' && e.name.indexOf("chkSelectStyle") != -1 && !e.disabled)
            	                e.checked = actVar;
            	        }
            	    }

                    function CheckAllMaterials(checkAllBox) {
            	        var actVar = checkAllBox.checked;
            	        for (i = 0; i < frm.length; i++) {
            	            e = frm.elements[i];
            	            if (e.type == 'checkbox' && e.name.indexOf("chkSelectMaterial") != -1)
            	                e.checked = actVar;
            	        }
            	    }

                    function OnMaterialAjaxStart() { show_wait_text(); }
                    
            	    $(document).ready(function () {
						var ieOffset = 0;
						if (navigator.userAgent.toLowerCase().indexOf('msie') != -1) { 
							ieOffset = 14;				
						}
                        $("#scrollDiv1").height($(window).height() - 10 - 27);
                        $("#scrollDiv2").height($(window).height() - 10 - 27).scrollLeft(0);
                        $("#resizableTable").height($(window).height() - 3 - 27 - ieOffset);

                        var styleList = $("#scrollDiv1");
                         $("#resizableTable").colResizable({
                            liveDrag: true,
                            minWidth: 200,
                            onResize: function () { styleList.find("div[id*='ColorFrame']").width(styleList.width() - 145); }
                        });
            	        
            	         //Resize the material divs
            	        styleList.find("div[id*='ColorFrame']").width(styleList.width() - 145);

            	    });

                    function showHeader() {

                        var $confirmDialog = $("#headerModal");
                        $confirmDialog.dialog({
                            autoOpen: false,
                            modal: true,
                            resizable: false,
                            width: 870,
                            title: '<%= GetSystemText("Line List") %>'
                
                        });
                        $("#headerExp").hide();
                        $("#divHeaderContent").show();
                        $confirmDialog.dialog('open');
                        return false;
                    }

                    $(document).delegate("[id*='imgBtnShowColors']", "click", function() {
                        var $btn = $(this),
                            dlgid = $btn.attr("id").replace("imgBtnShowColors", "dlColors");
                            
                        var dlg = $("#color-dialog").empty().append($("#" + dlgid).clone().show()).dialog({
                            autoOpen: true,
                            modal: true,
                            resizable: false,
                            height: "200px",
                            width: "580px",
                            title: '<%= GetSystemText("Style Colorways") %>',
                            open: function( event, ui ) { $("#color-dialog").width("100%").height("180px"); }
                         });
                    });


                    function hasPendingChanges() {
                        var changes = _.pluck($("input[id*='hdnAddedMaterials']"), "value")
                                        .concat(_.pluck($("input[id*='hdnRemovedMaterials']"), "value"));

                        // if you add and then remove material - the hidden fild will contain jast separators itself
                        function removeSeparator(s) { return s.replace(";", ""); }

                        return _.chain(changes).map(removeSeparator).compact().some().value();
                    };

                    (function(){
                        var buttonsToConfirm = ["imgBtnSearch", "btnRepage", "btnImgNext", "btnImgPrevious", "btnImgLast", "btnImgFirst"],                            
                            confirmed = false;

                        window.onAjaxRequestStart = function(sender, eventArgs) {
                            show_wait_text();  
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
                                open: hide_wait_text(),
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
                        Form1.__EVENTTARGET.value = ''
                        Form1.__EVENTARGUMENT.value = ''
                        hide_wait_text();
                    }

            	    /*
            	    * Selecting all the materials in the style. After setting all the checkboxes to 'on',
                    * we're saving the current state of button in hidden field, to toggle between the states
                    * every time the button is pressed.
            	    */
            	    function checkStyleMaterials(sender) {
            	        var hdnCurrentState = $(sender).parent().siblings("input[id*='hdnMaterialsSelected']");                        
            	        var dataListItem = $(sender).closest("table[id*='tbStyle']");
            	        var btnClicked = (hdnCurrentState.val() != 'true')
            	        hdnCurrentState.val(btnClicked.toString());
            	        dataListItem.find("input[id*='chbSelectMaterial']").attr('checked', btnClicked);
            	        return false;
            	    }

                    function refreshPage() {
                        <%= ClientScript.GetPostBackEventReference(New PostBackOptions(imgBtnSearch) With {.PerformValidation = False}) %>;                
                    }


            	    /*******************************************/
            	    /***** CLIENT-SIDE Material MANAGEMENT *****/
            	    /*******************************************/

            	    /*
            	    * Gets the info of the material from Material folder, which contains the given checkbox. 
                    * Returns the object with fields materialNo, materialName, materialID and backgroundImageUrl.
                    */
            	    function getMaterialInfo(sender) {
                        var strBackgroundImage = "url('" + $(sender).siblings("input[id*='hdnMaterialImageURL']").val() + "')";
            	        var strMaterialID = $(sender).siblings("input[id*='hdnMaterialID']").val();
            	        // The labels with material info have no IDs and generated via handler, so I have to just get them by index.
            	        var materialInfoSpans = $(sender).closest("tr").find("td span");
                        var chkThumb = $("input[id*='cbThumbnail']")[0].checked;
            	        var strMaterialNo = materialInfoSpans[1 + chkThumb].innerText;
            	        var strMaterialName = materialInfoSpans[2 + chkThumb].innerText;

            	        var materialInfo = {
                            materialNo: strMaterialNo,
                            materialName: strMaterialName,
                            backgroundImageUrl: strBackgroundImage,
                            materialID: strMaterialID
                        };

                        return materialInfo;
                    }

                    /* 
                    * Returns TRUE if given material is not already added to the style, or if material was just deleted, but not yet saved.
                    * Also, adds this material ID to list for saving, or removes it's ID from list for removal 
                    */
                    function addMaterialForSaving(styleCheckbox, materialInfo) {

                        var hdnSourceMaterials = $(styleCheckbox).siblings("input[id*='hdnSourceMaterials']"); // Materials, which were in the style the moment page came from server
                        var hdnAddedMaterials = $(styleCheckbox).siblings("input[id*='hdnAddedMaterials']"); // Materials, which were added to the style on the client-side
                        var hdnRemovedMaterials = $(styleCheckbox).siblings("input[id*='hdnRemovedMaterials']"); // Materials, which were removed from the style on the client-side
                        var materialGroup = $('#ctrMaterialGridList_drlMaterialCoreID').val()
                        // If current material was just removed and not yet saved, we're just removing it from the list of removed items
                        var strStyleMaterials = hdnRemovedMaterials.val();
                        var arrStyleMaterials = strStyleMaterials.split(";");
                        for (var i = 0; i < arrStyleMaterials.length; i++) {
                            if (arrStyleMaterials[i] == materialInfo.materialID) {
                                strStyleMaterials = strStyleMaterials.replace(materialInfo.materialID, "");
                                hdnRemovedMaterials.val(strStyleMaterials);
                                return true;
                            }
                        }
                        
                        // If the selected material was not removed from the style, checking, if this material was already added.
                        strStyleMaterials = hdnSourceMaterials.val();
                        if (strStyleMaterials != null && strStyleMaterials != "") {
                            strStyleMaterials += ";";
                        }
                        strStyleMaterials += hdnAddedMaterials.val();

                        arrStyleMaterials = strStyleMaterials.split(";");
                        for (var i = 0; i < arrStyleMaterials.length; i++) {
                            if (arrStyleMaterials[i] == materialInfo.materialID) {
                                return false;
                            }
                        }

                        // If the selected material was not already added to the style, adding it to the list of materials to be saved.
                        if (hdnAddedMaterials[0].value == "") {
                            hdnAddedMaterials[0].value = materialInfo.materialID + "|" + materialGroup;
                        } else {
                            hdnAddedMaterials[0].value += ";" + materialInfo.materialID + "|" + materialGroup;
                        }
                        return true;
                    }

                    /**
                    * If deleted material was just marked for adding, and not yet saved to database, we're just removing it from the list of items to add.
                    * Otherwise, we're adding it to the list of items to remove.
                    */
                    function addMaterialForRemoval(materialCheckbox) {
                        var currentStyleMaterialID = $(materialCheckbox).siblings("input[id*='hdnStyleMaterialID']").val();
                        var currentStyle = $(materialCheckbox).closest("span.LineFolderStyle");

                        var hdnRemovedMaterials = currentStyle.find("input[id*='hdnRemovedMaterials']");
                        var hdnAddedMaterials = currentStyle.find("input[id*='hdnAddedMaterials']");

                        // If current material was just added and not yet saved, we're just removing it from the list of added items
                        var strMaterialsList = hdnAddedMaterials.val();
                        var arrMaterialsList = strMaterialsList.split(";");
                        for (var i = 0; i < arrMaterialsList.length; i++) {
                            if (arrMaterialsList[i] == currentStyleMaterialID) {
                                strMaterialsList = strMaterialsList.replace(currentStyleMaterialID, "");
                                hdnAddedMaterials.val(strMaterialsList);
                                return;
                            }
                        }

                        if (hdnRemovedMaterials[0].value == "") {
                            hdnRemovedMaterials[0].value = currentStyleMaterialID;
                        } else {
                            hdnRemovedMaterials[0].value += ";" + currentStyleMaterialID;
                        }
                    }


                    /*
                    * Adds the selected materials to selected styles on client-side, without sending to server saving to database. 
                    * Creating DOM elements in data list and saving the IDs in hidden fields.
                    */
            	    function addSelectedMaterials() {
            	        var materialList = $('#ctrMaterialGridList_DataGrid1');
            	        var stylesList = $('#<%= DataListStyles.UniqueID %>');
                        
            	        var selectedMaterials = materialList.find("input[id*='chkSelectMaterial']:checked");
            	        for (var i = 0; i < selectedMaterials.length; i++) {
            	            var materialInfo = getMaterialInfo(selectedMaterials[i]);
            	            addMaterialToStyles(materialInfo);
            	            selectedMaterials[i].checked = false;
            	        }
                        
            	        // Taking the selection off the styles
            	        var selectedStyles = stylesList.find("input[id*='chkSelectStyle']:checked");
            	        for (var i = 0; i < selectedStyles.length; i++) {
            	            selectedStyles[i].checked = false;
                        }

            	        document.getElementById("chkSelectAllStyles").checked = false;
            	    }

                    /*
                    * Adds the given material to all the selected styles on client-side, without sending to server and saving changes to database.
                    */
            	    function addMaterialToStyles(materialInfo) {
            	        var stylesList = $('#<%= DataListStyles.UniqueID %>');

            	        var selectedStyles = stylesList.find("input[id*='chkSelectStyle']:checked");
            	        for (var i = 0; i < selectedStyles.length; i++) {

            	            if (addMaterialForSaving(selectedStyles[i], materialInfo)) {
            	                // Cloning the first item of the materials list, filling it with the added material info and appending it to the end of the list.
                                // I'm really sorry for the way it is done, but I couldn't come up with something better.
            	                var materialTable = $(selectedStyles[i]).closest("table[id*='tbStyle']").find("table[id*='DatalistMaterialImages']");
            	                var itemTemplate = materialTable.find("td.EmptyItemTemplate").clone().removeClass("EmptyItemTemplate");
            	                itemTemplate.find("input[id*='hdnStyleMaterialID']").val(materialInfo.materialID);
            	                itemTemplate.find("span[id*='lblMaterialNo']").text(materialInfo.materialNo).css("color", "Red");
            	                itemTemplate.find("span[id*='lblMaterialName']").text(materialInfo.materialName).css("color", "Red");
            	                itemTemplate.find("td[id*='tdImage']").css("background-image", materialInfo.backgroundImageUrl);
            	                // Renaming all the IDs and names to avoid collisions
            	                itemTemplate.find("td,span,input,img").each(function () {
            	                    if (this.id != null && this.id != "") {
            	                        this.id += "_tmp_" + materialInfo.materialID;
            	                        this.name += "$tmp$" + materialInfo.materialID;
            	                    }
            	                });
            	                materialTable.find(">tbody>tr").last().append(itemTemplate);
                            }
            	        }
            	    }

                    /**
                    * Removes the selected materials from appropriate styles on client-side, without sending to server and saving changes to database.
                    */
            	    function removeMaterialsFromStyles() {

                        var stylesList = $('#<%= DataListStyles.UniqueID %>');

                        var selectedMaterials = stylesList.find("input[id*='chbSelectMaterial']:checked");
                        for (var i = 0; i < selectedMaterials.length; i++) {
                            var mainMaterialSelected = $("#"+selectedMaterials[i].id).parent().parent().parent().parent().parent().parent().hasClass('EmptyItemTemplate');
                            if(mainMaterialSelected != true){
                                addMaterialForRemoval(selectedMaterials[i]);
                                $(selectedMaterials[i]).closest("table").parent().remove();
                            }
                        }
            	    }


                    // <![CDATA[
                    Sys.Application.add_load(WireEvents); // fix wiring for .NET ajax updatepanel
                    $(WireEvents); // handle page load wiring using jquery. This will fire on page load


                    function WireEvents() {

                        //Resize the material divs
                        var styleList = $("#scrollDiv1");
                        styleList.find("div[id*='ColorFrame']").width(styleList.width() - 145);

                        $(function () {

                            $(".draggable").draggable({
                                helper: function() {      
                                    var materialInfo = getMaterialInfo($(this).find("input[id*='chkSelectMaterial']"));  
                                    var itemTemplate = $("td.EmptyItemTemplate:first").clone().removeClass("EmptyItemTemplate");
            	                    itemTemplate.find("input[id*='hdnStyleMaterialID']").val(materialInfo.materialID);
            	                    itemTemplate.find("span[id*='lblMaterialNo']").text(materialInfo.materialNo).css("color", "Red");
            	                    itemTemplate.find("span[id*='lblMaterialName']").text(materialInfo.materialName).css("color", "Red");
            	                    itemTemplate.find("td[id*='tdImage']").css("background-image", materialInfo.backgroundImageUrl);                
                                    return $("<table></table>").append($("<tr></tr>").append(itemTemplate));
                                },
                                snap: '.ui-droppable',
                                snapMode: 'outer',
                                appendTo: 'body'
                                //delay: 0,
                                //distance: 5
                            });

                            $(".droppable").droppable({
                                accept: '.draggable',
                                tolerance: 'intersect',
                                drop: function (event, ui) {
                                    $(this).find("input[id*='chkSelectStyle']")[0].checked = true;
                                    var materialInfo = getMaterialInfo($(ui.draggable).find("input[id*='chkSelectMaterial']"));
                                    addMaterialToStyles(materialInfo);
                                    $(this).find("input[id*='chkSelectStyle']")[0].checked = false;
                                }
                            });

                        });
                    };
            // ]]>
            function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
                </script>
    </body>
</html>
