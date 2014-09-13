<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Planning_Material_WhereUsed.aspx.vb" Inherits="plmOnApp.Planning_Material_WhereUsed" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" type="text/css" rel="stylesheet"></link>
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
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
        
        .material-chip {
        	display: block;
        	width: 50px;
        	height: 50px;
        }
        
        .material-item {
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
            width: 700px; 
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
            width: 680px;
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
        
        #RadGridStyles .rgMasterTable td, #RadGridMaterials .rgMasterTable td {
            border-color: #ddd !important;
        }

        th.rgHeaderYPLM, th.rgHeader {
            padding: 0 0px !important;
        }
        
        .tablescroll table {
        	table-layout: fixed !important;
        }     
        
        .tablescroll_head td {
        	border-left: 1px solid gainsboro; 
        }   
        
        .tablescroll_wrapper {
        	overflow-x: hidden !important;
        }
    </style>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
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
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td valign="top">
                <cc1:confirmedimagebutton id="btnMaterialReplace" runat="server" message="NONE" OnClientClick="return ReplaceButtonClick();"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClear" runat="server" message="NONE"></cc1:confirmedimagebutton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;">
                </cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <div style="background-color: #cddeee; height: 10px"></div>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
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
            <td><%= GetSystemText("Selected Materials")%></td>
            <td>
                <asp:RadioButtonList ID="rbMaterialOption" RepeatLayout="Flow" RepeatDirection="Horizontal" runat="server"></asp:RadioButtonList>
            </td>
        </tr>
    </table>
    
    <div class="slider-container">
        <div class="slider-static" style="overflow: auto; height: 100%;">
            <asp:UpdatePanel ID="upMain" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnMaterialClearAndSelect" />
                    <asp:AsyncPostBackTrigger ControlID="btnMaterialSelect" />
                    <asp:AsyncPostBackTrigger ControlID="rbMaterialOption" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" />
                    <asp:AsyncPostBackTrigger ControlID="btnRemove" />
                </Triggers>                
                <ContentTemplate>
                    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
                        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                        <tr>
                            <td class="droppable" width="100%">
                                <asp:DataList ID="dlMaterials" runat="server" DataKeyField="PlanningMaterialID" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                    <ItemStyle CssClass="material-item" Height="50px" />
                                    <ItemTemplate>
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <label style='<%# String.Format("background-image:url({0})", GetImageStreamPath("50", Eval("MaterialImageVersion").ToString, Eval("MaterialImageID").ToString))%>' class="material-chip">
                                                    <asp:CheckBox ID="chkSelect" runat="server" /></label>
                                                    <asp:HiddenField ID="hdnPlanningMaterialID" runat="server" Value='<%# Eval("PlanningMaterialID") %>' />
                                                    <asp:HiddenField ID="hdnMaterialID" runat="server" Value='<%# Eval("MaterialID") %>' />
                                                </td>
                                                <td style="padding: 2px;"><%# Eval("MaterialNo")%><br /><%# Eval("MaterialName")%></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>&nbsp;
                                <asp:Panel ID="DnDWatermark" runat="server"><%= GetSystemText("Drag & Drop Materials Here")%></asp:Panel>
                            </td>
                        </tr>
                    </table>
                    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0" style="padding-top: 5px;">
                        <tr>
                            <td class="search-cell">
                                <asp:PlaceHolder ID="plhControlsHolder" runat="server" EnableViewState="False"></asp:PlaceHolder>
                            </td>
                            <td valign="middle" width="100%">
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
                    <asp:Panel ID="pnlStyles" runat="server">
                        <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                            border="0">
                            <tr valign="middle">
                                <td valign="middle" align="center" width="10">
                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
                                </td>
                                <td width="100" runat="server" id="tdCheckAll"><label><input type="checkbox" runat="server" id="chkCheckAll" onclick="CheckAll(this, 'chkStyleSelect')" /><%= GetSystemText("Select All")%></label></td>
                                <td width="100" runat="server" id="tdThumbnail" visible="false">
                                    <asp:CheckBox runat="server" id="chbThumbnail" AutoPostBack="true" />
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
                                    <asp:Label ID="lblRecordPerPage" runat="server" CssClass="fontHead" Text="Records per Page:"></asp:Label>
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
                        <asp:PlaceHolder runat="server" ID="plhStylesGrid"></asp:PlaceHolder>
                        <asp:DataGrid ID="dgStyles" runat="server" AllowSorting="True" DataKeyField="PlanningItemID" AllowPaging="true">
                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                            <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                            <PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn>
                                    <HeaderTemplate>
                                        <input type="checkbox" id="checkAll" onclick="CheckAll(this, 'chkStyleSelect');" runat="server" name="checkAll" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkStyleSelect" runat="server"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateColumn>                    
                            </Columns>
                        </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                    </asp:Panel>
                    <asp:DataList ID="dlStyles" runat="server" DataKeyField="PlanningItemID" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="<%#dlStylesColumnsCnt.ToString %>" ItemStyle-VerticalAlign="Top" ItemStyle-Width="<%#dlStylesColumnsWidth.ToString %>">
                        <ItemTemplate>
                            <table class="TableHeader" style="border: 1px solid #ccc;" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td>
                                            <cc1:BWImageButton ImageUrl='<%# GetImagePath("btn_goto.gif", Me.UserProperties.PrefLang) %>' NavigateUrl='<%# String.Format("Planning_Folder_StyleGoTo.aspx?SID={0}&SYID={1}", Eval("StyleID").ToString, Eval("SeasonYearID").ToString) %>'
                                                WindowWidth='320' Resizable="false" ScrollBars="true" Status="true" WindowHeight='500' OnClientClick="return false;" ID="btnGoTo" runat="server" />
                                            <asp:CheckBox ID="chkStyleSelect" runat="server" Text='<%# GetSystemText("Select Style") & "..." %>' />                                            
                                        </td>
                                    </tr>                                
                            </table>
                            <div style="height:20px">
                                <asp:Label runat="server" ID="lblMessage" Visible='<%# Eval("PlanningItemDrop") = "Yes" %>'>
                                    <table style="border:1px solid #ffcc66; background-color:#ffff99;" cellspacing="0" cellpadding="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <td class="font" align="center">
                                                    <%# GetSystemText("Dropped By") & " " & Eval("PlanningItemDropUser") & " " & Convert.ToDateTime(Eval("PlanningItemDropDate")).ToString(Me.GetFormatInfo.DateShortFormat)%>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Label>
                            </div>
                            <table style="border:1px solid gainsboro;" cellspacing="0" bordercolor="gainsboro" cellpadding="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td height="300" width="300" colspan="2">
                                            <p align="center">
                                                <asp:Image runat="server" ImageUrl='<%#GetImageStreamPath("280", Eval("DesignSketchVersion").ToString, Eval("DesignSketchID").ToString) %>' />
                                            </p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <asp:PlaceHolder ID="phStyleInfo" runat="server"></asp:PlaceHolder>
                        </ItemTemplate>
                    </asp:DataList>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div id="FloatDG" runat="server">
            <div id="FloatDGControl">
                <span id="SliderHead"><%= GetSystemText("Select Material")%></span>
            </div>
            <div id="FloatDGMain">
                <table style="background-color: #69F;" height="27" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td class="fontHead" width="100%" style="color: #fff; padding: 0 10px;" align="right">
                            <asp:Button ID="btnMaterialClearAndSelect" runat="server" OnClientClick="UncheckAllBox('chkSelected');"/>
                            <asp:Button ID="btnMaterialSelect" runat="server" OnClientClick="UncheckAllBox('chkSelected');"/>
                        </td>
                    </tr>
                </table>
                <asp:UpdatePanel ID="upMaterials" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <table cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
                            <tr>
                                <td>
                                    <asp:PlaceHolder ID="plhMaterialSearch" runat="server" EnableViewState="False"></asp:PlaceHolder>
                                </td>
                                <td width="100%" valign="middle">
                                    <table id="Table1">
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="imgBtnMaterialSearch" runat="server"></asp:ImageButton>
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
                                                <asp:ImageButton ID="btnImgFirstMaterial" runat="server"></asp:ImageButton>
                                            </td>
                                            <td width="20">
                                                <asp:ImageButton ID="btnImgPrevMaterial" runat="server"></asp:ImageButton>
                                            </td>
                                            <td nowrap align="center" width="125">
                                                <asp:Label ID="lblPageCount" runat="server" CssClass="fontHead"></asp:Label>
                                            </td>
                                            <td width="20">
                                                <asp:ImageButton ID="btnImgNextMaterial" runat="server"></asp:ImageButton>
                                            </td>
                                            <td width="20">
                                                <asp:ImageButton ID="btnImgLastMaterial" runat="server" ToolTip="Last"></asp:ImageButton>
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
                                    <asp:DataGrid ID="dgMaterials" runat="server" DataKeyField="PlanningMaterialID" BorderStyle="Solid" BorderWidth="1px" Width="100%" AllowPaging="true" EnableViewState="true">
                                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate draggable"></AlternatingItemStyle>
                                        <ItemStyle Height="20px" CssClass="ItemTemplate draggable"></ItemStyle>
                                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                        <PagerStyle Visible="False"></PagerStyle>
                                        <Columns>
                                            <asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro" HeaderStyle-Width="20px">
                                                <HeaderTemplate>
                                                    <input type="checkbox" onclick="CheckAll(this, 'chkSelected')" id="chkSelectAll" name="checkAll"/>
                                                </HeaderTemplate>
                                                <ItemTemplate>                                            
                                                    <asp:CheckBox runat="server" ID="chkSelected" />
                                                    <asp:HiddenField ID="hdnPlanningMaterialID" runat="server" Value='<%# Eval("PlanningMaterialID") %>' />
                                                    <asp:HiddenField ID="hdnPlanningMaterialDrop" runat="server" Value='<%# Eval("PlanningMaterialDrop") %>' />
                                                    <img class="drag-helper" src='<%# GetImageStreamPath("50", Eval("MaterialImageVersion").ToString, Eval("MaterialImageID").ToString)%>' alt="" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro" HeaderStyle-Width="20px">
                                                <HeaderTemplate>
                                                    <img src="../System/Icons/icon_drop.gif" alt="Dropped" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Image ImageUrl="../System/Icons/icon_drop.gif" AlternateText="Dropped" Visible='<%# Eval("PlanningMaterialDrop") %>'
                                                        runat="server" ID="imgDropped" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid><asp:Label ID="lblMaterialSortOrder" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <input id="hiddenCurrentPage2" type="hidden" value="0" name="hiddenCurrentPage2" runat="server" />
            </div>
        </div>
    </div>
    <div id="dialog-message" style="display: none;"><p><%= GetSystemText("Please select materials and styles before clicking the replace material button")%></p></div>

    <script type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
    <script type="text/javascript" src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>
    <script type="text/javascript" language="javascript">
        var frm = document.forms['form1'];
        function CheckAll(checkAllBox, name) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf(name) != -1)
                    e.checked = actVar;
            }
        }
        function UncheckAllBox(name) {
            var tm = setTimeout(function () {
                var frm = document.forms['form1'];
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf(name) != -1) {
                        e.checked = false;
                    }
                    if (e.type == 'checkbox') {
                        if( e.name == 'checkAll')
                            e.checked = false;
                    }
                }
                clearTimeout(tm);
            }, 2000);
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


        function ReplaceButtonClick() {
            if ($("#dlMaterials [id*='chkSelect']:checked").length > 0 & ($("#RadGridStyles [id*='columnSelectCheckBox']:checked").length > 0 || $("#dlStyles [id*='chkStyleSelect']").length > 0))
            {
                return true;
            }
            else 
            {
                ShowReplaceMessage();
                return false;                
            }
        }

        function ShowReplaceMessage () {
            $("#dialog-message").dialog({
                modal: true,
                resizable: false,
                buttons: {
                    Ok: function () {
                        $(this).dialog("close");
                    }
                }
            });
        };
    </script>
    </form>
    <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
    <script type="text/javascript">

        $.fn.tableScroll.defaults =
        {
            flush: true, // makes the last thead and tbody column flush with the scrollbar
            width: null, // width of the table (head, body and foot), null defaults to the tables natural width
            height: 50, // height of the scrollable area
            containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
        };

        function addScrollToTable() {
            var table = $("#dgMaterials");
            var head = document.createElement("thead");
            var body = table.find("tbody");
            head.appendChild(table[0].rows[0]);
            body.before(head);
            var tableHeight = $("#FloatDGMain").height() - 160;
            body.find('tr:first span').each(function(i){
                var index = body.find('tr:first td').index($(this).parent());
                $(head).find("td").eq(index).width($(this).css('width'));                 
            });

            table.tableScroll({
                height: tableHeight,
                width: (tableHeight < table.height() ? table.width() - 16 : null)
            });
        };

        addScrollToTable();

        Sys.Application.add_load(WireEvents);
        $(WireEvents);

        $("#rbMaterialOption :radio").change(function() { <%= GetPostBackEventReference(upMain) %>; });

        function WireEvents() {
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
                    var PlanningMaterialID = ui.draggable.find("[id*='hdnPlanningMaterialID']").val();
                    <%= GetPostBackEventReference(btnMaterialSelect, "PlanningMaterialID").Replace("'PlanningMaterialID'", "PlanningMaterialID") %>;
                }
            });

            $(".material-item").droppable({
                greedy: true,
                accept: '.draggable',
                tolerance: 'intersect',
                drop: function (event, ui) {
                    var PlanningMaterialID = ui.draggable.find("[id*='hdnPlanningMaterialID']").val();
                    var PlanningMaterialDropped = ui.draggable.find("[id*='hdnPlanningMaterialDrop']").val();
                    if (PlanningMaterialDropped == "0") {
                        PlanningMaterialID = PlanningMaterialID + ',' + $(this).find("[id*='hdnPlanningMaterialID']").val();
                    }
                    <%= GetPostBackEventReference(btnMaterialSelect, "PlanningMaterialID").Replace("'PlanningMaterialID'", "PlanningMaterialID") %>;
                }
            });

        }

        function RadGridStyles_ColumnHidden(sender, eventArgs) {
            var tableColumns = $find("RadGridStyles").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridStyles', '<%= aspxPageName & "?PLID=" & _PlanningID %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

        function RadGridStyles_ColumnShown(sender, eventArgs) {
            var tableColumns = $find("RadGridStyles").get_masterTableView().get_columns();
            var hiddenColumns = new Array();
            for (var i = 0; i < tableColumns.length; i++) {
                if (tableColumns[i].get_visible() == false) {
                    hiddenColumns.push(tableColumns[i].get_uniqueName());
                }
            }
            var strHiddenColumns = hiddenColumns.join();
            PageMethods.SaveHiddenColumns('RadGridStyles', '<%= aspxPageName & "?PLID=" & _PlanningID %>', strHiddenColumns, '<%= UserProperties.TeamID %>', '<%= UserProperties.Username %>');
        }

    </script>
</body>
</html>
