<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_FlashEdit_Color.aspx.vb" Inherits="plmOnApp.Line_List_FlashEdit_Color"  Trace="false" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Line_List_Header" Src="Line_List_Header.ascx"%>
<%@ Register TagPrefix="uc2" TagName="Line_List_FlashEdit_Color_StyleDetails" Src="Line_List_FlashEdit_Color_StyleDetails.ascx"%>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<html>
	<head>
		<title>Flash Edit Color</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet" />
		<script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        
        <style type="text/css">
			
			form {
			margin-bottom: 0;
			}
            .EmptyItemTemplate
            {
                display: none;
            }
            
            #drag-holder
            {
                height: 0;
            }
            #drag-holder, #drag-holder table
            {
                z-index: 100;
            }
            #drag-holder table td
            {
                background-color: #fff;
            }
            .multi-bom
            {
                background-color: yellow;
            }
        </style>
	</head>
	<body style="background-color: White;">
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

        <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            <ClientEvents OnRequestStart="onAjaxRequestStart" OnResponseEnd="onAjaxResponseEnd" />
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnSave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadAjaxPanelStyle" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
            <Windows>            
                <telerik:RadWindow ID="DroppedColorways" runat="server" Title="Dropped Colorways" Height="300px" Width="600px"
                    ReloadOnShow="true" ShowContentDuringLoad="false" NavigateUrl="Line_List_FlashEdit_Color_Dropped.aspx"
                    Behaviors="Close" IconUrl="../System/Icons/icon_table.gif" KeepInScreenBounds="true" Modal="true" />
            </Windows>
        </telerik:RadWindowManager>

        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" height="30px">
		    <tr valign="middle">
				<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
				<td>
                    <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />			
                    <cc1:ConfirmedImageButton ID="btnSaveClose" runat="server" Message="NONE" />
                    <asp:ImageButton id="btnAdd" runat="server" OnClientClick="addSelectedColors(); return false;" />
					<asp:ImageButton id="btnRemove" runat="server" OnClientClick="removeColorwaysFromStyles(); return false;" />
                    <cc1:confirmedimagebutton id="btnColorDrop" runat="server" Message="NONE" />
                    <cc1:ConfirmedImageButton ID="btnInfo" runat="server" Message="NONE" CausesValidation="false" onclientclick="javascript:showHeader();return false;"/>
				    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" />
                </td>     
		    </tr>
        </table>

        <table id="resizableTable" width="100%">
            <tr>
                <td width="70%" id="scrollTD1">
                <!-- Left frame-->
                <div style="overflow-y:scroll;width:100%;height:100%;" id="scrollDiv1">
                    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelStyle" ClientEvents-OnRequestStart="onAjaxRequestStart"
                        ClientEvents-OnResponseEnd="" Width="100%">
                        <div style="width:100%; height:100%; vertical-align: top;" id="StyleList" class="inner">
			                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" bgcolor="#ffffff">
				                <tr>
					                <td>&nbsp;<asp:Label id="lblStylesHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				                </tr>
			                </table>
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
		                            <td><asp:label id="lblSelectAllStyles" CssClass="fontHead" Runat="server">Select All</asp:label>&nbsp;<input id="chkSelectAllStyles" onclick="CheckAllStyles(this);" type="checkbox" name="checkAllStyles" /></td>
                                    <td height="25">
			                            <div align="left">&nbsp;
				                            <asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="10" Visible="False" Runat="server">10</asp:label></div>
		                            </td>
		                            <td width="20"><asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton></td>
		                            <td width="20"><asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton></td>					
		                            <td nowrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></td>
		                            <td width="20"><asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton></td>
		                            <td width="20"><asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton></td>
		                            <td width="10">&nbsp;</td>
		                            <td nowrap height="25">
                                        <div align="left">
                                            <strong>
                                                <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                                                <asp:label id="lblRecordFound" Runat="server" />
                                            </strong>
                                            </div>
                                    </td>
                                    <td>&nbsp;&nbsp;&nbsp;</td>
								    <td width="25">
								        <asp:dropdownlist id="ps_style" runat="server" CssClass="fontHead">
										    <asp:ListItem Value="5">5</asp:ListItem>
										    <asp:ListItem Value="10">10</asp:ListItem>
                                            <asp:ListItem Value="12" Selected="True">12</asp:ListItem>
										    <asp:ListItem Value="15">15</asp:ListItem>
										    <asp:ListItem Value="20">20</asp:ListItem>
										    <asp:ListItem Value="25">25</asp:ListItem>
										    <asp:ListItem Value="30">30</asp:ListItem>
										    <asp:ListItem Value="40">40</asp:ListItem>
										    <asp:ListItem Value="50">50</asp:ListItem>
									    </asp:dropdownlist>
								    </td>
								    <td>&nbsp;</td>
								    <td width="10"><asp:button id="btnRepageStyle" runat="server" CssClass="fontHead"></asp:button></td>
	                            </tr>
                            </table>

                            <asp:DataList runat="server" ID="DataListStyles" DataKeyField="LineFolderItemID" RepeatLayout="Flow">
                                <ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" 
                                            VerticalAlign="Top" BackColor="White" CssClass="LineFolderStyle"></ItemStyle>
                                <ItemTemplate>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="1" id="tblColorChips" runat="server">
                                        <tr>
                                            <td colspan="2" style="background-color:ButtonFace;">
                                                <asp:CheckBox runat="server" ID="chkSelectStyle"/>
                                                <asp:Label class="fontHead" ID="lblSelectStyle" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"StyleNo").ToString() & " - " & DataBinder.Eval(Container.DataItem,"Description").ToString() %>'></asp:Label>
                                                <asp:ImageButton style="margin:0 5 0 5;" ID="imgBtnGoTo" runat="server" />
                                                <asp:ImageButton ID="imgBtnSelectColors" runat="server" OnClientClick="return checkStyleColors(this);"/>
                                                <asp:ImageButton style="margin:0 5 0 5;" ID="imgBtnShowDroppedColors" runat="server" ImageUrl="../System/Icons/icon_drop.gif" ToolTip='<%# GetSystemText("Show Dropped Colors") %>' Visible = "false"></asp:ImageButton>
                                                <asp:HiddenField ID="hdnColorsSelected" runat="server" Value="false" />
                                                <asp:HiddenField ID="hdnSourceColors" runat="server" />
                                                <asp:HiddenField ID="hdnAddedColors" runat="server" />
                                                <asp:HiddenField ID="hdnRemovedColors" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="100" style="text-align: center;">
                                                <label for='<%# Container.FindControl("chkSelectStyle").ClientID %>' onclick="document.getElementById(this.htmlFor).click();">
                                                    <asp:ImageButton ID="imgStyleDesignSketch" OnClientClick="return false;" Width="100" runat="server"/>
                                                </label>
                                            </td>
                                            <td>
                                                <asp:PlaceHolder ID="plhDetailsControl" runat="server"></asp:PlaceHolder>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </telerik:RadAjaxPanel>
                </div>
                </td>

                <td width="30%">
                <!-- Right frame -->
                <div style="overflow:scroll; width:100%;height:100%;" id="scrollDiv2">
                    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelColor" ClientEvents-OnRequestStart="" ClientEvents-OnResponseEnd="" Width="100%">
                        <div style="width:100%; height:100%;" id="ColorList" class="inner">

			                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" bgcolor="#ffffff">
				                    <tr>
					                    <td>&nbsp;<asp:Label id="lblColorsHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				                    </tr>
			                    </table>

                                <!-- Color folder navigation -->

                                <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                                    <tr>
                                        <td><asp:Label ID="lblColorFolder" runat="server" class="fontHead"></asp:Label><br /><asp:DropDownList ID="drlColorFolder" runat="server" Width="120" AutoPostBack="true" class="font"></asp:DropDownList></td>
                                        <td><asp:Label ID="lblColorType" runat="server" class="fontHead"></asp:Label><br /><asp:DropDownList ID="drlColorType" runat="server" Width="120" AutoPostBack="true" class="font"></asp:DropDownList></td>
                                        <td><asp:Label ID="lblActive" runat="server" class="fontHead"></asp:Label><br /><asp:DropDownList ID="drlActive" runat="server" Width="120" AutoPostBack="true" class="font"></asp:DropDownList></td>
                                        <td valign="bottom"><asp:Label ID="lblPlanningColor" runat="server" class="fontHead"></asp:Label><asp:CheckBox id="chkPlanningColor" runat="server" Checked="true" AutoPostBack="true" /></td>
                                        <td>&nbsp;</td>
                                    </tr>
				                    <tr>
					                    <td colspan="3">
                                            <asp:placeholder id="plhColorSearchControls" runat="server" EnableViewState="False"></asp:placeholder>
                                        </td>
					                    <td width="100%" valign="bottom"><asp:imagebutton id="imgBtnSearchColor" runat="server"></asp:imagebutton></td>
				                    </tr>

			                    </table>  

                                <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
				                <tr>
					                <td align="center" width="10" height="30"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
					                <td><asp:label id="lblSelectAllColors" CssClass="fontHead" Runat="server"></asp:label>&nbsp;<input id="checkAllColors" onclick="CheckAllColors(this);" type="checkbox" name="checkAll" /></td>
				                    <td>
									        <div align="left">&nbsp;
										        <asp:label id="lblColorsCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label>
										        <asp:label id="lblColorsPageSize" Runat="server" Visible="false" Text="25"></asp:label>
                                            </div>
								        </td>
								        <td width="15">
									        <div align="center">
									            <asp:imagebutton id="btnImgColorsFirst" runat="server"></asp:imagebutton>
									        </div>
								        </td>
								        <td width="15">
									        <div align="center">
									            <asp:imagebutton id="btnImgColorsPrevious" runat="server"></asp:imagebutton>
								            </div>
								        </td>
								        <td width="150">
									        <div align="center"><asp:label id="lblColorsCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								        </td>
								        <td width="15">
									        <div align="center">
			                                    <asp:imagebutton id="btnImgColorsNext" runat="server"></asp:imagebutton>
			                                </div>
								        </td>
								        <td width="15">
			                                <div align="center">
			                                    <asp:imagebutton id="btnImgColorsLast" runat="server"></asp:imagebutton>
			                                </div>
								        </td>
								        <td>
									        <div align="left">
									            <b>
									                <asp:label id="lblColorsRecordCount" Runat="server" Visible="true"></asp:label>
									                &nbsp;
									                <asp:Label id="lblColorsRecordFound" runat="server" Text="Records Found"></asp:Label>
                                                </b>
                                            </div>
								        </td>
								        <td>&nbsp;&nbsp;&nbsp;</td>
								        <td width="25">
								            <asp:dropdownlist id="ps_color" runat="server" CssClass="fontHead">
										        <asp:ListItem Value="5">5</asp:ListItem>
										        <asp:ListItem Value="10">10</asp:ListItem>
                                                <asp:ListItem Value="12" Selected="True">12</asp:ListItem>
										        <asp:ListItem Value="15">15</asp:ListItem>
										        <asp:ListItem Value="20">20</asp:ListItem>
										        <asp:ListItem Value="25">25</asp:ListItem>
										        <asp:ListItem Value="30">30</asp:ListItem>
										        <asp:ListItem Value="40">40</asp:ListItem>
										        <asp:ListItem Value="50">50</asp:ListItem>
									        </asp:dropdownlist>
								        </td>
								        <td>&nbsp;</td>
								        <td width="10"><asp:button id="btnRepageColor" runat="server" CssClass="fontHead"></asp:button></td>
                                </tr>
			                </table>

                            <asp:datalist id="DataListColors" runat="server" EnableViewState="True" RepeatDirection="Horizontal" RepeatLayout="Flow" DataKeyField="ColorPaletteID" CellPadding="3">
					            <ItemStyle BorderWidth="1" BorderStyle="Solid" BorderColor="Gainsboro" Width="180" VerticalAlign="Top"></ItemStyle>
					            <ItemTemplate>
					                <table height="60" width="180" cellspacing="0" cellpadding="0" border="0" id="singleColorChip" class="<%#draggableClass%>">
					                    <tr valign="top">
                                            <td align="center" valign="middle" width="60">
                                                <table width="50" height="50"  cellSpacing="0" cellPadding="0" border="0">
                                                    <tr>
                                                        <td runat="server" id="tdColorImage">
                                                            <label style="width:100%; height:100%; display:block;">
					                                            <asp:CheckBox ID="chkSelectColor" Runat="server"></asp:CheckBox>
                                                                <asp:HiddenField ID="hdnColorPaletteID" runat="server" />
                                                            </label>
					                                    </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="middle" width="120"> 
					                            <asp:PlaceHolder ID="pnlHeader" runat="server" ></asp:PlaceHolder>
				                            </td>
					                    </tr>
					                </table>
					            </ItemTemplate>
				            </asp:datalist>

                        </div>
                    </telerik:RadAjaxPanel>
                </div>
                </td>
            </tr>
        </table>
        <div id="drag-holder"></div>
        <div id="headerModal" style="display:none;">
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr><td width="100%"><uc1:Line_List_Header ID="Line_List_Header" runat="server" /></td></tr>
			</table>
        </div>
        <telerik:RadCodeBlock runat="server" ID="RadCodeBlock1">
            <div id="confirm-dialog" style="display: none;">
                <%= GetSystemText("There are pending changes. Save before continuing?")%></div>
        </telerik:RadCodeBlock>
    </form>
        <script language="javascript" type="text/javascript" src="../System/Jscript/underscore-min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/colResizable-1.3.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery.ui.core.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>
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

            function hasPendingChanges() {
                var changes = _.pluck($("input[id*='hdnAddedColors']"), "value")
                                .concat(_.pluck($("input[id*='hdnRemovedColors']"), "value"));

                // if you add and then remove material - the hidden fild will contain jast separators itself
                function removeSeparator(s) { return s.replace(";", ""); }

                return _.chain(changes).map(removeSeparator).compact().some().value();
            };

            (function(){
                var buttonsToConfirm = ["imgBtnSearch", "btnRepageStyle", "btnImgNext", "btnImgPrevious", "btnImgLast", "btnImgFirst"],                            
                    confirmed = false;

                window.onAjaxRequestStart = function(sender, eventArgs) {  
                    // if confirmed request or nonconfirmable button or no pending changes then proceed as is                          
                    if (confirmed || _.indexOf(buttonsToConfirm, eventArgs.get_eventTarget()) == -1 || !hasPendingChanges()) {
                        confirmed = false;
                        if (eventArgs.get_eventTarget() == "btnSave") { var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120); show_wait_text(); busyBox.Show(); }
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
                Form1.__EVENTTARGET.value = ''
                Form1.__EVENTARGUMENT.value = ''
                hide_wait_text();
            }

            function showHeader() {

                var $confirmDialog = $("#headerModal");
                //$confirmDialog.html(' <p> <%= GetSystemText("Enter Measurement name") %> </p>' +
                // '<input type=text width="60px" name="name" id="name"');
                $confirmDialog.dialog({
                    autoOpen: false,
                    modal: true,
                    resizable: false,
                    height: 350,
                    width: 800,
                    title: '<%= GetSystemText("Line List") %>'

                });
                $("#headerExp").hide();
                $("#divHeaderContent").show();
                $confirmDialog.dialog('open');
                return false;
            }

            $(document).ready(function () {
                //window.parent.document.getElementById('frameset').cols = "0%,*";
				//alert($(window).height());
				//alert($('.TableHeader').height());
				var ieOffset = 0;
				if ($.browser.msie) { 
					ieOffset = 14;					
				}
                $("#resizableTable").height($(window).height() - 3 - 27 - ieOffset);
                $("#resizableTable").colResizable({
                    liveDrag: true,
                    minWidth: 200,
                    onResize: function () { $("div[id*=ctrStyleDetails_ColorFrame]").width($("#scrollTD1").width() - 125) }
                });
                $("div[id*=ctrStyleDetails_ColorFrame]").width($("#scrollTD1").width() - 125);

            });

            /*
            * Selecting all the color chips in the style. After setting all the checkboxes to 'on',
            * we're saving the current state of button in hidden field, to toggle between the states
            * every time the button is pressed.
            */
            function checkStyleColors(sender) {
                var hdnCurrentState = $(sender).siblings("input[id*='hdnColorsSelected']");
                var dataListItem = $(sender).closest("table[id*='tblColorChips']");
                var btnClicked = (hdnCurrentState.val() != 'true')
                hdnCurrentState.val(btnClicked.toString());
                dataListItem.find("input[id*='chbSelectColorway']:visible").attr('checked', btnClicked);
                return false;
            }

            /********** WI #17068 **********************/
            /****** CLIENT-SIDE COLOR MANAGEMENT *******/
            /*******************************************/

            /*
            * Gets the info of the color from color palette, which contains the given checkbox. 
            * Returns the object with fields colorCode, colorName, colorPaletteID and backgroundImageUrl.
            */
            function getColorInfo(sender) {
                var $sender = $(sender);
                var strBackgroundImage = $sender.closest("td[id*='tdColorImage']").css("background-image");
                var strColorPaletteID = $sender.siblings("input[id*='hdnColorPaletteID']").val();
                // The labels with color info have no IDs and generated via handler, so I have to just get them by index.
                var colorInfoSpans = $sender.closest("#singleColorChip").find("td.font span");
                var strColorCode = colorInfoSpans[0].innerText;
                var strColorName = colorInfoSpans[1].innerText;

                var colorInfo = {
                    colorCode: strColorCode,
                    colorName: strColorName,
                    backgroundImageUrl: strBackgroundImage,
                    colorPaletteID: strColorPaletteID
                };

                return colorInfo;
            }

            /* 
            * Returns TRUE if given color is not already added to the style, or if color was just deleted, but not yet saved.
            * Also, adds this color ID to list for saving, or removes it's ID from list for removal 
            */
            function addColorForSaving(styleCheckbox, colorInfo) {

                var hdnSourceColors = $(styleCheckbox).siblings("input[id*='hdnSourceColors']"); // Colors, which were in the style the moment page came from server
                var hdnAddedColors = $(styleCheckbox).siblings("input[id*='hdnAddedColors']"); // Colors, which were added to the style on the client-side
                var hdnRemovedColors = $(styleCheckbox).siblings("input[id*='hdnRemovedColors']"); // Colors, which were removed from the style on the client-side

                // If current colorway was just added and not yet saved, we're just removing it from the list of added items
                var strStyleColors = hdnRemovedColors.val();
                var arrStyleColors = strStyleColors.split(";");
                for (var i = 0; i < arrStyleColors.length; i++) {
                    if (arrStyleColors[i] == colorInfo.colorPaletteID) {
                        strStyleColors = strStyleColors.replace(colorInfo.colorPaletteID, "");
                        hdnRemovedColors.val(strStyleColors);
                        return true;
                    }
                }

                // If the selected color was not removed from the style, checking, if this color was already added.
                strStyleColors = hdnSourceColors.val();
                if (strStyleColors != null && strStyleColors != "") {
                    strStyleColors += ";";
                }
                strStyleColors += hdnAddedColors.val();

                arrStyleColors = strStyleColors.split(";");
                for (var i = 0; i < arrStyleColors.length; i++) {
                    if (arrStyleColors[i] == colorInfo.colorPaletteID) {
                        return false;
                    }
                }

                // If the selected color was not already added to the style, adding it to the list of colors to be saved.
                if (hdnAddedColors[0].value == "") {
                    hdnAddedColors[0].value = colorInfo.colorPaletteID;
                } else {
                    hdnAddedColors[0].value += ";" + colorInfo.colorPaletteID;
                }
                return true;
            }

            /**
            * If deleted colorway was just marked for adding, and not yet saved to database, we're just removing it from the list of items to add.
            * Otherwise, we're adding it to the list of items to remove.
            */
            function addColorwayForRemoval(colorwayCheckbox) {
                var currentColorPaletteID = $(colorwayCheckbox).siblings("input[id*='hdnColorPaletteID']").val();
                var currentStyle = $(colorwayCheckbox).closest("span.LineFolderStyle");

                var hdnRemovedColors = currentStyle.find("input[id*='hdnRemovedColors']");
                var hdnAddedColorways = currentStyle.find("input[id*='hdnAddedColors']");

                // If current colorway was just added and not yet saved, we're just removing it from the list of added items
                var strColorwaysList = hdnAddedColorways.val();
                var arrColorwaysList = strColorwaysList.split(";");
                for (var i = 0; i < arrColorwaysList.length; i++) {
                    if (arrColorwaysList[i] == currentColorPaletteID) {
                        strColorwaysList = strColorwaysList.replace(currentColorPaletteID, "");
                        hdnAddedColorways.val(strColorwaysList);
                        return;
                    }
                }

                if (hdnRemovedColors[0].value == "") {
                    hdnRemovedColors[0].value = currentColorPaletteID;
                } else {
                    hdnRemovedColors[0].value += ";" + currentColorPaletteID;
                }
            }

            /*
            * Adds the selected colors to selected styles on client-side, without sending to server saving to database. 
            * Creating DOM elements in data list and saving the IDs in hidden fields.
            */
            function addSelectedColors() {
                var colorList = $('#<%= DataListColors.UniqueID %>');
                var stylesList = $('#<%= DataListStyles.UniqueID %>');

                var selectedColors = colorList.find("input[id*='chkSelectColor']:checked");
                for (var i = 0; i < selectedColors.length; i++) {
                    var colorInfo = getColorInfo(selectedColors[i]);
                    addColorToStyles(colorInfo);
                    selectedColors[i].checked = false;
                }

                // Taking the selection off the styles
                var selectedStyles = stylesList.find("input[id*='chkSelectStyle']:checked");
                for (var i = 0; i < selectedStyles.length; i++) {
                    selectedStyles[i].checked = false;
                }

                document.getElementById("checkAllColors").checked = false;
            }

            /*
            * Adds the given color to all the selected styles on client-side, without sending to server and saving changes to database.
            */
            function addColorToStyles(colorInfo) {
                var stylesList = $('#<%= DataListStyles.UniqueID %>');

                var selectedStyles = stylesList.find("input[id*='chkSelectStyle']:checked");
                for (var i = 0; i < selectedStyles.length; i++) {

                    if (addColorForSaving(selectedStyles[i], colorInfo)) {
                        // Cloning the first item of the colorways list, filling it with the added color info and appending it to the end of the list.
                        // I'm really sorry for the way it is done, but I couldn't come up with something better.
                        var colorwayTable = $(selectedStyles[i]).closest("table").find("table[id*='DatalistColorwayImages']");
                        var itemTemplate = colorwayTable.find("td.EmptyItemTemplate").clone().removeClass("EmptyItemTemplate");
                        itemTemplate.find("input[id*='hdnColorPaletteID']").val(colorInfo.colorPaletteID);
                        itemTemplate.find("span[id*='lblColorNo']").text(colorInfo.colorCode).css("color", "Red");
                        itemTemplate.find("span[id*='lblColorName']").text(colorInfo.colorName).css("color", "Red");
                        itemTemplate.find("td[id*='tdImage']").css("background-image", colorInfo.backgroundImageUrl);
                        // Renaming all the IDs and names to avoid collisions
                        itemTemplate.find("td,span,input,img").each(function () {
                            if (this.id != null && this.id != "") {
                                this.id += "_tmp_" + colorInfo.colorPaletteID;
                                this.name += "$tmp$" + colorInfo.colorPaletteID;
                            }
                        });
                        colorwayTable.find(">tbody>tr").last().append(itemTemplate);
                    }
                }
            }

            /**
            * Removes the selected colorways from appropriate styles on client-side, without sending to server and saving changes to database.
            */
            function removeColorwaysFromStyles() {

                var stylesList = $('#<%= DataListStyles.UniqueID %>');

                var selectedColorways = stylesList.find("input[id*='chbSelectColorway']:checked");
                for (var i = 0; i < selectedColorways.length; i++) {
                    addColorwayForRemoval(selectedColorways[i]);
                    $(selectedColorways[i]).closest("table").parent().remove();
                }
            }

            Sys.Application.add_load(WireEvents); // fix wiring for .NET ajax updatepanel
            $(WireEvents); // handle page load wiring using jquery. This will fire on page load


            function WireEvents() {

                $("div[id*=ctrStyleDetails_ColorFrame]").width($("#scrollTD1").width() - 125);

                $(function () {
                    $(".draggable").draggable({
                        helper: 'clone',
                        snap: '.ui-droppable',
                        //snapMode: 'outer',
                        appendTo: '#drag-holder',
                        delay: 0,
                        distance: 5
                    });

                    $(".droppable").droppable({
                        accept: '.draggable',
                        tolerance: 'intersect',
                        drop: function (event, ui) {
                            $(this).find("input[id*='chkSelectStyle']")[0].checked = true;
                            var colorInfo = getColorInfo($(ui.draggable).find("input[id*='chkSelectColor']"));
                            addColorToStyles(colorInfo);
                            $(this).find("input[id*='chkSelectStyle']")[0].checked = false;
                        }
                    });

                });
            };

            function refreshPage() {
                <%= ClientScript.GetPostBackEventReference(New PostBackOptions(imgBtnSearch) With {.PerformValidation = False}) %>;                
            }

            function showDroppedColorways(strStyleBOMDimensionID) {
                window.radopen('Line_List_FlashEdit_Color_Dropped.aspx?SBDID=' + strStyleBOMDimensionID, 'DroppedColorways');
            }

        </script>

            
    </body>
</html>
