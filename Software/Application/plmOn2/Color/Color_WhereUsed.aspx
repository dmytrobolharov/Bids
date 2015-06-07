<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_WhereUsed.aspx.vb" Inherits="plmOnApp.Color_WhereUsed" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/lodash.js/0.10.0/lodash.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(PageLoaded)
        });
        function PageLoaded(sender, args) {
            disable_waittext_for_calendar();
            hide_wait_text();
        }    
    </script>
    <style type="text/css">
        .drag-helper {
        	display: none;
        }
        
        .slider-container {
            position: relative;
            overflow: hidden;
        }
            
        .slider-static {
            padding-right: 20px;
            overflow-x: hidden;
        }
        
        .color-chip {
        	display: block;
        	width: 50px;
        	height: 50px;
        	background-repeat:no-repeat;
        	background-position: center center;
        }
        
        .color-item {
        	float: left;
        	padding: 2px 10px 2px 2px;
        	border: 1px solid #eee;
        }
            
        #SliderHead {
            -moz-transform: rotate(90deg); 
            -webkit-transform: rotate(90deg);
            -o-transform: rotate(90deg); 
            transform: rotate(90deg); 
            writing-mode: tb-rl; 
            white-space: nowrap; 
            padding: 4px 4px 0px 3px;
            font-size: 12px; 
            font-family: Arial; 
            font-weight: bold; 
            color: White; 
            display: block;
        }
            
        #FloatDG {
            z-index: 500; 
            width: 450px; 
            position: absolute; 
            right: 0px;
            top: 0; 
            background-color: #fff;
        }
            
        #FloatDGControl {
            float: left; 
            width: 20px; 
            cursor: pointer; 
            background-color: #6699FF;
            height: 100%;
        }
            
        #FloatDGMain {
            float: left; 
            width: 430px;
            height: 100%;
            overflow: auto;
        }
        
        #DnDWatermark {
        	width: 100%;
        	text-align: center;
        	vertical-align: middle;
        	margin: 15px;
        	margin-top: 0px;
        	padding: 10px;
        	border: 1px dashed #aaa;
        	-webkit-border-radius: 5px;
        	-moz-border-radius: 5px;
        	border-radius: 5px;
        	color: #999;
        	font-size: 17px;
        }
        
         #RadGridStyles .rgMasterTable td, #RadGridMaterials .rgMasterTable td, #RadGridLinePlans .rgMasterTable td,
         #RadGridStyles .rgMasterTableAutoFit td, #RadGridMaterials .rgMasterTableAutoFit td, #RadGridLinePlans .rgMasterTableAutoFit td {
            border-color: #ddd !important;
         }
         
         #RadGridLinePlans td {
         	white-space: normal !important;
         }
         
        th.rgHeaderYPLM, th.rgHeader {
            padding: 0 0px !important;
        }
        
        .font span {
        	display: inline !important;
        }
        
        .material-image {
        	display: block;
            background-repeat: no-repeat;
        }
        
        .search-cell td {
            vertical-align: bottom !important;
        }
        
        .search-cell td td input {
        	margin-top: 1px;
        }
        
        .search-cell td td {        	
            vertical-align: top !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true">
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
    <%--<telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />--%>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
            <ClientEvents OnRequestStart="onAjaxRequestStart" OnResponseEnd="onAjaxResponseEnd" />
        </telerik:RadAjaxManager>
        
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="top">                
                <cc1:ConfirmedImageButton ID="btnClear" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE"></cc1:ConfirmedImageButton>                
            </td>
            <td>
            </td>
        </tr>
    </table>
    <div style="background-color: #cddeee; height: 10px">
    </div>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="TableHeader" cellpadding="0" cellspacing="" width="100%">
        <tr>
            <td align="center" width="10" height="25">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <%= GetSystemText("Selected Colors")%>
            </td>
            <td>
                <asp:RadioButtonList ID="rbColorOption" RepeatLayout="Flow" RepeatDirection="Horizontal" runat="server">
                </asp:RadioButtonList>
            </td>
        </tr>
    </table>
    <div class="slider-container">
        <div class="slider-static" style="overflow: auto; height: 100%;">
           <asp:UpdatePanel ID="upMain" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnColorClearAndSelect" />
                    <asp:AsyncPostBackTrigger ControlID="btnColorSelect" />
                    <asp:AsyncPostBackTrigger ControlID="rbColorOption" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" />
                    <asp:AsyncPostBackTrigger ControlID="btnRemove" />
                </Triggers>
                <ContentTemplate>
                <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanelStyle" ClientEvents-OnRequestStart="onAjaxRequestStart"
                ClientEvents-OnResponseEnd="onAjaxResponseEnd" Width="98%">
                    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
                        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                        <tr>
                            <td class="droppable" width="100%">
                                <asp:DataList ID="dlColors" runat="server" DataKeyField="ColorPaletteID" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                    <ItemStyle CssClass="color-item" Height="50px" />
                                    <ItemTemplate>
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <label style='<%# String.Format("background-image:url({0})", GetColorStreamPath("50", Eval("ColorFolderID").ToString, Eval("ColorPaletteID").ToString))%>' class="color-chip">
                                                        <asp:CheckBox ID="chkSelect" runat="server" /></label>
                                                    <asp:HiddenField ID="hdnColorPaletteID" runat="server" Value='<%# Eval("ColorPaletteID") %>' />
                                                </td>
                                                <td style="padding: 2px;">
                                                    <%# Eval("ColorCode")%><br />
                                                    <%# Eval("ColorName")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>&nbsp;
                                <asp:Panel ID="DnDWatermark" runat="server">
                                    <%= GetSystemText("Drag & Drop Colors Here")%></asp:Panel>
                            </td>
                        </tr>
                    </table>
                    <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                    
                    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0" style="padding-top: 5px;">
                        <tr>
                            <td class="search-cell">
                                <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                            </td>
                            <td valign="top" width="100%">
                                <table id="Table3" height="45">
                                    <tr>
                                        <td valign="middle">
                                            <asp:ImageButton ID="imgBtnSearch" runat="server"></asp:ImageButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                        border="0">
                        <tr valign="middle">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                            </td>                            
                            <td width="100" runat="server" id="tdThumbnail" visible="false">
                                <asp:CheckBox runat="server" ID="chbThumbnail" AutoPostBack="true" />
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgFirst" runat="server"></asp:ImageButton>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgPrevious" runat="server"></asp:ImageButton>
                            </td>
                            <td nowrap align="center" width="125">
                                <asp:Label ID="lblCounts" runat="server" CssClass="fontHead"></asp:Label>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgNext" runat="server"></asp:ImageButton>
                            </td>
                            <td width="20">
                                <asp:ImageButton ID="btnImgLast" runat="server" ToolTip="Last"></asp:ImageButton>
                            </td>
                            <td width="10">
                                &nbsp;
                            </td>
                            <td nowrap height="25">
                                <div align="left">
                                    <b>
                                        <asp:Label ID="lblRecordCount" Visible="true" runat="server"></asp:Label>&nbsp;
                                        <asp:Label ID="lblRecordFound" runat="server" />
                                    </b>
                                </div>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rbViewType" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                                    <asp:ListItem Text="Thumb View" Value="T"></asp:ListItem>
                                    <asp:ListItem Text="List View" Value="L" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td width="110" align="right">
                                <asp:Label ID="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:Label>
                            </td>
                            <td width="25">
                                <asp:DropDownList ID="ps" runat="server" CssClass="fontHead">
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="30">30</asp:ListItem>
                                    <asp:ListItem Value="40">40</asp:ListItem>
                                    <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td width="10">
                                <asp:Button ID="Button1" runat="server" CssClass="fontHead" Text="GO"></asp:Button>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="pnlStyles" runat="server">
                        <asp:PlaceHolder runat="server" ID="plhStylesGrid"></asp:PlaceHolder>                        
                        <asp:DataList ID="dlStyles" runat="server" DataKeyField="StyleID" RepeatDirection="Horizontal"
                            RepeatLayout="Flow" RepeatColumns="0" ItemStyle-VerticalAlign="Top" ItemStyle-Width="300px">
                            <ItemTemplate>
                                <table class="TableHeader" style="border: 1px solid #ccc;" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td>
                                            <cc1:BWImageButton ImageUrl='<%# GetImagePath("btn_goto.gif", Me.UserProperties.PrefLang) %>' NavigateUrl='<%# String.Format("../Planning/Planning_Folder_StyleGoTo.aspx?SID={0}&SYID={1}", Eval("StyleID").ToString, Eval("SeasonYearID").ToString) %>'
                                                WindowWidth='320' Resizable="false" ScrollBars="true" Status="true" WindowHeight='500' OnClientClick="return false;"
                                                ID="btnGoTo" runat="server" />                                            
                                        </td>
                                    </tr>
                                </table>
                                <table style="border: 1px solid gainsboro;" cellspacing="0" cellpadding="0" width="100%">
                                    <tbody>
                                        <tr>
                                            <td height="300" width="300" colspan="2">
                                                <p align="center">
                                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%#GetImageStreamPath("280", Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>' />
                                                </p>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <asp:PlaceHolder ID="phStyleInfo" runat="server"></asp:PlaceHolder>
                            </ItemTemplate>
                        </asp:DataList>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="pnlMaterial">
                        <asp:PlaceHolder runat="server" ID="plhMaterialsGrid"></asp:PlaceHolder>
                        <asp:DataList ID="dlMaterials" runat="server" RepeatDirection="Horizontal" RepeatColumns="8" EnableViewState="True"
                            DataKeyField="MaterialID">
                            <ItemStyle BorderWidth="1px" BorderStyle="Solid" BackColor="White" BorderColor="Gainsboro" VerticalAlign="Top">
                            </ItemStyle>
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                        <cc1:BWImageButton ImageUrl='<%# GetImagePath("btn_goto.gif", Me.UserProperties.PrefLang) %>' NavigateUrl='<%# String.Format("../Material/Material_Frame.aspx?MTID={0}", Eval("MaterialID").ToString) %>'
                                                WindowWidth='320' Resizable="false" ScrollBars="true" Status="true" WindowHeight='500' OnClientClick="return false;"
                                                ID="btnGoToMaterial" runat="server" /> 
                                            <asp:Label CssClass="material-image" align="left" ID="lblMaterialData" runat="server" Width='<%#ImageWidth.Value%>' Height='<%#ImageWidth.Value%>'
                                                Style='<%# String.Format("background-image:url({0});", GetImageStreamPath(ImageWidth.Value, Eval("MaterialImageVersion").ToString, Eval("MaterialImageID").ToString))%>'>
                                            </asp:Label>
                                            <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="pnlLinePlans">
                        <asp:PlaceHolder runat="server" ID="plhLinePlansGrid"></asp:PlaceHolder>                        
                    </asp:Panel>
                    </telerik:RadAjaxPanel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="FloatDG" runat="server">
            <div id="FloatDGControl">
                <span id="SliderHead">
                    <%= GetSystemText("Select Color")%></span>
            </div>
            <div id="FloatDGMain">
                <table style="background-color: #69F;" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td class="fontHead" width="100%" style="color: #fff; padding: 0 10px;" align="right">
                            <asp:Button ID="btnColorClearAndSelect" runat="server" />
                            <asp:Button ID="btnColorSelect" runat="server" />
                        </td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="upColors" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnColorClearAndSelect" />
                        <asp:AsyncPostBackTrigger ControlID="btnColorSelect" />
                    </Triggers>
                    <ContentTemplate>
                        <table cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                            <tr>
                                <td>
                                    <asp:PlaceHolder ID="plhColorSearch" runat="server" EnableViewState="False"></asp:PlaceHolder>
                                </td>
                                <td width="100%" valign="middle">
                                    <table id="Table1">
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="imgBtnColorSearch" runat="server"></asp:ImageButton>
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
                                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                                            </td>
                                            <td width="20">
                                                <asp:ImageButton ID="btnImgFirstColor" runat="server"></asp:ImageButton>
                                            </td>
                                            <td width="20">
                                                <asp:ImageButton ID="btnImgPrevColor" runat="server"></asp:ImageButton>
                                            </td>
                                            <td nowrap align="center" width="125">
                                                <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                                            </td>
                                            <td width="20">
                                                <asp:ImageButton ID="btnImgNextColor" runat="server"></asp:ImageButton>
                                            </td>
                                            <td width="20">
                                                <asp:ImageButton ID="btnImgLastColor" runat="server" ToolTip="Last"></asp:ImageButton>
                                            </td>
                                            <td width="10">
                                                &nbsp;
                                            </td>
                                            <td nowrap>
                                                <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
                                            </td>
                                            <td class="fontHead" align="right" width="110">
                                                <asp:Label ID="lblRecordsPerPage" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>                                    
                                    <asp:DataGrid ID="dgColors" runat="server" DataKeyField="ColorPaletteID" BorderStyle="Solid" BorderWidth="1px"
                                        Width="100%" AllowPaging="true" EnableViewState="true">
                                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate draggable"></AlternatingItemStyle>
                                        <ItemStyle Height="20px" CssClass="ItemTemplate draggable"></ItemStyle>
                                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                        <PagerStyle Visible="False"></PagerStyle>
                                        <Columns>
                                            <asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro">
                                                <HeaderTemplate>
                                                    <input type="checkbox" onclick="CheckAll(this, 'chkSelected')" id="chkSelectAll" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkSelected" />
                                                    <asp:HiddenField ID="hdnColorPaletteID" runat="server" Value='<%# Eval("ColorPaletteID") %>' />
                                                    <img class="drag-helper" src='<%# GetColorStreamPath("50", Eval("ColorFolderID").ToString, Eval("ColorPaletteID").ToString)%>'
                                                        alt="" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>                                            
                                        </Columns>
                                    </asp:DataGrid><asp:Label ID="lblColorSortOrder" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <input id="hiddenCurrentPage2" type="hidden" value="0" name="hiddenCurrentPage2" runat="server" />
            </div>
        </div>
    </div>
    </form>
    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>
    <script type="text/javascript" language="javascript">


        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        function BeginRequestHandler(sender, args) {
            show_wait_text();
        }

        function EndRequestHandler(sender, args) {
            hide_wait_text();
        }

        var frm = document.forms['form1'];
        function CheckAll(checkAllBox, name) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf(name) != -1)
                    e.checked = actVar;
            }
        }

        $(".slider-container").height($(document).height() - $(".slider-container").offset().top - 10);
        $("#FloatDG, #FloatDGMain").height($(document).height() - $(".slider-container").offset().top - 10);

        $("#FloatDGControl").click(function () {
            if (parseInt($("#FloatDG").css("right"), 10) == 0) {
                $("#FloatDG").animate({ right: $("#FloatDGControl").width() - $("#FloatDG").width() }, 200);
            } else {
                $("#FloatDG").animate({ right: 0 }, 200);
            }
        });
    </script>
    <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
    <script type="text/javascript" language="javascript">

    (function(){
                        var buttonsToConfirm = ["imgBtnSearch", "btnRepage", "btnImgNext", "btnImgPrevious", "btnImgLast", "btnImgFirst"],                            
                            confirmed = false;

                        window.onAjaxRequestStart = function(sender, eventArgs) {
                            show_wait_text();  
                        }
                })();

    function onAjaxResponseEnd(sender, eventArgs) {
                        hide_wait_text();
                        addScrollToTable();
                    }

        $.fn.tableScroll.defaults =
        {
            flush: true, // makes the last thead and tbody column flush with the scrollbar
            width: null, // width of the table (head, body and foot), null defaults to the tables natural width
            height: 50, // height of the scrollable area
            containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
        };

        function addScrollToTable() {
            var table = $("#dgColors").tableScroll();
            var head = document.createElement("thead");
            var body = table.find("tbody");
            //head.appendChild(table[0].rows[0]);
            body.before(head);
            var tableHeight = $("#FloatDGMain").height() - 130;
            table.tableScroll({
                height: tableHeight,
                //width: (tableHeight <= table.height() ? table.width() - 16 : null);
            });
        };


        Sys.Application.add_load(WireEvents);
        $(WireEvents);

        $("#rbColorOption :radio").change(function() { <%= GetPostBackEventReference(upMain) %>; });

        function WireEvents() {
            $(".slider-container").height($(document).height() - $(".slider-container").offset().top - 10);
            $("#FloatDG, #FloatDGMain").height($(document).height() - $(".slider-container").offset().top - 10);
            
            $(".draggable").draggable({
                helper: function () {
                    return $(this).find('.drag-helper').clone().removeClass('drag-helper').css('z-index', 9999);
                },
                cursorAt: { left: 25, top: 25 },
                snap: '.ui-droppable',
                snapMode: 'outer',
                appendTo: '.slider-static',
                delay: 0,
                distance: 5
            });

            $(".droppable").droppable({
                accept: '.draggable',
                tolerance: 'intersect',
                drop: function (event, ui) {                    
                    var ColorPaletteID = ui.draggable.find("[id*='hdnColorPaletteID']").val();
                    <%= GetPostBackEventReference(btnColorSelect, "ColorPaletteID").Replace("'ColorPaletteID'", "ColorPaletteID") %>;                    
                }
            });
            
            $(".color-item").droppable({
                greedy: true,
                accept: '.draggable',
                tolerance: 'intersect',
                drop: function (event, ui) {                    
                    var ColorPaletteID = ui.draggable.find("[id*='hdnColorPaletteID']").val() + ',' + $(this).find("[id*='hdnColorPaletteID']").val();
                    <%= GetPostBackEventReference(btnColorSelect, "ColorPaletteID").Replace("'ColorPaletteID'", "ColorPaletteID") %>;
                }
            });
        }

        function RadGrid_ColumnHidden(gridID) {
            return function(sender, eventArgs) {
                var tableColumns = $find(gridID).get_masterTableView().get_columns();
                var hiddenColumns = [];
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns(gridID, '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }
        }

        function RadGrid_ColumnShown(gridID) {
            return function(sender, eventArgs) {
                var tableColumns = $find(gridID).get_masterTableView().get_columns();
                var hiddenColumns = new Array();
                for (var i = 0; i < tableColumns.length; i++) {
                    if (tableColumns[i].get_visible() == false) {
                        hiddenColumns.push(tableColumns[i].get_uniqueName());
                    }
                }
                var strHiddenColumns = hiddenColumns.join();
                PageMethods.SaveHiddenColumns(gridID, '<%= aspxPageName %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
            }
        }

       
    </script>
</body>
</html>
